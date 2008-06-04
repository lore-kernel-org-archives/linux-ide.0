From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bugme-new] [Bug 10854] New: CDROM is nor detected with libata
 and 3Ware.
Date: Wed, 4 Jun 2008 12:29:37 -0700
Message-ID: <20080604122937.00f96fd8.akpm@linux-foundation.org>
References: <bug-10854-10286@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:36277 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753629AbYFDTaL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 4 Jun 2008 15:30:11 -0400
In-Reply-To: <bug-10854-10286@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: bugme-daemon@bugzilla.kernel.org, frederic@juliana-multimedia.com


(switched to email.  Please respond via emailed reply-to-all, not via the
bugzilla web interface).

On Wed,  4 Jun 2008 11:06:34 -0700 (PDT) bugme-daemon@bugzilla.kernel.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id=10854
> 
>            Summary: CDROM is nor detected with libata and 3Ware.
>            Product: IO/Storage
>            Version: 2.5
>      KernelVersion: 2.6.20 and 2.6.25
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: Serial ATA
>         AssignedTo: jgarzik@pobox.com
>         ReportedBy: frederic@juliana-multimedia.com
> 
> 
> Latest working kernel version: 2.6.20
> Earliest failing kernel version: 2.6.25
> Distribution: Debian Lenny
> Hardware Environment: 
> - CPU Intel Pentium 4 2.40GHz
> 
> - 00:1f.1 IDE interface: Intel Corporation 82801EB/ER (ICH5/ICH5R) IDE
> Controller (rev 02) (prog-if 8a [Master SecP PriP])
>         Subsystem: ASUSTeK Computer Inc. Device 80a6
>         Flags: bus master, medium devsel, latency 0
>         I/O ports at 01f0 [size=8]
>         I/O ports at 03f4 [size=1]
>         I/O ports at 0170 [size=8]
>         I/O ports at 0374 [size=1]
>         I/O ports at fc00 [size=16]
>         Memory at 70100000 (32-bit, non-prefetchable) [disabled] [size=1K]
> 
> 02:09.0 RAID bus controller: 3ware Inc 7xxx/8xxx-series PATA/SATA-RAID (rev 01)
>         Subsystem: 3ware Inc 7xxx/8xxx-series PATA/SATA-RAID
>         Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 21
>         I/O ports at df80 [size=16]
>         Memory at fe6fbc00 (32-bit, non-prefetchable) [size=16]
>         Memory at fd800000 (32-bit, non-prefetchable) [size=8M]
>         Expansion ROM at 70020000 [disabled] [size=64K]
>         Capabilities: [40] Power Management version 1
>         Kernel driver in use: 3w-xxxx
> 
> Problem Description:
> 
> Hi,
> 
> I have a server with a Intel 82801EB/ER (ICH5/ICH5R) chipset and 3ware 7506-4LP
> PATA RAID controller. The hard disks are connected to the RAID card, the cdrom
> is connected to the ICH5 IDE controller on the motherboard.
> 
> - With the kernel 2.6.20 and IDE support (CONFIG_IDE, CONFIG_BLK_DEV_IDECD) and
> 3Ware support (CONFIG_BLK_DEV_3W_XXXX_RAID) all works, cdrom is detected
> (/dev/hdd).
> 
> - With the kernel 2.6.25 without the IDE support, with libata support
> (CONFIG_ATA, CONFIG_ATA_PIIX) and 3ware support (CONFIG_BLK_DEV_3W_XXXX_RAID),
> RAID array is detected and the system boot without problems, but the cdrom is
> not detected.
> 
> Below the config files and dmesg for kernels 2.6.20 and 2.6.25.
> 

