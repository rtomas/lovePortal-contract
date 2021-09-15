async function main() {
    const [owner, randoPerson] = await hre.ethers.getSigners();

    const loveContractFactory = await hre.ethers.getContractFactory("LovePortal");
    const loveContract = await loveContractFactory.deploy({ value: hre.ethers.utils.parseEther("0.1") });

    await loveContract.deployed();

    console.log("Contract deployed to:", loveContract.address);
    console.log("Contract deployed by:", owner.address);

    let loveCount;
    loveCount = await loveContract.getTotalLoves();

    let loveTxn = await loveContract.sendLove("12345");
    await loveTxn.wait();

    loveCount = await loveContract.getTotalLoves();

    loveTxn = await loveContract.connect(randoPerson).sendLove("text");
    await loveTxn.wait();

    loveCount = await loveContract.getTotalLoves();

    contractBalance = await hre.ethers.provider.getBalance(loveContract.address);
    console.log("Contract Balance:", hre.ethers.utils.formatEther(contractBalance));

    let allWaves = await loveContract.getAllLoves();
    console.log(allWaves);
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });