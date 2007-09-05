From: fredm@spamcop.net
Subject: Re: pata_via cd/dvd timeout problems
Date: Wed, 05 Sep 2007 11:58:46 +1000
Message-ID: <20070905115846.bup8b33m1wwog48c@webmail.spamcop.net>
References: <124748.3608.qm@web54408.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	DelSp=Yes	format=flowed
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from c60.cesmail.net ([216.154.195.49]:36481 "EHLO c60.cesmail.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755564AbXIEB6q convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 4 Sep 2007 21:58:46 -0400
In-Reply-To: <124748.3608.qm@web54408.mail.yahoo.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Vlad <vladc6@yahoo.com>
Cc: richard kennedy <richard@rsk.demon.co.uk>, linux-ide@vger.kernel.org

(take 2)
Hi,

Quoting Vlad <vladc6@yahoo.com>:
>> I have both a dvd RW drive & a cd rom drive connected
>> the second ide interface on my motherboard with a via
>> chipset, using pata_via I see timeout messages in the
>> log & after some time both drives lockup and are
>> unable to mount any disks.

Just a "me too". On 2.6.22 without via_pata I get the following and  
the DVD drive always seems to work:
Aug 31 12:53:13 nelson kernel: hdd: LITE-ON DVD SOHD-167T, ATAPI  
CD/DVD-ROM drive
Aug 31 12:53:13 nelson kernel: hdd: ATAPI 48X DVD-ROM drive, 512kB  
Cache, UDMA(33)
Aug 31 15:05:22 nelson kernel: hdd: lost interrupt
Aug 31 15:06:22 nelson kernel: hdd: lost interrupt

With via_pata, I get the following, more info available if required:
Sep  4 11:56:41 nelson kernel: scsi2 : pata_via
Sep  4 11:56:41 nelson kernel: scsi3 : pata_via
Sep  4 11:56:41 nelson kernel: ata3: PATA max UDMA/133 cmd  
0x00000000000101f0 ctl 0x00000000000103f6 bmdma 0x000000000001dc00 irq  
14
Sep  4 11:56:41 nelson kernel: ata4: PATA max UDMA/133 cmd  
0x0000000000010170 ctl 0x0000000000010376 bmdma 0x000000000001dc08 irq  
15
Sep  4 11:56:41 nelson kernel: ata4.01: ATAPI: LITE-ON DVD SOHD-167T,  
9S1B, max UDMA/33
Sep  4 11:56:41 nelson kernel: ata4.01: configured for UDMA/33
Sep  4 11:56:41 nelson kernel: scsi 3:0:1:0: CD-ROM            LITE-ON  
  DVD SOHD-167T    9S1B PQ: 0 ANSI: 5
Sep  4 12:50:47 nelson kernel: ata4.01: qc timeout (cmd 0xa0)
Sep  4 12:50:47 nelson kernel: ata4.01: exception Emask 0x0 SAct 0x0  
SErr 0x0 action 0x2 frozen
Sep  4 12:50:47 nelson kernel: ata4.01: cmd  
a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x0 data 0
Sep  4 12:50:47 nelson kernel:          res  
51/20:03:00:00:20/00:00:00:00:00/b0 Emask 0x5 (timeout)
Sep  4 12:50:47 nelson kernel: ata4: soft resetting port
Sep  4 12:50:47 nelson kernel: ata4.01: configured for UDMA/33
Sep  4 12:50:47 nelson kernel: ata4: EH complete
Sep  4 12:51:17 nelson kernel: ata4.01: exception Emask 0x0 SAct 0x0  
SErr 0x0 action 0x2 frozen
Sep  4 12:51:17 nelson kernel: ata4.01: cmd  
a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x0 data 0
Sep  4 12:51:17 nelson kernel:          res  
40/00:03:00:00:20/00:00:00:00:00/b0 Emask 0x4 (timeout)
Sep  4 12:51:17 nelson kernel: ata4: soft resetting port
Sep  4 12:51:18 nelson kernel: ata4.01: configured for UDMA/33
Sep  4 12:51:18 nelson kernel: ata4: EH complete
Sep  4 12:51:48 nelson kernel: ata4.01: exception Emask 0x0 SAct 0x0  
SErr 0x0 action 0x2 frozen
Sep  4 12:51:48 nelson kernel: ata4.01: cmd  
a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x0 data 0
Sep  4 12:51:48 nelson kernel:          res  
40/00:03:00:00:20/00:00:00:00:00/b0 Emask 0x4 (timeout)
Sep  4 12:51:48 nelson kernel: ata4: soft resetting port
Sep  4 12:51:49 nelson kernel: ata4.01: configured for UDMA/33
Sep  4 12:51:49 nelson kernel: ata4: EH complete
Sep  4 12:52:19 nelson kernel: ata4.01: limiting speed to UDMA/25:PIO4
Sep  4 12:52:19 nelson kernel: ata4.01: exception Emask 0x0 SAct 0x0  
SErr 0x0 action 0x2 frozen
Sep  4 12:52:19 nelson kernel: ata4.01: cmd  
a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x0 data 0
Sep  4 12:52:19 nelson kernel:          res  
40/00:03:00:00:20/00:00:00:00:00/b0 Emask 0x4 (timeout)
Sep  4 12:52:19 nelson kernel: ata4: soft resetting port
Sep  4 12:52:19 nelson kernel: ata4.01: configured for UDMA/25
Sep  4 12:52:19 nelson kernel: ata4: EH complete
Sep  4 12:52:49 nelson kernel: ata4.01: exception Emask 0x0 SAct 0x0  
SErr 0x0 action 0x2 frozen
Sep  4 12:52:49 nelson kernel: ata4.01: cmd  
a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x0 data 0
Sep  4 12:52:49 nelson kernel:          res  
40/00:03:00:00:20/00:00:00:00:00/b0 Emask 0x4 (timeout)
Sep  4 12:52:49 nelson kernel: ata4: soft resetting port
Sep  4 12:52:50 nelson kernel: ata4.01: configured for UDMA/25
Sep  4 12:52:50 nelson kernel: ata4: EH complete
Sep  4 12:53:20 nelson kernel: ata4.01: exception Emask 0x0 SAct 0x0  
SErr 0x0 action 0x2 frozen
Sep  4 12:53:20 nelson kernel: ata4.01: cmd  
a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x0 data 0
Sep  4 12:53:20 nelson kernel:          res  
40/00:03:00:00:20/00:00:00:00:00/b0 Emask 0x4 (timeout)
Sep  4 12:53:20 nelson kernel: ata4: soft resetting port
Sep  4 12:53:20 nelson kernel: ata4.01: configured for UDMA/25
Sep  4 12:53:20 nelson kernel: ata4: EH complete
Sep  4 12:53:50 nelson kernel: ata4.01: exception Emask 0x0 SAct 0x0  
SErr 0x0 action 0x2 frozen
Sep  4 12:53:50 nelson kernel: ata4.01: cmd  
a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x0 data 0
Sep  4 12:53:50 nelson kernel:          res  
40/00:03:00:00:20/00:00:00:00:00/b0 Emask 0x4 (timeout)
Sep  4 12:53:50 nelson kernel: ata4: soft resetting port
Sep  4 12:53:51 nelson kernel: ata4.01: configured for UDMA/25
Sep  4 12:53:51 nelson kernel: ata4: EH complete
Sep  4 12:54:21 nelson kernel: ata4.01: exception Emask 0x0 SAct 0x0  
SErr 0x0 action 0x2 frozen
Sep  4 12:54:21 nelson kernel: ata4.01: cmd  
a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x0 data 0
Sep  4 12:54:21 nelson kernel:          res  
40/00:03:00:00:20/00:00:00:00:00/b0 Emask 0x4 (timeout)
Sep  4 12:54:21 nelson kernel: ata4: soft resetting port
Sep  4 12:54:22 nelson kernel: ata4.01: configured for UDMA/25
Sep  4 12:54:22 nelson kernel: ata4: EH complete
Sep  4 12:54:22 nelson kernel: sr0: CDROM (ioctl) error, command: Test  
Unit Ready 00 00 00 00 00 00
Sep  4 12:54:22 nelson kernel: sr: Sense Key : Aborted Command  
[current] [descriptor]
Sep  4 12:54:22 nelson kernel: sr: Add. Sense: No additional sense information
Sep  4 12:54:32 nelson kernel: ata4.01: exception Emask 0x0 SAct 0x0  
SErr 0x0 action 0x2 frozen
Sep  4 12:54:32 nelson kernel: ata4.01: cmd  
a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x1e data 0
Sep  4 12:54:32 nelson kernel:          res  
40/00:03:00:00:20/00:00:00:00:00/b0 Emask 0x4 (timeout)
Sep  4 12:54:32 nelson kernel: ata4: soft resetting port
Sep  4 12:54:32 nelson kernel: ata4.01: configured for UDMA/25
Sep  4 12:54:32 nelson kernel: ata4: EH complete
Sep  4 12:54:42 nelson kernel: ata4.01: exception Emask 0x0 SAct 0x0  
SErr 0x0 action 0x2 frozen
Sep  4 12:54:42 nelson kernel: ata4.01: cmd  
a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x1e data 0
Sep  4 12:54:42 nelson kernel:          res  
40/00:03:00:00:20/00:00:00:00:00/b0 Emask 0x4 (timeout)
Sep  4 12:54:42 nelson kernel: ata4: soft resetting port
Sep  4 12:54:43 nelson kernel: ata4.01: configured for UDMA/25
Sep  4 12:54:43 nelson kernel: ata4: EH complete
Sep  4 12:54:53 nelson kernel: ata4.01: exception Emask 0x0 SAct 0x0  
SErr 0x0 action 0x2 frozen
Sep  4 12:54:53 nelson kernel: ata4.01: cmd  
a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x1e data 0
Sep  4 12:54:53 nelson kernel:          res  
40/00:03:00:00:20/00:00:00:00:00/b0 Emask 0x4 (timeout)
Sep  4 12:54:53 nelson kernel: ata4: soft resetting port
Sep  4 12:54:53 nelson kernel: ata4.01: configured for UDMA/25
Sep  4 12:54:53 nelson kernel: ata4: EH complete
Sep  4 12:55:03 nelson kernel: ata4.01: exception Emask 0x0 SAct 0x0  
SErr 0x0 action 0x2 frozen
Sep  4 12:55:03 nelson kernel: ata4.01: cmd  
a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x1e data 0
Sep  4 12:55:03 nelson kernel:          res  
40/00:03:00:00:20/00:00:00:00:00/b0 Emask 0x4 (timeout)
Sep  4 12:55:03 nelson kernel: ata4: soft resetting port
Sep  4 12:55:04 nelson kernel: ata4.01: configured for UDMA/25
Sep  4 12:55:04 nelson kernel: ata4: EH complete
Sep  4 12:55:14 nelson kernel: ata4.01: exception Emask 0x0 SAct 0x0  
SErr 0x0 action 0x2 frozen
Sep  4 12:55:14 nelson kernel: ata4.01: cmd  
a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x1e data 0
Sep  4 12:55:14 nelson kernel:          res  
40/00:03:00:00:20/00:00:00:00:00/b0 Emask 0x4 (timeout)
Sep  4 12:55:14 nelson kernel: ata4: soft resetting port
Sep  4 12:55:15 nelson kernel: ata4.01: configured for UDMA/25
Sep  4 12:55:15 nelson kernel: ata4: EH complete
Sep  4 12:55:25 nelson kernel: ata4.01: exception Emask 0x0 SAct 0x0  
SErr 0x0 action 0x2 frozen
Sep  4 12:55:25 nelson kernel: ata4.01: cmd  
a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x1e data 0
Sep  4 12:55:25 nelson kernel:          res  
40/00:03:00:00:20/00:00:00:00:00/b0 Emask 0x4 (timeout)
Sep  4 12:55:25 nelson kernel: ata4: soft resetting port
Sep  4 12:55:25 nelson kernel: ata4.01: configured for UDMA/25
Sep  4 12:55:25 nelson kernel: ata4: EH complete
Sep  4 12:55:25 nelson kernel: sr 3:0:1:0: ioctl_internal_command  
return code = 8000002
Sep  4 12:55:25 nelson kernel:    : Sense Key : Aborted Command  
[current] [descriptor]
Sep  4 12:55:25 nelson kernel:    : Add. Sense: No additional sense  
information
Sep  4 12:55:57 nelson kernel: ata4.01: limiting speed to PIO4
Sep  4 12:55:57 nelson kernel: ata4.01: exception Emask 0x0 SAct 0x0  
SErr 0x0 action 0x2 frozen
Sep  4 12:55:57 nelson kernel: ata4.01: cmd  
a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x0 data 0
Sep  4 12:55:57 nelson kernel:          res  
40/00:03:00:00:20/00:00:00:00:00/b0 Emask 0x4 (timeout)
Sep  4 12:55:57 nelson kernel: ata4: soft resetting port
Sep  4 12:55:58 nelson kernel: ata4.01: configured for PIO4
Sep  4 12:55:58 nelson kernel: ata4: EH complete
Sep  4 12:56:28 nelson kernel: ata4.01: exception Emask 0x0 SAct 0x0  
SErr 0x0 action 0x2 frozen
Sep  4 12:56:28 nelson kernel: ata4.01: cmd  
a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x0 data 0
Sep  4 12:56:28 nelson kernel:          res  
40/00:03:00:00:20/00:00:00:00:00/b0 Emask 0x4 (timeout)
Sep  4 12:56:28 nelson kernel: ata4: soft resetting port
Sep  4 12:56:29 nelson kernel: ata4.01: configured for PIO4
Sep  4 12:56:29 nelson kernel: ata4: EH complete
Sep  4 12:56:59 nelson kernel: ata4.01: exception Emask 0x0 SAct 0x0  
SErr 0x0 action 0x2 frozen
Sep  4 12:56:59 nelson kernel: ata4.01: cmd  
a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x0 data 0
Sep  4 12:56:59 nelson kernel:          res  
40/00:03:00:00:20/00:00:00:00:00/b0 Emask 0x4 (timeout)
Sep  4 12:56:59 nelson kernel: ata4: soft resetting port
Sep  4 12:56:59 nelson kernel: ata4.01: configured for PIO4
Sep  4 12:56:59 nelson kernel: ata4: EH complete
Sep  4 12:57:29 nelson kernel: ata4.01: exception Emask 0x0 SAct 0x0  
SErr 0x0 action 0x2 frozen
Sep  4 12:57:29 nelson kernel: ata4.01: cmd  
a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x0 data 0
Sep  4 12:57:29 nelson kernel:          res  
40/00:03:00:00:20/00:00:00:00:00/b0 Emask 0x4 (timeout)
Sep  4 12:57:29 nelson kernel: ata4: soft resetting port
Sep  4 12:57:30 nelson kernel: ata4.01: configured for PIO4
Sep  4 12:57:30 nelson kernel: ata4: EH complete
Sep  4 12:58:00 nelson kernel: ata4.01: limiting speed to PIO3
Sep  4 12:58:00 nelson kernel: ata4.01: exception Emask 0x0 SAct 0x0  
SErr 0x0 action 0x2 frozen
Sep  4 12:58:00 nelson kernel: ata4.01: cmd  
a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x0 data 0
Sep  4 12:58:00 nelson kernel:          res  
40/00:03:00:00:20/00:00:00:00:00/b0 Emask 0x4 (timeout)
Sep  4 12:58:00 nelson kernel: ata4: soft resetting port
Sep  4 12:58:00 nelson kernel: ata4.01: configured for PIO3
Sep  4 12:58:00 nelson kernel: ata4: EH complete
Sep  4 12:58:30 nelson kernel: ata4.01: exception Emask 0x0 SAct 0x0  
SErr 0x0 action 0x2 frozen
Sep  4 12:58:30 nelson kernel: ata4.01: cmd  
a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x0 data 0
Sep  4 12:58:30 nelson kernel:          res  
40/00:03:00:00:20/00:00:00:00:00/b0 Emask 0x4 (timeout)
Sep  4 12:58:30 nelson kernel: ata4: soft resetting port
Sep  4 12:58:31 nelson kernel: ata4.01: configured for PIO3
Sep  4 12:58:31 nelson kernel: ata4: EH complete
Sep  4 12:59:01 nelson kernel: ata4.01: exception Emask 0x0 SAct 0x0  
SErr 0x0 action 0x2 frozen
Sep  4 12:59:01 nelson kernel: ata4.01: cmd  
a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x0 data 0
Sep  4 12:59:01 nelson kernel:          res  
40/00:03:00:00:20/00:00:00:00:00/b0 Emask 0x4 (timeout)
Sep  4 12:59:01 nelson kernel: ata4: soft resetting port
Sep  4 12:59:02 nelson kernel: ata4.01: configured for PIO3
Sep  4 12:59:02 nelson kernel: ata4: EH complete
Sep  4 12:59:32 nelson kernel: ata4.01: exception Emask 0x0 SAct 0x0  
SErr 0x0 action 0x2 frozen
Sep  4 12:59:32 nelson kernel: ata4.01: cmd  
a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x0 data 0
Sep  4 12:59:32 nelson kernel:          res  
40/00:03:00:00:20/00:00:00:00:00/b0 Emask 0x4 (timeout)
Sep  4 12:59:32 nelson kernel: ata4: soft resetting port
Sep  4 12:59:32 nelson kernel: ata4.01: configured for PIO3
Sep  4 12:59:32 nelson kernel: ata4: EH complete
Sep  4 12:59:32 nelson kernel: sr0: CDROM (ioctl) error, command: Test  
Unit Ready 00 00 00 00 00 00
Sep  4 12:59:32 nelson kernel: sr: Sense Key : Aborted Command  
[current] [descriptor]
Sep  4 12:59:32 nelson kernel: sr: Add. Sense: No additional sense information
Sep  4 12:59:42 nelson kernel: ata4.01: limiting speed to PIO0
Sep  4 12:59:42 nelson kernel: ata4.01: exception Emask 0x0 SAct 0x0  
SErr 0x0 action 0x2 frozen
Sep  4 12:59:42 nelson kernel: ata4.01: cmd  
a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x1e data 0
Sep  4 12:59:42 nelson kernel:          res  
40/00:03:00:00:20/00:00:00:00:00/b0 Emask 0x4 (timeout)
Sep  4 12:59:42 nelson kernel: ata4: soft resetting port
Sep  4 12:59:43 nelson kernel: ata4.01: configured for PIO0
Sep  4 12:59:43 nelson kernel: ata4: EH complete
Sep  4 12:59:53 nelson kernel: ata4.01: exception Emask 0x0 SAct 0x0  
SErr 0x0 action 0x2 frozen
Sep  4 12:59:53 nelson kernel: ata4.01: cmd  
a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x1e data 0
Sep  4 12:59:53 nelson kernel:          res  
40/00:03:00:00:20/00:00:00:00:00/b0 Emask 0x4 (timeout)
Sep  4 12:59:53 nelson kernel: ata4: soft resetting port
Sep  4 12:59:54 nelson kernel: ata4.01: configured for PIO0
Sep  4 12:59:54 nelson kernel: ata4: EH complete
Sep  4 13:00:04 nelson kernel: ata4.01: exception Emask 0x0 SAct 0x0  
SErr 0x0 action 0x2 frozen
Sep  4 13:00:04 nelson kernel: ata4.01: cmd  
a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x1e data 0
Sep  4 13:00:04 nelson kernel:          res  
40/00:03:00:00:20/00:00:00:00:00/b0 Emask 0x4 (timeout)
Sep  4 13:00:04 nelson kernel: ata4: soft resetting port
Sep  4 13:00:04 nelson kernel: ata4.01: configured for PIO0
Sep  4 13:00:04 nelson kernel: ata4: EH complete
Sep  4 13:00:14 nelson kernel: ata4.01: exception Emask 0x0 SAct 0x0  
SErr 0x0 action 0x2 frozen
Sep  4 13:00:14 nelson kernel: ata4.01: cmd  
a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x1e data 0
Sep  4 13:00:14 nelson kernel:          res  
40/00:03:00:00:20/00:00:00:00:00/b0 Emask 0x4 (timeout)
Sep  4 13:00:14 nelson kernel: ata4: soft resetting port
Sep  4 13:00:15 nelson kernel: ata4.01: configured for PIO0
Sep  4 13:00:15 nelson kernel: ata4: EH complete
Sep  4 13:00:25 nelson kernel: ata4.01: exception Emask 0x0 SAct 0x0  
SErr 0x0 action 0x2 frozen
Sep  4 13:00:25 nelson kernel: ata4.01: cmd  
a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x1e data 0
Sep  4 13:00:25 nelson kernel:          res  
40/00:03:00:00:20/00:00:00:00:00/b0 Emask 0x4 (timeout)
Sep  4 13:00:25 nelson kernel: ata4: soft resetting port
Sep  4 13:00:25 nelson kernel: ata4.01: configured for PIO0
Sep  4 13:00:25 nelson kernel: ata4: EH complete
Sep  4 13:00:35 nelson kernel: ata4.01: exception Emask 0x0 SAct 0x0  
SErr 0x0 action 0x2 frozen
Sep  4 13:00:35 nelson kernel: ata4.01: cmd  
a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x1e data 0
Sep  4 13:00:35 nelson kernel:          res  
40/00:03:00:00:20/00:00:00:00:00/b0 Emask 0x4 (timeout)
Sep  4 13:00:35 nelson kernel: ata4: soft resetting port
Sep  4 13:00:36 nelson kernel: ata4.01: configured for PIO0
Sep  4 13:00:36 nelson kernel: ata4: EH complete
Sep  4 13:00:36 nelson kernel: sr 3:0:1:0: ioctl_internal_command  
return code = 8000002
Sep  4 13:00:36 nelson kernel:    : Sense Key : Aborted Command  
[current] [descriptor]
Sep  4 13:00:36 nelson kernel:    : Add. Sense: No additional sense  
information
Sep  4 13:01:08 nelson kernel: ata4.01: exception Emask 0x0 SAct 0x0  
SErr 0x0 action 0x2 frozen
Sep  4 13:01:08 nelson kernel: ata4.01: cmd  
a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x0 data 0
Sep  4 13:01:08 nelson kernel:          res  
40/00:03:00:00:20/00:00:00:00:00/b0 Emask 0x4 (timeout)
Sep  4 13:01:08 nelson kernel: ata4: soft resetting port
Sep  4 13:01:09 nelson kernel: ata4.01: configured for PIO0
Sep  4 13:01:09 nelson kernel: ata4: EH complete
Sep  4 13:01:39 nelson kernel: ata4.01: exception Emask 0x0 SAct 0x0  
SErr 0x0 action 0x2 frozen
Sep  4 13:01:39 nelson kernel: ata4.01: cmd  
a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x0 data 0
Sep  4 13:01:39 nelson kernel:          res  
40/00:03:00:00:20/00:00:00:00:00/b0 Emask 0x4 (timeout)
Sep  4 13:01:39 nelson kernel: ata4: soft resetting port
Sep  4 13:01:39 nelson kernel: ata4.01: configured for PIO0

Thanks,
Fred
