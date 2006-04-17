From: Onis <onion@virasto.com>
Subject: sata_mv: ata5: Entering mv_eng_timeout
Date: Mon, 17 Apr 2006 03:43:13 +0300
Message-ID: <20060417004313.GA27567@virasto.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from virasto.com ([212.213.212.50]:40836 "EHLO virasto.com")
	by vger.kernel.org with ESMTP id S1750896AbWDQAn2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 16 Apr 2006 20:43:28 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi!

I'm getting following kernel messages during "heavy load" (xfs_fsr). It's
always the same port (ata5). sata_mv seems to get over these errors just
fine and my raid5 stays ok. Are these messages something to worry about?

dmesg
-----
ata5: Entering mv_eng_timeout
mmio_base ffffc20000080000 ap ffff81003ea3bc80 qc ffff81003ea3bde8 scsi_cmnd
ffff81002489e340 &cmnd ffff81002489e3b0
ata5: no device found (phy stat 00000100)
ata5: status=0x50 { DriveReady SeekComplete }
ata5: error=0x01 { AddrMarkNotFound }
sde: Current: sense key=0x0
    ASC=0x0 ASCQ=0x0
    
System
------
* Tyan Thunder S2882 Dual Opteron 240
* Marvell Technology Group Ltd. MV88SX6081 8-port SATA II PCI-X Controller
(rev 09) (Supermicro)
* 8 x Maxtor Maxline III 300GB SATA
* Debian Sarge AMD64
* kernel 2.6.17-rc1-git7 + xfs "remount,ro" patch

Please CC, I'm not on the list. Thanks!

- Onion
