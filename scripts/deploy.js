async function main() {
  const [ deployer]= await ethers.getSigners();
  const eventOrg = await ethers.getContractFactory("eventOrg");
  const eventorg = await eventOrg.deploy();
  console.log("Contract Deployed to Address:", eventorg.address);
}
main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });