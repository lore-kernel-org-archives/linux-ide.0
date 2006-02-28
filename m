From: "kyle" <kylewong@southa.com>
Subject: translated ATA stat/err
Date: Wed, 1 Mar 2006 00:06:29 +0800
Message-ID: <00e001c63c80$eff04820$28df0f3d@kyleont8n3poyo>
Reply-To: "kyle" <kylewong@southa.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xylophone.i-cable.com ([203.83.115.99]:42491 "HELO
	xylophone.i-cable.com") by vger.kernel.org with SMTP
	id S1751824AbWB1QDi (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 28 Feb 2006 11:03:38 -0500
Received: from kyleont8n3poyo (cm61-15-223-40.hkcable.com.hk [61.15.223.40])
	by virgo.i-cable.com (8.13.5/8.13.5) with SMTP id k1SG3USL029153
	for <linux-ide@vger.kernel.org>; Wed, 1 Mar 2006 00:03:30 +0800 (CST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

Recently I have my RAID5 freeze up twice within one month, both with single
disk
failure, /dev/sda. The RAID5 doesn't go to degrade mode, all processes from
nfs clients trying to access the freezed RAID5 stuck in "D" state, the nfs
server running the RAID5 cannot be shutdown, only power button works. The
nfs server is running kernel 2.6.15.2

Actually I wonder it's really disk (sda) failure or not, I haven't test the
drive yet.  However I found something like:
Feb 27 18:26:11 images1 kernel: ata1: translated ATA stat/err 0xd0/00 to
SCSI SK/ASC/ASCQ 0xb/47/00
maybe libata problem?

/dev/sda is Hitachi T7K250 250GB SATAII running at 1.5Gb/s, connected to
motherboard onboard Nvidia 6150 chipset SATA port #1

Please CC me if possible, thanks.

lspci:
00:00.0 RAM memory: nVidia Corporation C51 Host Bridge (rev a2)
00:00.1 RAM memory: nVidia Corporation C51 Memory Controller 0 (rev a2)
00:00.2 RAM memory: nVidia Corporation C51 Memory Controller 1 (rev a2)
00:00.3 RAM memory: nVidia Corporation C51 Memory Controller 5 (rev a2)
00:00.4 RAM memory: nVidia Corporation C51 Memory Controller 4 (rev a2)
00:00.5 RAM memory: nVidia Corporation C51 Host Bridge (rev a2)
00:00.6 RAM memory: nVidia Corporation C51 Memory Controller 3 (rev a2)
00:00.7 RAM memory: nVidia Corporation C51 Memory Controller 2 (rev a2)
00:02.0 PCI bridge: nVidia Corporation C51 PCI Express Bridge (rev a1)
00:03.0 PCI bridge: nVidia Corporation C51 PCI Express Bridge (rev a1)
00:04.0 PCI bridge: nVidia Corporation C51 PCI Express Bridge (rev a1)
00:05.0 VGA compatible controller: nVidia Corporation C51 PCI Express Bridge
(rev a2)
00:09.0 RAM memory: nVidia Corporation MCP51 Host Bridge (rev a2)
00:0a.0 ISA bridge: nVidia Corporation MCP51 LPC Bridge (rev a2)
00:0a.1 SMBus: nVidia Corporation MCP51 SMBus (rev a2)
00:0a.2 RAM memory: nVidia Corporation MCP51 Memory Controller 0 (rev a2)
00:0d.0 IDE interface: nVidia Corporation MCP51 IDE (rev a1)
00:0e.0 IDE interface: nVidia Corporation MCP51 Serial ATA Controller (rev
a1)
00:0f.0 IDE interface: nVidia Corporation MCP51 Serial ATA Controller (rev
a1)
00:10.0 PCI bridge: nVidia Corporation MCP51 PCI Bridge (rev a2)
00:14.0 Bridge: nVidia Corporation MCP51 Ethernet Controller (rev a1)
00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
HyperTransport Technology Configuration
00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
AddressMap
00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM
Controller
00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
Miscellaneous Control
03:00.0 RAID bus controller: Silicon Image, Inc.: Unknown device 3132 (rev
01)
04:06.0 FireWire (IEEE 1394): Texas Instruments TSB43AB22/A IEEE-1394a-2000
Controller (PHY/Link)
04:08.0 Ethernet controller: VIA Technologies, Inc. VT6105 [Rhine-III] (rev
8b)

/var/log/message:
Feb 27 18:26:11 images1 kernel: ata1: command 0x25 timeout, stat 0xd0
host_stat 0x21
Feb 27 18:26:11 images1 kernel: ata1: translated ATA stat/err 0xd0/00 to
SCSI SK/ASC/ASCQ 0xb/47/00
Feb 27 18:26:11 images1 kernel: ata1: status=0xd0 { Busy }
Feb 27 18:26:11 images1 kernel: sd 0:0:0:0: SCSI error: return code =
0x8000002
Feb 27 18:26:11 images1 kernel: sda: Current: sense key: Aborted Command
Feb 27 18:26:11 images1 kernel:     Additional sense: Scsi parity error
Feb 27 18:26:11 images1 kernel: end_request: I/O error, dev sda, sector
44318183
Feb 27 18:26:11 images1 kernel: ATA: abnormal status 0xD0 on port 0x9F7
Feb 27 18:26:11 images1 last message repeated 2 times
Feb 27 18:26:41 images1 kernel: ata1: command 0x25 timeout, stat 0xd0
host_stat 0x21
Feb 27 18:26:41 images1 kernel: ata1: translated ATA stat/err 0xd0/00 to
SCSI SK/ASC/ASCQ 0xb/47/00
Feb 27 18:26:41 images1 kernel: ata1: status=0xd0 { Busy }
Feb 27 18:26:41 images1 kernel: sd 0:0:0:0: SCSI error: return code =
0x8000002
Feb 27 18:26:41 images1 kernel: sda: Current: sense key: Aborted Command
Feb 27 18:26:41 images1 kernel:     Additional sense: Scsi parity error
Feb 27 18:26:41 images1 kernel: end_request: I/O error, dev sda, sector
44318191
Feb 27 18:26:41 images1 kernel: ATA: abnormal status 0xD0 on port 0x9F7
Feb 27 18:26:41 images1 last message repeated 2 times
Feb 27 18:27:11 images1 kernel: ata1: command 0x25 timeout, stat 0xd0
host_stat 0x21
Feb 27 18:27:11 images1 kernel: ata1: translated ATA stat/err 0xd0/00 to
SCSI SK/ASC/ASCQ 0xb/47/00
Feb 27 18:27:11 images1 kernel: ata1: status=0xd0 { Busy }
Feb 27 18:27:11 images1 kernel: sd 0:0:0:0: SCSI error: return code =
0x8000002
Feb 27 18:27:11 images1 kernel: sda: Current: sense key: Aborted Command
Feb 27 18:27:11 images1 kernel:     Additional sense: Scsi parity error
Feb 27 18:27:11 images1 kernel: end_request: I/O error, dev sda, sector
44318199
Feb 27 18:27:11 images1 kernel: ATA: abnormal status 0xD0 on port 0x9F7
Feb 27 18:27:11 images1 last message repeated 2 times
Feb 27 18:27:23 images1 PAM-securetty[4594]: access denied: tty 'pts/0' is
not secure !
Feb 27 18:27:28 images1 login[4594]: FAILED LOGIN 1 FROM 152.101.81.89 FOR
root, Authentication failure
Feb 27 18:27:32 images1 remote(pam_unix)[4594]: session opened for user kyle
by (uid=0)
Feb 27 18:27:32 images1  -- kyle[4594]: LOGIN ON pts/0 BY kyle FROM
152.101.81.89
Feb 27 18:27:36 images1 su(pam_unix)[4619]: authentication failure; logname=
uid=500 euid=0 tty=pts/0 ruser=kyle rhost=  user=root
Feb 27 18:27:41 images1 kernel: ata1: command 0x25 timeout, stat 0xd0
host_stat 0x21
Feb 27 18:27:41 images1 kernel: ata1: translated ATA stat/err 0xd0/00 to
SCSI SK/ASC/ASCQ 0xb/47/00
Feb 27 18:27:41 images1 kernel: ata1: status=0xd0 { Busy }
Feb 27 18:27:41 images1 kernel: sd 0:0:0:0: SCSI error: return code =
0x8000002
Feb 27 18:27:41 images1 kernel: sda: Current: sense key: Aborted Command
Feb 27 18:27:41 images1 kernel:     Additional sense: Scsi parity error
Feb 27 18:27:41 images1 kernel: end_request: I/O error, dev sda, sector
44318207
Feb 27 18:27:41 images1 kernel: ATA: abnormal status 0xD0 on port 0x9F7
Feb 27 18:27:41 images1 last message repeated 2 times
Feb 27 18:27:42 images1 su(pam_unix)[4620]: session opened for user root by
(uid=500)
Feb 27 18:28:11 images1 kernel: ata1: command 0x25 timeout, stat 0xd0
host_stat 0x21
Feb 27 18:28:11 images1 kernel: ata1: translated ATA stat/err 0xd0/00 to
SCSI SK/ASC/ASCQ 0xb/47/00
Feb 27 18:28:11 images1 kernel: ata1: status=0xd0 { Busy }
Feb 27 18:28:11 images1 kernel: sd 0:0:0:0: SCSI error: return code =
0x8000002
Feb 27 18:28:11 images1 kernel: sda: Current: sense key: Aborted Command
Feb 27 18:28:11 images1 kernel:     Additional sense: Scsi parity error
Feb 27 18:28:11 images1 kernel: end_request: I/O error, dev sda, sector
44318231
Feb 27 18:28:11 images1 kernel: ATA: abnormal status 0xD0 on port 0x9F7
Feb 27 18:28:11 images1 last message repeated 2 times
Feb 27 18:28:41 images1 kernel: ata1: command 0x25 timeout, stat 0xd0
host_stat 0x21
Feb 27 18:28:41 images1 kernel: ata1: translated ATA stat/err 0xd0/00 to
SCSI SK/ASC/ASCQ 0xb/47/00
Feb 27 18:28:41 images1 kernel: ata1: status=0xd0 { Busy }
Feb 27 18:28:41 images1 kernel: sd 0:0:0:0: SCSI error: return code =
0x8000002
Feb 27 18:28:41 images1 kernel: sda: Current: sense key: Aborted Command
Feb 27 18:28:41 images1 kernel:     Additional sense: Scsi parity error
Feb 27 18:28:41 images1 kernel: end_request: I/O error, dev sda, sector
44318239
Feb 27 18:28:41 images1 kernel: ATA: abnormal status 0xD0 on port 0x9F7
Feb 27 18:28:41 images1 last message repeated 2 times
Feb 27 18:29:11 images1 kernel: ata1: command 0x25 timeout, stat 0xd0
host_stat 0x21
Feb 27 18:29:11 images1 kernel: ata1: translated ATA stat/err 0xd0/00 to
SCSI SK/ASC/ASCQ 0xb/47/00
Feb 27 18:29:11 images1 kernel: ata1: status=0xd0 { Busy }
Feb 27 18:29:11 images1 kernel: sd 0:0:0:0: SCSI error: return code =
0x8000002
Feb 27 18:29:11 images1 kernel: sda: Current: sense key: Aborted Command
Feb 27 18:29:11 images1 kernel:     Additional sense: Scsi parity error
Feb 27 18:29:11 images1 kernel: end_request: I/O error, dev sda, sector
336291503
Feb 27 18:29:11 images1 kernel: ATA: abnormal status 0xD0 on port 0x9F7
Feb 27 18:29:11 images1 last message repeated 2 times
Feb 27 18:29:35 images1 telnetd[4906]: ttloop: read: Connection reset by
peer
Feb 27 18:29:41 images1 kernel: ata1: command 0x25 timeout, stat 0xd0
host_stat 0x21
Feb 27 18:29:41 images1 kernel: ata1: translated ATA stat/err 0xd0/00 to
SCSI SK/ASC/ASCQ 0xb/47/00
Feb 27 18:29:41 images1 kernel: ata1: status=0xd0 { Busy }
Feb 27 18:29:41 images1 kernel: sd 0:0:0:0: SCSI error: return code =
0x8000002
Feb 27 18:29:41 images1 kernel: sda: Current: sense key: Aborted Command
Feb 27 18:29:41 images1 kernel:     Additional sense: Scsi parity error
Feb 27 18:29:41 images1 kernel: end_request: I/O error, dev sda, sector
336390743
Feb 27 18:29:41 images1 kernel: ATA: abnormal status 0xD0 on port 0x9F7
Feb 27 18:29:41 images1 last message repeated 2 times
Feb 27 18:30:11 images1 kernel: ata1: command 0x25 timeout, stat 0xd0
host_stat 0x21
Feb 27 18:30:11 images1 kernel: ata1: translated ATA stat/err 0xd0/00 to
SCSI SK/ASC/ASCQ 0xb/47/00
Feb 27 18:30:11 images1 kernel: ata1: status=0xd0 { Busy }
Feb 27 18:30:11 images1 kernel: sd 0:0:0:0: SCSI error: return code =
0x8000002
Feb 27 18:30:11 images1 kernel: sda: Current: sense key: Aborted Command
Feb 27 18:30:11 images1 kernel:     Additional sense: Scsi parity error
Feb 27 18:30:11 images1 kernel: end_request: I/O error, dev sda, sector
336390751
Feb 27 18:30:11 images1 kernel: ATA: abnormal status 0xD0 on port 0x9F7
Feb 27 18:30:11 images1 last message repeated 2 times
Feb 27 18:30:41 images1 kernel: ata1: command 0x25 timeout, stat 0xd0
host_stat 0x21
Feb 27 18:30:41 images1 kernel: ata1: translated ATA stat/err 0xd0/00 to
SCSI SK/ASC/ASCQ 0xb/47/00
Feb 27 18:30:41 images1 kernel: ata1: status=0xd0 { Busy }
Feb 27 18:30:41 images1 kernel: sd 0:0:0:0: SCSI error: return code =
0x8000002
Feb 27 18:30:41 images1 kernel: sda: Current: sense key: Aborted Command
Feb 27 18:30:41 images1 kernel:     Additional sense: Scsi parity error
Feb 27 18:30:41 images1 kernel: end_request: I/O error, dev sda, sector
336390759
Feb 27 18:30:41 images1 kernel: ATA: abnormal status 0xD0 on port 0x9F7
Feb 27 18:30:41 images1 last message repeated 2 times
Feb 27 18:31:11 images1 kernel: ata1: command 0x25 timeout, stat 0xd0
host_stat 0x21
Feb 27 18:31:11 images1 kernel: ata1: translated ATA stat/err 0xd0/00 to
SCSI SK/ASC/ASCQ 0xb/47/00
Feb 27 18:31:11 images1 kernel: ata1: status=0xd0 { Busy }
Feb 27 18:31:11 images1 kernel: sd 0:0:0:0: SCSI error: return code =
0x8000002
Feb 27 18:31:11 images1 kernel: sda: Current: sense key: Aborted Command
Feb 27 18:31:11 images1 kernel:     Additional sense: Scsi parity error
Feb 27 18:31:11 images1 kernel: end_request: I/O error, dev sda, sector
336390767
Feb 27 18:31:11 images1 kernel: ATA: abnormal status 0xD0 on port 0x9F7
Feb 27 18:31:11 images1 last message repeated 2 times
Feb 27 18:31:41 images1 kernel: ata1: command 0x25 timeout, stat 0xd0
host_stat 0x21
Feb 27 18:31:41 images1 kernel: ata1: translated ATA stat/err 0xd0/00 to
SCSI SK/ASC/ASCQ 0xb/47/00
Feb 27 18:31:41 images1 kernel: ata1: status=0xd0 { Busy }
Feb 27 18:31:41 images1 kernel: sd 0:0:0:0: SCSI error: return code =
0x8000002
Feb 27 18:31:41 images1 kernel: sda: Current: sense key: Aborted Command
Feb 27 18:31:41 images1 kernel:     Additional sense: Scsi parity error
Feb 27 18:31:41 images1 kernel: end_request: I/O error, dev sda, sector
336390775
Feb 27 18:31:41 images1 kernel: ATA: abnormal status 0xD0 on port 0x9F7
Feb 27 18:31:41 images1 last message repeated 2 times
Feb 27 18:32:11 images1 kernel: ata1: command 0x25 timeout, stat 0xd0
host_stat 0x21
Feb 27 18:32:11 images1 kernel: ata1: translated ATA stat/err 0xd0/00 to
SCSI SK/ASC/ASCQ 0xb/47/00
Feb 27 18:32:11 images1 kernel: ata1: status=0xd0 { Busy }
Feb 27 18:32:11 images1 kernel: sd 0:0:0:0: SCSI error: return code =
0x8000002
Feb 27 18:32:11 images1 kernel: sda: Current: sense key: Aborted Command
Feb 27 18:32:11 images1 kernel:     Additional sense: Scsi parity error
Feb 27 18:32:11 images1 kernel: end_request: I/O error, dev sda, sector
336390783
Feb 27 18:32:11 images1 kernel: ATA: abnormal status 0xD0 on port 0x9F7
Feb 27 18:32:11 images1 last message repeated 2 times
Feb 27 18:32:41 images1 kernel: ata1: command 0x25 timeout, stat 0xd0
host_stat 0x21
Feb 27 18:32:41 images1 kernel: ata1: translated ATA stat/err 0xd0/00 to
SCSI SK/ASC/ASCQ 0xb/47/00
Feb 27 18:32:41 images1 kernel: ata1: status=0xd0 { Busy }
Feb 27 18:32:41 images1 kernel: sd 0:0:0:0: SCSI error: return code =
0x8000002
Feb 27 18:32:41 images1 kernel: sda: Current: sense key: Aborted Command
Feb 27 18:32:41 images1 kernel:     Additional sense: Scsi parity error
Feb 27 18:32:41 images1 kernel: end_request: I/O error, dev sda, sector
336390791
Feb 27 18:32:41 images1 kernel: ATA: abnormal status 0xD0 on port 0x9F7
Feb 27 18:32:41 images1 last message repeated 2 times
Feb 27 18:32:44 images1 su(pam_unix)[4620]: session closed for user root
Feb 27 18:32:45 images1 remote(pam_unix)[4594]: session closed for user kyle
Feb 27 18:33:11 images1 kernel: ata1: command 0x25 timeout, stat 0xd0
host_stat 0x21
Feb 27 18:33:11 images1 kernel: ata1: translated ATA stat/err 0xd0/00 to
SCSI SK/ASC/ASCQ 0xb/47/00
Feb 27 18:33:11 images1 kernel: ata1: status=0xd0 { Busy }
Feb 27 18:33:11 images1 kernel: sd 0:0:0:0: SCSI error: return code =
0x8000002
Feb 27 18:33:11 images1 kernel: sda: Current: sense key: Aborted Command
Feb 27 18:33:11 images1 kernel:     Additional sense: Scsi parity error
Feb 27 18:33:11 images1 kernel: end_request: I/O error, dev sda, sector
336390799
Feb 27 18:33:11 images1 kernel: ATA: abnormal status 0xD0 on port 0x9F7
Feb 27 18:33:11 images1 last message repeated 2 times
Feb 27 18:33:41 images1 kernel: ata1: command 0x25 timeout, stat 0xd0
host_stat 0x21
Feb 27 18:33:41 images1 kernel: ata1: translated ATA stat/err 0xd0/00 to
SCSI SK/ASC/ASCQ 0xb/47/00
Feb 27 18:33:41 images1 kernel: ata1: status=0xd0 { Busy }
Feb 27 18:33:41 images1 kernel: sd 0:0:0:0: SCSI error: return code =
0x8000002
Feb 27 18:33:41 images1 kernel: sda: Current: sense key: Aborted Command
Feb 27 18:33:41 images1 kernel:     Additional sense: Scsi parity error
Feb 27 18:33:41 images1 kernel: end_request: I/O error, dev sda, sector
336390807
Feb 27 18:33:41 images1 kernel: ATA: abnormal status 0xD0 on port 0x9F7
Feb 27 18:33:41 images1 last message repeated 2 times
Feb 27 18:34:11 images1 kernel: ata1: command 0x25 timeout, stat 0xd0
host_stat 0x21
Feb 27 18:34:11 images1 kernel: ata1: translated ATA stat/err 0xd0/00 to
SCSI SK/ASC/ASCQ 0xb/47/00
Feb 27 18:34:11 images1 kernel: ata1: status=0xd0 { Busy }
Feb 27 18:34:11 images1 kernel: sd 0:0:0:0: SCSI error: return code =
0x8000002
Feb 27 18:34:11 images1 kernel: sda: Current: sense key: Aborted Command
Feb 27 18:34:11 images1 kernel:     Additional sense: Scsi parity error
Feb 27 18:34:11 images1 kernel: end_request: I/O error, dev sda, sector
336390815
Feb 27 18:34:11 images1 kernel: ATA: abnormal status 0xD0 on port 0x9F7
Feb 27 18:34:11 images1 last message repeated 2 times
Feb 27 18:34:41 images1 kernel: ata1: command 0x25 timeout, stat 0xd0
host_stat 0x21
Feb 27 18:34:41 images1 kernel: ata1: translated ATA stat/err 0xd0/00 to
SCSI SK/ASC/ASCQ 0xb/47/00
Feb 27 18:34:41 images1 kernel: ata1: status=0xd0 { Busy }
Feb 27 18:34:41 images1 kernel: sd 0:0:0:0: SCSI error: return code =
0x8000002
Feb 27 18:34:41 images1 kernel: sda: Current: sense key: Aborted Command
Feb 27 18:34:41 images1 kernel:     Additional sense: Scsi parity error
Feb 27 18:34:41 images1 kernel: end_request: I/O error, dev sda, sector
336390823
Feb 27 18:34:41 images1 kernel: ATA: abnormal status 0xD0 on port 0x9F7
Feb 27 18:34:41 images1 last message repeated 2 times
Feb 27 18:35:11 images1 kernel: ata1: command 0x25 timeout, stat 0xd0
host_stat 0x21
Feb 27 18:35:11 images1 kernel: ata1: translated ATA stat/err 0xd0/00 to
SCSI SK/ASC/ASCQ 0xb/47/00
Feb 27 18:35:11 images1 kernel: ata1: status=0xd0 { Busy }
Feb 27 18:35:11 images1 kernel: sd 0:0:0:0: SCSI error: return code =
0x8000002
Feb 27 18:35:11 images1 kernel: sda: Current: sense key: Aborted Command
Feb 27 18:35:11 images1 kernel:     Additional sense: Scsi parity error
Feb 27 18:35:11 images1 kernel: end_request: I/O error, dev sda, sector
336390831
Feb 27 18:35:11 images1 kernel: ATA: abnormal status 0xD0 on port 0x9F7
Feb 27 18:35:11 images1 last message repeated 2 times
Feb 27 18:35:41 images1 kernel: ata1: command 0x25 timeout, stat 0xd0
host_stat 0x21
Feb 27 18:35:41 images1 kernel: ata1: translated ATA stat/err 0xd0/00 to
SCSI SK/ASC/ASCQ 0xb/47/00
Feb 27 18:35:41 images1 kernel: ata1: status=0xd0 { Busy }
Feb 27 18:35:41 images1 kernel: sd 0:0:0:0: SCSI error: return code =
0x8000002
Feb 27 18:35:41 images1 kernel: sda: Current: sense key: Aborted Command
Feb 27 18:35:41 images1 kernel:     Additional sense: Scsi parity error
Feb 27 18:35:41 images1 kernel: end_request: I/O error, dev sda, sector
336390839
Feb 27 18:35:41 images1 kernel: ATA: abnormal status 0xD0 on port 0x9F7
Feb 27 18:35:41 images1 last message repeated 2 times
Feb 27 18:36:11 images1 kernel: ata1: command 0x25 timeout, stat 0xd0
host_stat 0x21
Feb 27 18:36:11 images1 kernel: ata1: translated ATA stat/err 0xd0/00 to
SCSI SK/ASC/ASCQ 0xb/47/00
Feb 27 18:36:11 images1 kernel: ata1: status=0xd0 { Busy }
Feb 27 18:36:11 images1 kernel: sd 0:0:0:0: SCSI error: return code =
0x8000002
Feb 27 18:36:11 images1 kernel: sda: Current: sense key: Aborted Command
Feb 27 18:36:11 images1 kernel:     Additional sense: Scsi parity error
Feb 27 18:36:11 images1 kernel: end_request: I/O error, dev sda, sector
336390847
Feb 27 18:36:11 images1 kernel: ATA: abnormal status 0xD0 on port 0x9F7
Feb 27 18:36:11 images1 last message repeated 2 times
..........................
..........................
..........................
Feb 27 19:46:12 images1 kernel: ata1: command 0x25 timeout, stat 0xd0
host_stat 0x21
Feb 27 19:46:12 images1 kernel: ata1: translated ATA stat/err 0xd0/00 to
SCSI SK/ASC/ASCQ 0xb/47/00
Feb 27 19:46:12 images1 kernel: ata1: status=0xd0 { Busy }
Feb 27 19:46:12 images1 kernel: sd 0:0:0:0: SCSI error: return code =
0x8000002
Feb 27 19:46:12 images1 kernel: sda: Current: sense key: Aborted Command
Feb 27 19:46:12 images1 kernel:     Additional sense: Scsi parity error
Feb 27 19:46:12 images1 kernel: end_request: I/O error, dev sda, sector
336391695
Feb 27 19:46:12 images1 kernel: ATA: abnormal status 0xD0 on port 0x9F7
Feb 27 19:46:12 images1 last message repeated 2 times
Feb 27 19:46:14 images1 shutdown: shutting down for system reboot
Feb 27 19:46:40 images1 login(pam_unix)[5137]: session opened for user root
by (uid=0)
Feb 27 19:46:41 images1  -- root[5137]: ROOT LOGIN ON tty3
Feb 27 19:46:42 images1 kernel: ata1: command 0x25 timeout, stat 0xd0
host_stat 0x21
Feb 27 19:46:42 images1 kernel: ata1: translated ATA stat/err 0xd0/00 to
SCSI SK/ASC/ASCQ 0xb/47/00
Feb 27 19:46:42 images1 kernel: ata1: status=0xd0 { Busy }
Feb 27 19:46:42 images1 kernel: sd 0:0:0:0: SCSI error: return code =
0x8000002
Feb 27 19:46:42 images1 kernel: sda: Current: sense key: Aborted Command
Feb 27 19:46:42 images1 kernel:     Additional sense: Scsi parity error
Feb 27 19:46:42 images1 kernel: end_request: I/O error, dev sda, sector
336391703
Feb 27 19:46:42 images1 kernel: ATA: abnormal status 0xD0 on port 0x9F7
.....................................
Cannot shutdown, power off.

Thanks a lot,
Kyle


