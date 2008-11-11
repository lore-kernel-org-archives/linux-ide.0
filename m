From: Mark Lord <liml@rtr.ca>
Subject: Re: Fwd: [PATCH #upstream-fixes 1/4] libata: fix device iteration
 bugs
Date: Tue, 11 Nov 2008 09:29:39 -0500
Message-ID: <491996D3.80805@rtr.ca>
References: <6ca8fe89c868f95831328d31c27f9cdb@localhost> <1DE9BF42-39BB-4220-BDF0-62F14C854E77@it-loops.com> <4917DA12.8070307@kernel.org> <07a2f909b249db90ad6bfdddfdd17765@localhost> <49180B2E.6020604@kernel.org> <49184E1A.3010508@rtr.ca> <4918F1BC.2070602@kernel.org> <4919038B.8020407@rtr.ca> <49194E1C.9030800@ru.mvista.com> <3b5e4132a8abe8d67b4f1701a384a2d4@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:60147 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755836AbYKKO2x (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 11 Nov 2008 09:28:53 -0500
In-Reply-To: <3b5e4132a8abe8d67b4f1701a384a2d4@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Michael Guntsche <mike@it-loops.com>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jeff@garzik.org>

Michael Guntsche wrote:
>
> So apparently I have an "SB" Triton II. Looking at the description of the
> drivers I thought that ata_piix would be the correct driver for it.
> 
> ... support for PATA on the Intel ESB/ICH/PIIX3/PIIX4 series host
> controllers.
> 
> Also looking the the comments in ata_piix it looks like my chipset already
> supports independent timing and therefore ata_piix is the correct driver to
> use.
..

Yeah, that's the right one.  But if you are technically apt,
then perhaps you could try a brief experiment for us:

Use drivers/ide instead, and see what it reports in the boot log.

One simple way to do this, is to boot a Knoppix CD, say v5.01 or so
(but not the newest version, which probably uses libata instead).

Then just grab the boot log with dmesg, and post it here.

Thanks
