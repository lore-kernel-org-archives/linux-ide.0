From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: SATA intel High loads due to writes vs ata_piix switch
Date: Wed, 16 May 2007 21:42:36 +0100
Message-ID: <20070516214236.08dd02c9@the-village.bc.nu>
References: <8E8F647D7835334B985D069AE964A4F7028FE7F0@ECQCMTLMAIL1.quebec.int.ec.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:36273 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756734AbXEPUjP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 May 2007 16:39:15 -0400
In-Reply-To: <8E8F647D7835334B985D069AE964A4F7028FE7F0@ECQCMTLMAIL1.quebec.int.ec.gc.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Fortier,Vincent [Montreal]" <Vincent.Fortier1@EC.GC.CA>
Cc: Linux IDE <linux-ide@vger.kernel.org>

> I made a fwe tests to try to point out when high loads happens (which
> are not really scientific :).  Note that between each tests I made sure
> the load average got back below 0.15.
> 
> But first, here are my 2 questions:
> 1- Should I really expect loads that high using that driver?

Remember that uptime type load also measure system wait so high disk I/O
counts as load but not CPU usage. High CPU usage shouldn't be a problem
for any DMA based disk

With the newer ICH controllers and especially if your disk does NCQ you
should see better performance with libata as the libata drivers support
AHCI and NCQ which allows multiple outstanding commands.

> "Multi-Platform E-IDE driver Revision: 7.00alpha2" and detected both my
> hd & dvdrw as scsi devices BUT finally ended up in a oops:
> pivot_root: No such file or directory
> /sbin/init: 432: Cannot open dev/console: No such file
> Kernel panic - not syncing: Attempted to kill init

Thats really for the Debian lists, it sounds as if Debian still isn't
using disk labels in the initrd.

> TEST 2: 10000 1mb files (medium size files):
> Note that I stopped the test a the 4134th file)
> -----------------------------------------------
> Max load average (a simple while loop + sleep 5 + cat /proc/loadavg)
> 16.36 12.64 7.86 2/122 3602

If you are doing all the I/O in parallel then that isn't unexpected -
disk performance is very very seek dependant snd a lot of parallel I/O
will cause a lot of seeking. If they are occuring in serial then this is
a bit odd and would warrant more investigating. I don't however think
this is likely to be a disk layer problem so I doubt libata v oldIDE
makes that much difference here - a bit because of NCQ but not a lot.

Alan
