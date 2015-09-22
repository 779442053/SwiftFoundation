//
//  FileManager.swift
//  SwiftFoundation
//
//  Created by Alsey Coleman Miller on 6/29/15.
//  Copyright © 2015 PureSwift. All rights reserved.
//

public typealias FileSystemAttributes = statfs

public typealias FileAttributes = stat

/// Class for interacting with the file system.
public final class FileManager {
    
    // MARK: - Determining Access to Files
    
    /// Determines whether a file descriptor exists at the specified path. Can be regular file, directory, socket, etc.
    public static func itemExists(path: String) -> Bool {
        
        return (stat(path, nil) == 0)
    }
    
    /// Determines whether a file exists at the specified path.
    public static func fileExists(path: String) -> Bool {
        
        var inodeInfo = stat()
        
        guard stat(path, &inodeInfo) == 0
            else { return false }
        
        guard (inodeInfo.st_mode & S_IFMT) == S_IFREG
            else { return false }
        
        return true
    }
    
    /// Determines whether a directory exists at the specified path.
    public static func directoryExists(path: String) -> Bool {
        
        var inodeInfo = stat()
        
        guard stat(path, &inodeInfo) == 0
            else { return false }
        
        guard (inodeInfo.st_mode & S_IFMT) == S_IFDIR
            else { return false }
        
        return true
    }
    
    // MARK: - Managing the Current Directory
    
    /// Attempts to change the current directory
    public static func changeCurrentDirectory(newCurrentDirectory: String) throws {
        
        guard chdir(newCurrentDirectory) == 0
            else { throw POSIXError.fromErrorNumber! }
    }
    
    /// Gets the current directory
    public static var currentDirectory: String {
        
        let stringBufferSize = Int(PATH_MAX)
        
        let path = UnsafeMutablePointer<CChar>.alloc(stringBufferSize)
        
        defer { path.dealloc(stringBufferSize) }
        
        getcwd(path, stringBufferSize - 1)
        
        return String.fromCString(path)!
    }
    
    // MARK: - Creating and Deleting Items
    
    public static func createFile(path: String, contents: Data? = nil, attributes: FileAttributes = FileAttributes()) throws {
        
        fatalError()
    }
    
    public static func createDirectory(path: String, withIntermediateDirectories createIntermediates: Bool = false, attributes: FileAttributes = FileAttributes()) throws {
        
        if createIntermediates {
            
            fatalError("Create Intermediate Directories Not Implemented")
        }
        
        guard mkdir(path, attributes.st_mode) == 0 else {
            
            throw POSIXError.fromErrorNumber!
        }
    }
    
    public static func removeItem(path: String) throws {
        
        guard remove(path) == 0 else {
            
            throw POSIXError.fromErrorNumber!
        }
    }
    
    // MARK: - Creating Symbolic and Hard Links
    
    public static func createSymbolicLink(path: String, withDestinationPath destinationPath: String) throws {
        
        fatalError()
    }
    
    public static func linkItem(path: String, toPath destinationPath: String) throws {
        
        fatalError()
    }
    
    public static func destinationOfSymbolicLink(path: String) throws -> String {
        
        fatalError()
    }
    
    // MARK: - Moving and Copying Items
    
    public static func copyItem(sourcePath: String, toPath destinationPath: String) throws {
        
        fatalError()
    }
    
    public static func moveItem(sourcePath: String, toPath destinationPath: String) throws {
        
        fatalError()
    }
    
    // MARK: - Getting and Setting Attributes
    
    public static func attributesOfItem(path: String) throws -> FileAttributes {
        
        return try FileAttributes(path: path)
    }
    
    public static func setAttributes(attributes: FileAttributes, ofItemAtPath path: String) throws {
        
        // let originalAttributes = try self.attributesOfItem(atPath: path)
        
        fatalError("Not Implemented")
    }
    
    public static func attributesOfFileSystem(forPath path: String) throws -> FileSystemAttributes {
        
        return try FileSystemAttributes(path: path)
    }
    
    // MARK: - Getting and Comparing File Contents
    
    public static func contents(path: String) -> Data? {
        
        // get file descriptor for path
        let file = open(path)
        
        defer { fclose(file) } // close file
        
        guard fileDescriptor != nil else { return nil }
        
        // get file size
        guard let attributes = try? FileAttributes(path: path) else { return nil }
        
        let memoryPointer = UnsafeMutablePointer<Byte>.alloc(attributes)
        
        fread()
        
        
        
        return []
    }
    
}

