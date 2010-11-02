From: David Shaw <dshaw@jabberwocky.com>
Subject: Hyper-V and IDE disks > 128GB
Date: Tue, 2 Nov 2010 14:52:28 -0400
Message-ID: <12CD8E2D-64F0-46D6-8ACB-C411D7BECEE7@jabberwocky.com>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from walrus.jabberwocky.com ([173.9.29.57]:46825 "EHLO
	walrus.jabberwocky.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752434Ab0KBTNJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 2 Nov 2010 15:13:09 -0400
Received: from dshaw.nasuni.net (gw-comcast1.nasuni.com [173.166.63.186])
	(authenticated bits=0)
	by walrus.jabberwocky.com (8.14.3/8.14.3) with ESMTP id oA2IqTup011174
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO)
	for <linux-ide@vger.kernel.org>; Tue, 2 Nov 2010 14:52:29 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello,

I am seeing some rather odd behavior when using Linux (I've tried 2.6.30.10, 2.6.34.7, and 2.6.35.6, all with the same results) under the Hyper-V virtualization platform.  Specifically, the virtual IDE disks probe as "ATA-0", which seems to turn off 48-bit LBA, thus capping the disk size at 128GB.

This seems to have worked properly (at least in the sense that the full size of the disk was visible) on kernel 2.6.27.41.  See http://www.serverphorums.com/read.php?12,79638

In any event, this is how the virtual disk shows up at boot:

Oct 15 11:06:06 localhost kernel: ata1.01: ATA-0: Virtual HD, 1.1.0, max MWDMA2
Oct 15 11:06:06 localhost kernel: ata1.01: 267382800 sectors, multi 128: LBA

hdparm -I /dev/sdb says:

/dev/sdb:

ATA device, with non-removable media
	Model Number:       Virtual HD                              
	Serial Number:      
	Firmware Revision:  1.1.0   
Standards:
	Likely used: 2
Configuration:
	Logical		max	current
	cylinders	16383	65535
	heads		16	16
	sectors/track	63	255
	--
	bytes/track: 65024	bytes/sector: 512
	CHS current addressable sectors:  267382800
	LBA    user addressable sectors:  267382800
	Logical/Physical Sector size:           512 bytes
	device size with M = 1024*1024:      130558 MBytes
	device size with M = 1000*1000:      136899 MBytes (136 GB)
	cache/buffer size  = 64 KBytes (type=DualPortCache)
Capabilities:
	LBA, IORDY(can be disabled)
	Buffer size: 64.0kB
	Standby timer values: spec'd by Vendor
	R/W multiple sector transfer: Max = 128	Current = 128
	DMA: sdma0 sdma1 sdma2 mdma0 mdma1 *mdma2 
	     Cycle time: min=120ns recommended=120ns
	PIO: pio0 pio1 pio2 pio3 pio4 
	     Cycle time: no flow control=333ns  IORDY flow control=120ns

Can someone suggest a direction to go in next?

Thanks very much,

David

