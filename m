From: Jeff Garzik <jeff@garzik.org>
Subject: Merged some Alan patches...
Date: Tue, 18 Dec 2007 17:06:38 -0500
Message-ID: <4768446E.4090702@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:59022 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755795AbXLRWGk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 18 Dec 2007 17:06:40 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: IDE/ATA development list <linux-ide@vger.kernel.org>
Cc: Alan <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@linux-foundation.org>

I just moved the following changes from #for-testing (which 
auto-propagates to -mm along with other stuff) into #upstream, queueing 
for 2.6.25:

Applied:
> Author: Alan <alan@lxorguk.ukuu.org.uk>
> Date:   Tue Oct 2 13:53:05 2007 -0700
> 
>     libata: fix (hopefully) all the remaining problems with devices failing setu
>     
>     Two fixes in this test patch.  One of them allows old CF cards to refuse
>     pio mode setting, and one to wait for the drive to settle after a set
>     features changes the speed settings, which is based upon the workarounds
>     used by drivers/ide.

Applied:
> Author: Alan Cox <alan@lxorguk.ukuu.org.uk>
> Date:   Mon Oct 15 20:44:11 2007 +0100
> 
>     pata_pcmcia: Add support for dumb 8bit IDE emulations

Applied:
> Author: Alan Cox <alan@lxorguk.ukuu.org.uk>
> Date:   Thu Oct 25 14:21:16 2007 +0100
> 
>     libata/pata_it821x: Improve handling of poorly compatible emulations
>     
>     Some it821x RAID firmwares return 0 for the err return off both devices.
>     A similar issue occurs with the slave returning 0 not 1 if you plug a
>     gigabyte sata ramdisk into a controller that fakes two SATA ports as
>     master/slave on an SFF channel.
>     
>     The patch does the following
>     
>     - Allow the 'failed diagnostics' case on both master and slave
>     - Move the HORKAGE_DIAGNOSTIC check after ->dev_config


And finally, dropped one patch as per request:
> Author: Alan Cox <alan@lxorguk.ukuu.org.uk>
> Date:   Mon Oct 15 19:23:13 2007 +0100
> 
>     libata-core: Don't have screaming fits over DF/ERR combinations
>     
>     Some hardware seems to get this wrong in a non-harmful way, and there are
>     some devices that seem to do it deliberately for various reasons.

