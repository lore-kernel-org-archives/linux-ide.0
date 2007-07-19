From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bugme-new] [Bug 8784] New: ata_piix cannot see ICHx IDE
 devices
Date: Thu, 19 Jul 2007 13:20:46 -0700
Message-ID: <20070719132046.fa9fb592.akpm@linux-foundation.org>
References: <bug-8784-10286@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:39167 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757497AbXGSUVX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 19 Jul 2007 16:21:23 -0400
In-Reply-To: <bug-8784-10286@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: bugme-daemon@bugzilla.kernel.org, amsden_linux@earthlink.net

On Thu, 19 Jul 2007 13:16:27 -0700 (PDT)
bugme-daemon@bugzilla.kernel.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id=8784
> 
>            Summary: ata_piix cannot see ICHx IDE devices
>            Product: IO/Storage
>            Version: 2.5
>      KernelVersion: 2.6.22
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: IDE
>         AssignedTo: bzolnier@gmail.com
>         ReportedBy: amsden_linux@earthlink.net
> 
> 
> Most recent kernel where this bug did not occur:2.6.19 (Knoppix)
> Distribution:ubuntu
> Hardware Environment: intel ich4 chipset
> Software Environment: ubuntu gutsy gibbon testing
> Problem Description: ata_piix does not detect ide drives with intel ICHx
> chipsets. This problem has been the subject of numerous bug reports and forum
> posts in the ubuntu community. The most obvious manifestation is when a user
> succesfully begins to boot the ubuntu desktop cd, only to have it fail as it
> attempts to mount the file system. another manifestation occurs when a user
> with an ide or sata hard drive on an ICHx chipset machine attempts to boot
> after upgrading the kernel from 2.6.17 (in ubuntu 6.10) to 2.6.20 (in ubuntu
> 7.04)
> 
> Steps to reproduce: attempt to boot ubuntu with kernel 2.6.20 - 2.6.22 on a
> machine with an intel ide chipset. Any drives attached to the ide bus will not
> be recognized. I am writing this on an ubuntu machine which uses the ich4 ide
> bus to connect to the cd drive, but a scsi bus for the hard drive. This
> necessitated a netboot installation, and the installed system is still unable
> to utilize the hard disk.
> 
> Here is the dmesg|grep ata output (with two irrelevant lines containing the
> word "data" removed)
> [ 45.780805] libata version 2.21 loaded.
> [ 45.782248] ata_piix 0000:00:1f.1: version 2.11
> [ 45.782435] scsi0 : ata_piix
> [ 45.782496] scsi1 : ata_piix
> [ 45.782527] ata1: PATA max UDMA/100 cmd 0x000101f0 ctl 0x000103f6 bmdma
> 0x000124a0 irq 14
> [ 45.782530] ata2: PATA max UDMA/100 cmd 0x00010170 ctl 0x00010376 bmdma
> 0x000124a8 irq 15
> [ 45.782555] ata1: port disabled. ignoring.
> 

That sounds rather serious?
