From: Bob Stewart <bob@evoria.net>
Subject: Re: sata_inic162x driver for 2.6.19
Date: Wed, 20 Dec 2006 16:06:55 -0800 (PST)
Message-ID: <20061221000655.77571.qmail@web813.biz.mail.mud.yahoo.com>
References: <4588D680.4060103@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web813.biz.mail.mud.yahoo.com ([209.191.90.86]:30085 "HELO
	web813.biz.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1161058AbWLUAGz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 20 Dec 2006 19:06:55 -0500
In-Reply-To: <4588D680.4060103@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

--- Tejun Heo <htejun@gmail.com> wrote:

> The attached patch is inic162x driver for 2.6.19.  The driver against
> livata-dev#upstream didn't work on 2.6.19 due to difference in how
> dev->max_sectors is handled.  The driver is also available at...
> 
> http://home-tj.org/files/sata_inic-2.6.19.patch
> 
> Please report how it works.

Thanks much for the 2.6.19 version!! Unfortunately, I have problems with all
versions of the driver that I've gotten from you.  Here is an excerpt from my
syslog for the process of repartitioning a WD2000 (200GB drive) for the full
default size and then trying to create an xfs filesystem on it.

thanks,

Bob

*******************************************************************************
NOTE: fdisk /dev/sda - delete all partitions 
                     - add default sized primary partition (~200GB)

Dec 20 18:35:47 localhost kernel: sda: Write Protect is off
Dec 20 18:35:47 localhost kernel: sda: Mode Sense: 00 3a 00 00
Dec 20 18:35:47 localhost kernel: SCSI device sda: drive cache: write back
Dec 20 18:35:47 localhost kernel:  sda: sda1
Dec 20 18:35:49 localhost kernel: SCSI device sda: 390721968 512-byte hdwr
sectors (200050 MB)
Dec 20 18:35:49 localhost kernel: sda: Write Protect is off
Dec 20 18:35:49 localhost kernel: sda: Mode Sense: 00 3a 00 00
Dec 20 18:35:49 localhost kernel: SCSI device sda: drive cache: write back
Dec 20 18:35:49 localhost kernel:  sda: sda1


NOTE: mkfs.xfs -f /dev/sda1

Dec 20 18:37:27 localhost kernel: ata1.00: exception Emask 0x0 SAct 0x0 SErr
0x180000 action 0x2 frozen
Dec 20 18:37:27 localhost kernel: ata1.00: tag 0 cmd 0x35 Emask 0x4 stat 0x40
err 0x0 (timeout)
Dec 20 18:37:27 localhost kernel: ata1: hard resetting port
Dec 20 18:37:27 localhost kernel: ata1: SATA link up 1.5 Gbps (SStatus 113
SControl 300)
Dec 20 18:37:27 localhost kernel: ata1.00: configured for UDMA/133
Dec 20 18:37:27 localhost kernel: ata1: EH complete
Dec 20 18:37:57 localhost kernel: ata1.00: exception Emask 0x0 SAct 0x0 SErr
0x0 action 0x2 frozen
Dec 20 18:37:57 localhost kernel: ata1.00: tag 0 cmd 0x35 Emask 0x4 stat 0x40
err 0x0 (timeout)
Dec 20 18:37:57 localhost kernel: ata1: hard resetting port
Dec 20 18:37:58 localhost kernel: ata1: SATA link up 1.5 Gbps (SStatus 113
SControl 300)
Dec 20 18:37:58 localhost kernel: ata1.00: configured for UDMA/133
Dec 20 18:37:58 localhost kernel: ata1: EH complete
Dec 20 18:38:28 localhost kernel: ata1.00: exception Emask 0x0 SAct 0x0 SErr
0x0 action 0x2 frozen
Dec 20 18:38:28 localhost kernel: ata1.00: tag 0 cmd 0x35 Emask 0x4 stat 0x40
err 0x0 (timeout)
Dec 20 18:38:28 localhost kernel: ata1: hard resetting port
Dec 20 18:38:28 localhost kernel: ata1: SATA link up 1.5 Gbps (SStatus 113
SControl 300)
Dec 20 18:38:28 localhost kernel: ata1.00: configured for UDMA/133
Dec 20 18:38:28 localhost kernel: ata1: EH complete
Dec 20 18:38:58 localhost kernel: ata1.00: limiting speed to UDMA/100
Dec 20 18:38:58 localhost kernel: ata1.00: exception Emask 0x0 SAct 0x0 SErr
0x180000 action 0x2 frozen
Dec 20 18:38:58 localhost kernel: ata1.00: tag 0 cmd 0x35 Emask 0x4 stat 0x40
err 0x0 (timeout)
Dec 20 18:38:58 localhost kernel: ata1: hard resetting port
Dec 20 18:38:59 localhost kernel: ata1: SATA link up 1.5 Gbps (SStatus 113
SControl 300)
Dec 20 18:38:59 localhost kernel: ata1.00: configured for UDMA/100
Dec 20 18:38:59 localhost kernel: ata1: EH complete
Dec 20 18:39:29 localhost kernel: ata1.00: limiting speed to UDMA/66
Dec 20 18:39:29 localhost kernel: ata1.00: exception Emask 0x0 SAct 0x0 SErr
0x0 action 0x2 frozen
Dec 20 18:39:29 localhost kernel: ata1.00: tag 0 cmd 0x35 Emask 0x4 stat 0x40
err 0x0 (timeout)
Dec 20 18:39:29 localhost kernel: ata1: hard resetting port
Dec 20 18:39:29 localhost kernel: ata1: SATA link up 1.5 Gbps (SStatus 113
SControl 300)
Dec 20 18:39:29 localhost kernel: ata1.00: configured for UDMA/66
Dec 20 18:39:29 localhost kernel: ata1: EH complete
Dec 20 18:39:59 localhost kernel: ata1.00: limiting speed to UDMA/44
Dec 20 18:39:59 localhost kernel: ata1.00: exception Emask 0x0 SAct 0x0 SErr
0x0 action 0x2 frozen
Dec 20 18:39:59 localhost kernel: ata1.00: tag 0 cmd 0x35 Emask 0x4 stat 0x40
err 0x0 (timeout)
Dec 20 18:39:59 localhost kernel: ata1: hard resetting port
Dec 20 18:40:00 localhost kernel: ata1: SATA link up 1.5 Gbps (SStatus 113
SControl 300)
Dec 20 18:40:00 localhost kernel: ata1.00: configured for UDMA/44
Dec 20 18:40:00 localhost kernel: sd 0:0:0:0: SCSI error: return code =
0x08000002
Dec 20 18:40:00 localhost kernel: sda: Current: sense key: Aborted Command
Dec 20 18:40:00 localhost kernel:     Additional sense: No additional sense
information
Dec 20 18:40:00 localhost kernel: end_request: I/O error, dev sda, sector
390716609
Dec 20 18:40:00 localhost kernel: ata1: EH complete
Dec 20 18:40:00 localhost kernel: SCSI device sda: 390721968 512-byte hdwr
sectors (200050 MB)
Dec 20 18:40:00 localhost kernel: sda: Write Protect is off
Dec 20 18:40:00 localhost kernel: sda: Mode Sense: 00 3a 00 00
Dec 20 18:40:00 localhost kernel: SCSI device sda: drive cache: write back
Dec 20 18:40:00 localhost kernel: SCSI device sda: 390721968 512-byte hdwr
sectors (200050 MB)
Dec 20 18:40:00 localhost kernel: sda: Write Protect is off
Dec 20 18:40:00 localhost kernel: sda: Mode Sense: 00 3a 00 00
Dec 20 18:40:00 localhost kernel: SCSI device sda: drive cache: write back

NOTE: mkfs.xfs reports: pwrite64 failed: Input/output error

