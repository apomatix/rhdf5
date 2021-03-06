library(rhdf5)

############################################################
context("H5: basic HDF5 functions")
############################################################

test_that("General library functions", {

    expect_silent( H5open() )
    expect_silent( H5garbage_collect() )
    #expect_silent( H5close() )
    expect_is( H5get_libversion(), "integer" ) %>%
        expect_named( c("majnum", "minnum", "relnum") )
})

############################################################
context("H5: closing everything")
############################################################

h5File <- tempfile(pattern = "H5L_", fileext = ".h5")
if(file.exists(h5File))
    file.remove(h5File)

test_that("H5closeAll", {
  
    ## file
    fid <- H5Fcreate( h5File )
    ## dataspace
    sid <- H5Screate_simple( c(10,5,3) )
    ## dataset
    did <- H5Dcreate( fid, name = "dataset", dtype = "H5T_NATIVE_INT8", h5space = sid )
    ## group
    gid <- H5Gcreate( fid, name = "group" )
    ## property list
    ## attribute
    ## object
    
    expect_equal( nrow(h5listIdentifier()), 4 )
    
    expect_silent( h5closeAll() )
    
    ## should be nothing left open
    expect_equal( nrow(h5listIdentifier()), 0 )
})