From: Andrew Ryder <tireman@shaw.ca>
Subject: Re: sata_sil24: swiotlb buffer is full ?
Date: Mon, 31 Oct 2016 16:14:31 -0400
Message-ID: <7ed4feb3-7783-100b-ff3e-f43c093be243@shaw.ca>
References: <8b6da1a2-ca9c-e15a-10a8-f3cda092698c@shaw.ca>
 <20161031161825.GA26364@mtj.duckdns.org>
 <20161031190918.GE15811@char.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out-no.shaw.ca ([64.59.134.12]:56629 "EHLO
        smtp-out-no.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S946284AbcJaUOQ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 31 Oct 2016 16:14:16 -0400
In-Reply-To: <20161031190918.GE15811@char.us.oracle.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org



On 10/31/2016 03:09 PM, Konrad Rzeszutek Wilk wrote:
> On Mon, Oct 31, 2016 at 10:18:25AM -0600, Tejun Heo wrote:
>> Hello,
>>
>> On Sat, Oct 29, 2016 at 11:40:29PM -0400, Andrew Ryder wrote:
>>> I have some disks attached to a "Silicon Image, Inc. SiI 3124 PCI-X Serial
>>> ATA Controller" and it repeatedly locks up the system with the message
>>> whenever there is heavy disk i/o. The system the controller is attached to
>>> is a via EPIA-M910 board.
>>>
>>> sata_sil24: 0000:06:03.0: swiotlb buffer is full: 65536 bytes)
>>> DMA: Out of SW-IOMMU space for 65536 bytes at device .."
>>> sata_sil24 0000:06:03.0: swiotlb buffer is full (sz: 65536 bytes .."
>>>
>>> For the past week I have been running with two additional boot parameters
>>> (iommu=allowdac swiotlb=131072) which seem to have solved the issue, but I
>>> was curious if this is a driver bug or not?
>
> Usually it means that the device (sta_sil24) can only handle certain
> DMA addresses and hence needs the assistance of the bounce buffers (swiotlb).
>
> Increasing the number of them is the right way to make it work.
>
> I would call this hardware limitation - if you provide the lspci -n -s 06:03.0
> one can look in the driver and see where it sets the DMA mask.

Here is the output of the lspci commad as well as one additional in case 
you need it. I've had the issue on both 3.19.8 and 4.0.4 kernels if its 
relevant.

Here is a link to the controller card also if needed?
http://www.addonics.com/products/adsa4r5.php


~ # lspci -n -s 06:03.0
06:03.0 0104: 1095:3124 (rev 02)


~ # lspci -vvvvns 06:03.0
06:03.0 0104: 1095:3124 (rev 02)
         Subsystem: 1095:7124
         Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop- 
ParErr- Stepping+ SERR+ FastB2B- DisINTx-
         Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 64, Cache Line Size: 32 bytes
         Interrupt: pin A routed to IRQ 16
         Region 0: Memory at feb77c00 (64-bit, non-prefetchable) [size=128]
         Region 2: Memory at feb78000 (64-bit, non-prefetchable) [size=32K]
         Region 4: I/O ports at ec00 [size=16]
         Expansion ROM at feb80000 [disabled] [size=512K]
         Capabilities: [64] Power Management version 2
                 Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
         Capabilities: [40] PCI-X non-bridge device
                 Command: DPERE- ERO+ RBC=512 OST=12
                 Status: Dev=ff:1f.0 64bit+ 133MHz+ SCD- USC- DC=simple 
DMMRBC=2048 DMOST=12 DMCRS=128 RSCEM- 266MHz- 533MHz-
         Capabilities: [54] MSI: Enable- Count=1/1 Maskable- 64bit+
                 Address: 0000000000000000  Data: 0000
         Kernel driver in use: sata_sil24
         Kernel modules: sata_sil24





>
>>
>> (cc'ing swiotbl maintainer, hi!)
>>
>> That looks like iotlb area running out.  I don't think there's much to
>> be done from driver side and we've traditionally been pretty bad at
>> handling iotlb errors.  Konrad, do you have any ideas?
>>
>> Thanks.
>>
>> --
>> tejun
>
