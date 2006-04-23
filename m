From: Onis <onion@virasto.com>
Subject: sata_mv: ataX: no device found (phy stat 00000000)
Date: Sun, 23 Apr 2006 14:36:57 +0300
Message-ID: <20060423113657.GA8814@virasto.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from virasto.com ([212.213.212.50]:53636 "EHLO virasto.com")
	by vger.kernel.org with ESMTP id S1751359AbWDWLhA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 23 Apr 2006 07:37:00 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi!

Yesterday I got my sata_mv raid5 array trashed :( Array was not under heavy
load. Just typical rsync over internet.

dmesg
-----
ata4: no device found (phy stat 00000000)
ata4: no device found (phy stat 00000000)
ata4: status=0x7f { DriveReady DeviceFault SeekComplete DataRequest CorrectedError Index Error }
sd 3:0:0:0: SCSI error: return code = 0x8000002
sdd: Current: sense key=0x4
    ASC=0x0 ASCQ=0x0
end_request: I/O error, dev sdd, sector 375881023
sd 3:0:0:0: SCSI error: return code = 0x40000
end_request: I/O error, dev sdd, sector 375881031
sd 3:0:0:0: SCSI error: return code = 0x40000
end_request: I/O error, dev sdd, sector 375881039
sd 3:0:0:0: SCSI error: return code = 0x40000
end_request: I/O error, dev sdd, sector 375881047
...
ata3: no device found (phy stat 00000000)
ata7: no device found (phy stat 00000000)
ata7: no device found (phy stat 00000000)
ata7: status=0x7f { DriveReady DeviceFault SeekComplete DataRequest CorrectedError Index Error }
sd 6:0:0:0: SCSI error: return code = 0x8000002
sdg: Current: sense key=0x4
    ASC=0x0 ASCQ=0x0
end_request: I/O error, dev sdg, sector 375966783
raid5: read error not correctable.
...
-----

Also I'm getting these messages during some i/o load (xfs_fsr and md_raid5
recovery). Are these related?

-----
ata5: Entering mv_eng_timeout
mmio_base ffffc20000080000 ap ffff81003ea3bc80 qc ffff81003ea3bde8 scsi_cmnd
ffff81002489e340 &cmnd ffff81002489e3b0
ata5: no device found (phy stat 00000100)
ata5: status=0x50 { DriveReady SeekComplete }
ata5: error=0x01 { AddrMarkNotFound }
sde: Current: sense key=0x0
    ASC=0x0 ASCQ=0x0
-----

System
------
* kernel 2.6.17-rc2 + xfs "remount,ro" patch
* Tyan Thunder S2882 Dual Opteron 240
* Marvell Technology Group Ltd. MV88SX6081 8-port SATA II PCI-X Controller
(rev 09) (Supermicro, Firmware 1.0b)
* 8 x Maxtor Maxline III 300GB SATA
* Debian Sarge AMD64
* /var/log/messages: http://virasto.com/sata_mv/messages
* Kernel .config:  http://virasto.com/sata_mv/2.6.17-rc2-01.conf

- Onion
