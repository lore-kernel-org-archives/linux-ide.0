From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata_nv failure on 2.4.18 (Fedora Core 6)
Date: Wed, 25 Oct 2006 13:28:11 +0900
Message-ID: <20061025042811.GJ13677@htj.dyndns.org>
References: <Pine.LNX.4.64.0610242257410.21847@gate.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hu-out-0506.google.com ([72.14.214.235]:18124 "EHLO
	hu-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1161338AbWJYE2U (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 25 Oct 2006 00:28:20 -0400
Received: by hu-out-0506.google.com with SMTP id 28so1580086hub
        for <linux-ide@vger.kernel.org>; Tue, 24 Oct 2006 21:28:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610242257410.21847@gate.crashing.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Hatle <fray@gate.crashing.org>
Cc: linux-ide@vger.kernel.org, benh@kernel.crashing.org

Hello,

On Tue, Oct 24, 2006 at 11:01:11PM -0500, Mark Hatle wrote:
[--snip--]
> When the sata_nv error occurs, raid takes the drive offline, and the
> system requires a hard power cycle to reactive the drive.
> 
> This has occured 5 times since Saturday.  The first time the system
> was up more then 12 hours.. second time about the same.. 3rd, 4th
> and 5th times occured within 2 hours of the system starting.
> 
> If there is any other information you need let me know!

Does the problem occur on 2.6.18 but not on earlier version?  If it
doesn't happen on 2.6.17, we can rule out h/w problem.

> Machine info:
> 
> CPU: Core 2 Duo 6300
> Mem: 1GB RAM
> Board: ECS nForce 570 SLIT-A
> Distro: Fedora Core 6 (Zod) for x86_64
> Drives: two Maxtor 160GB drives - Maxtor 6G160E0
> Other cards:
>  * HVD SCSI sym53c8xx
>  * Silicon Images 3132 SATA II (no problems, even after sata_nv goes 
>  offline)
> 
> Linux version 2.6.18-1.2798.fc6 (brewbuilder@hs20-bc1-6.build.redhat.com) 
> (gcc version 4.1.1 20061011 (Red Hat 4.1.1-30)) #1 SMP Mon Oct 16 14:39:22 
> EDT 2006
> 
> IDE/Raid failure information:
> 
> Oct 24 16:15:59 gate kernel: ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 
> action 0x2 frozen
> Oct 24 16:15:59 gate kernel: ata1.00: (BMDMA stat 0x24)
> Oct 24 16:15:59 gate kernel: ata1.00: tag 0 cmd 0x35 Emask 0x4 stat 0x40 
> err 0x0 (timeout)

The BMDMA register is reporting transaction complete and the stat
register is indicating drive ready.  This looks like a lost interrupt
to me.  Any interesting messages before this error log?

> Oct 24 16:16:00 gate kernel: ata1: soft resetting port
> Oct 24 16:16:00 gate kernel: ata1: SATA link up 3.0 Gbps (SStatus 123 
> SControl 300)
> Oct 24 16:16:30 gate kernel: ata1.00: qc timeout (cmd 0xec)
> Oct 24 16:16:30 gate kernel: ata1.00: failed to IDENTIFY (I/O error, 
> err_mask=0x4)
> Oct 24 16:16:30 gate kernel: ata1.00: revalidation failed (errno=-5)
> Oct 24 16:16:30 gate kernel: ata1: failed to recover some devices, retrying 
> in 5 secs

The first retry also failed due to IDENTIFY timeout although the drive
and controller responded to SRST properly.  If this problem is caused
by IRQ delivery failure, this behavior is expected.

> Oct 24 16:16:35 gate kernel: ata1: hard resetting port
> Oct 24 16:16:42 gate kernel: ata1: port is slow to respond, please be 
> patient
> Oct 24 16:17:16 gate kernel: ata1: port failed to respond (30 secs)
> Oct 24 16:17:17 gate kernel: ata1: COMRESET failed (device not ready)
> Oct 24 16:17:17 gate kernel: ata1: hardreset failed, retrying in 5 secs
> Oct 24 16:17:17 gate kernel: ata1: hard resetting port
> Oct 24 16:17:17 gate kernel: ata1: SRST failed (status 0xFF)
> Oct 24 16:17:17 gate kernel: ata1: SRST failed (err_mask=0x100)
> Oct 24 16:17:17 gate kernel: ata1: follow-up softreset failed, retrying in 
> 5 secs
> Oct 24 16:17:17 gate kernel: ata1: hard resetting port
> Oct 24 16:17:17 gate kernel: ata1: SRST failed (status 0xFF)
> Oct 24 16:17:17 gate kernel: ata1: SRST failed (err_mask=0x100)

CK804 sata_nv when accessed via TF/BMDMA interface gets confused quite
easily after errors and sometimes fails miserably sometimes locking up
the whole machine.  So, the above reset failures might be similar.

> Oct 24 16:17:17 gate kernel: ata1: reset failed, giving up
> Oct 24 16:17:17 gate kernel: ata1.00: disabled
> Oct 24 16:17:17 gate kernel: ata1: EH complete
> Oct 24 16:17:17 gate kernel: sd 0:0:0:0: SCSI error: return code = 
> 0x00040000
> Oct 24 16:17:17 gate kernel: end_request: I/O error, dev sda, sector 
> 312576515
> Oct 24 16:17:17 gate kernel: raid1: Disk failure on sda6, disabling device. 
> Oct 24 16:17:17 gate kernel:    Operation continuing on 1 devices
[--snip--]

The normal command execution path didn't change in any significant way
between 2.6.17 and .18.

* If 2.6.17 shows the same problem : could be a faulty drive or
  problem in the controller.  NV SATA controllers supply two
  interfaces - legacy TF/BMDMA and ADMA.  The former tends to react
  badly when error condition occurs.  Driver for ADMA interface is
  under development.  It could be that the controller cannot cope with
  transient transmission errors.  If this is the case, ADMA driver
  should be able to fix it.

* If 2.6.17 doesn't show the same problem : My first suspicion is
  weird IRQ problem.  Play with the usual IRQ options - acpi, noacpi,
  etc... and see if anything changes.

Thanks.

-- 
tejun
