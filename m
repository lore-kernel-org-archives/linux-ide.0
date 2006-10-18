From: Jiri Kosina <jikos@jikos.cz>
Subject: sata_mv problems on Marvell MV88SX5081
Date: Wed, 18 Oct 2006 13:19:40 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0610181258330.29022@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from twin.jikos.cz ([213.151.79.26]:43973 "EHLO twin.jikos.cz")
	by vger.kernel.org with ESMTP id S1751466AbWJRLUp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Oct 2006 07:20:45 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>

Hi,

I have this piece:

01:06.0 SCSI storage controller: Marvell Technology Group Ltd. MV88SX5081 
8-port SATA I PCI-X Controller (rev 03)

It's RocketRAID 1820A controller.

With sata_mv libata driver from 2.6.18, I am getting a load of these:

Buffer I/O error on device sda1, logical block 122126336

After a few minutes of using the device, the filesystem gets corrupted - 
write()s to some directories start returning -EIO, kernel gives

EXT2-fs error (device sda1): read_inode_bitmap: Cannot read inode bitmap - block_group = 10664, inode_bitmap = 349437953

etc. 

The proprietary open-source driver from 
http://www.highpoint-tech.com/USA/bios_rr1820a.htm doesn't seem to have 
this problem and works well so it's likely not a HW problem.

-- 
Jiri Kosina
