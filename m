From: Tejun Heo <tj@kernel.org>
Subject: Re: Errors on ICH10R with Seagate HDDs
Date: Sun, 19 Apr 2009 17:56:38 +0900
Message-ID: <49EAE746.4040303@kernel.org>
References: <49D4A232.3090504@hadiko.de> <49DE39E2.7070505@kernel.org> <49E847A3.9070100@hadiko.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:59362 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752484AbZDSI4y (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 19 Apr 2009 04:56:54 -0400
In-Reply-To: <49E847A3.9070100@hadiko.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Thomas Jackowski <aXe@hadiko.de>
Cc: linux-ide@vger.kernel.org

Hello,

Thomas Jackowski wrote:
> yes this was AHCI. NCQ was enabled. I forgot to mention kernel version:
> 2.6.26-1-amd64 (Debian Lenny)

Can you please try 2.6.29?

> So here is my test:
> Enabled AHCI in BIOS.
> 
> [    0.000000] Command line: root=/dev/md1 ro libata.force=noncq
> [    0.000000] Kernel command line: root=/dev/md1 ro libata.force=noncq
> [...]
> [    3.237941] ahci 0000:00:1f.2: AHCI 0001.0200 32 slots 6 ports 3 Gbps
> 0x3f impl SATA mode
> [    3.238000] ahci 0000:00:1f.2: flags: 64bit ncq sntf stag pm led clo
> pmp pio slum part
> 
> Ah, NCQ still activated.
> /sys/block/sdc/device/queue_depth shows 31.
> 
> I guess NCQ still activated even with libata.force=noncq ?

Well, if the module is loaded from initrd, you need to jump through
some loops to get the parameter passed to libata.ko.  You can also
disable NCQ by echoing 1 to queue_depth.

> Now here is my second test: Disabled AHCI in BIOS.
> 
> ata_piix is used now. Did some IO, can't force any freezes.
> 
> In the meantime I found topics like this:
> http://forums.seagate.com/stx/board/message?board.id=ata_drives&thread.id=2879&view=by_date_ascending&page=1
> 
> This looks like a firmware bug. I think I should contact Seagate ;) or
> any other ideas?

Hmmm... please verify with ahci w/o NCQ.  If that works fine too,
please go ahead and contact Seagate.

Thanks.

-- 
tejun
