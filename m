From: Tejun Heo <tj@kernel.org>
Subject: Re: [BUG] 2.6.29-rc1: ata_piix boot hang due to bmdma32 change
Date: Sun, 25 Jan 2009 10:03:02 +0900
Message-ID: <497BBA46.3000605@kernel.org>
References: <200901150842.n0F8gpZb014365@harpo.it.uu.se> <18805.35930.588019.518198@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:55994 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754266AbZAYBDQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 24 Jan 2009 20:03:16 -0500
In-Reply-To: <18805.35930.588019.518198@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

Hello,

Mikael Pettersson wrote:
> The problem is still present in 2.6.29-rc2.
> 
> More debugging first showed that only the specific machine mentioned
> above is affected, as I've tested -rc1 on several other ata_piix boxes
> with various oldish disks and cdroms and none of the others triggered
> the hang.
> 
> Secondly, the hang is due to the HP CD-Writer drive as having only it
> on the second port suffices to produce the hang. It doesn't matter if
> it's configured as master or slave.
> 
> In any event, this shows that using 32-bit I/O ops should also be a
> function of the drive you're talking to, not just the controller.

If you connect the writer to another machine, does it make the machine
hang too?

-- 
tejun
