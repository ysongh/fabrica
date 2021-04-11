/* ---------README------------
TODO: fix the error on line 76
----------------------------*/

pragma solidity ^0.6.6; // patrick advises to use this version. This is a stable and well documented one.

// OpenZepplin ERC20 and Ownable. (for Solidity 0.6.0 to 0.8.0)
// import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/solc-0.6/contracts/access/Ownable.sol"; add it later
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/solc-0.6/contracts/token/ERC20/ERC20.sol";

// Contract for the FAB token (add ownable later)
contract Fabrica is ERC20 {
    
    
    // basic constructor, the token will have "fabrica" as name and "FAB" as symbol.
    // an initial supply of tokens will be created and sent to the deployer's address.
    // warning: if you want the initial supply to be 1 FAB token, you need to write (1* 10**18)
    constructor(uint256 initialSupply) ERC20("fabrica", "FAB") public { // add the Ownable() constructot later
        _mint(msg.sender, initialSupply * 10**18);
    }
    
    
    // each post has a unique id, this id needs to be incremented after each post
    uint256 public currentId = 0; // can be seen as the number of posts
    uint256 public postId;
    
    
    // All the data contained in the posts
    // id: unique identifier of the post
    // conent: private data of the post
    // title: title of the post
    // user: the eth address of the poster
    // unlocked: nb of times the post was unlocked / seen
    // likes: nb of times a post was considered valuable and the owner recieved tokens
    struct Post {
        uint256 id;
        address user;
        string title;
        string content;
        uint256 nbUnlocked;
        uint256 nbLikes;
        address[] whoUnlocked; // a list of addresses that unlocked the post
        address[] whoLiked; // a list of addresses that liked the post
    }


    // a user has an address and a username
    struct User {
        address user;
        string userName;
        uint256[] posts; // the id of all the user's posts
    }


    // mappings
    
    mapping (uint256 => Post) public idToPost;
    mapping (address => string) public addressToName;

    
    
    // events
    event NewPost(uint256 postId, string postDescription);
    event NewLike(uint256 postId, address user, uint256 nblikes);
    event NewUser(address user, string name);
    

    
    // the function will create a newPost of type post, insert all the required infos in it, store it on chain and link it with mappings
    // it will return the id of the post and emit the NewPost event.
    function createPost(string calldata _postTitle, string calldata _postContent) external returns (uint256) {
        uint256 _postId = currentId;
        currentId++;
        
        // Create a Post and filling id, user, title, content, nbUnlocked, nbLikes and 2 empty arrays for whoUnlocked and whoLiked
        Post memory newPost = Post(_postId, msg.sender, _postTitle, _postContent, 0, 0, new address[](0), new address[](0));

        idToPost[_postId] = newPost;
        
        emit NewPost(_postId, _postTitle);
        return _postId;
    }
    
    
    // (temporary function) returns the content of a post
    function unlockPost(uint256 _postId) public view returns (string memory) {
        return idToPost[_postId].content;
    }
    
    
    // simply returns the username given an address
    function getUserName(address _user) public view returns (string memory) {
        return addressToName[_user];
    }
    
    
}

// "SPDX-License-Identifier: FREE"
