From: Andrew Ryder <tireman@shaw.ca>
Subject: sata_sil24: swiotlb buffer is full ?
Date: Sat, 29 Oct 2016 23:40:29 -0400
Message-ID: <8b6da1a2-ca9c-e15a-10a8-f3cda092698c@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out-no.shaw.ca ([64.59.134.9]:52194 "EHLO
        smtp-out-no.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755797AbcJ3DsW (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 29 Oct 2016 23:48:22 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello,

I have some disks attached to a "Silicon Image, Inc. SiI 3124 PCI-X 
Serial ATA Controller" and it repeatedly locks up the system with the 
message whenever there is heavy disk i/o. The system the controller is 
attached to is a via EPIA-M910 board.

sata_sil24: 0000:06:03.0: swiotlb buffer is full: 65536 bytes)
DMA: Out of SW-IOMMU space for 65536 bytes at device .."
sata_sil24 0000:06:03.0: swiotlb buffer is full (sz: 65536 bytes .."

For the past week I have been running with two additional boot 
parameters (iommu=allowdac swiotlb=131072) which seem to have solved the 
issue, but I was curious if this is a driver bug or not?

Thanks,
Andrew
