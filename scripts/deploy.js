const main =async()=>{
    try{
        // const nftContractFactory=await hre.ethers.getContractFactory("ChainBattels")
        const nftContractFactory=await hre.ethers.getContractFactory("ChainBattelswability")
        const nftContract=await nftContractFactory.deploy();
        await nftContract.deployed();

        console.log("Contract deployed successfully to:" + nftContract.address) ;
    process.exit(0)   }
    catch(e){
       console.log(e)
       process.exit(1);
    }
}

main();

//Contract deployed successfully to:0xE7A1CEe85e4e21a7651d39653366a4C95D65A819

//>npx hardhat run scripts/deploy.js --network mumbai
//npx hardhat verify --network mumbai 0xE7A1CEe85e4e21a7651d39653366a4C95D65A819