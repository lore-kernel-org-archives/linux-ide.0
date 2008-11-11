From: Michael Guntsche <mike@it-loops.com>
Subject: Re: Fwd: [PATCH #upstream-fixes 1/4] libata: fix device iteration bugs
Date: Tue, 11 Nov 2008 14:34:35 +0100
Message-ID: <3b5e4132a8abe8d67b4f1701a384a2d4@localhost>
References: <6ca8fe89c868f95831328d31c27f9cdb@localhost> <1DE9BF42-39BB-4220-BDF0-62F14C854E77@it-loops.com> <4917DA12.8070307@kernel.org> <07a2f909b249db90ad6bfdddfdd17765@localhost> <49180B2E.6020604@kernel.org> <49184E1A.3010508@rtr.ca> <4918F1BC.2070602@kernel.org> <4919038B.8020407@rtr.ca> <49194E1C.9030800@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lvps87-230-0-242.dedicated.hosteurope.de ([87.230.0.242]:57300
	"EHLO lvps87-230-0-242.dedicated.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755321AbYKKNee (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Nov 2008 08:34:34 -0500
In-Reply-To: <49194E1C.9030800@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Mark Lord <liml@rtr.ca>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jeff@garzik.org>

On Tue, 11 Nov 2008 12:19:24 +0300, Sergei Shtylyov
<sshtylyov@ru.mvista.com> wrote:
> Hello.
> 

>> Mmm.. but he's using "really old ata_piix" hardware, as in what Intel
>> once called the "Triton" (or Triton II) chipset.
> 
>    The "original Triton" IDE is supported by pata_oldpiix.
> 
>>   Which I wrote support
>> for in drivers/ide, way back when.. and we never had this problem.
> 
>    The support for the "original Triton" is drivers/ide/ is still broken 
> after all these years. The driver assumes that the slave IDE timing 
> register always present -- which the origina 82371FB didn't have. :-(

00:07.1 IDE interface: Intel Corporation 82371SB PIIX3 IDE [Natoma/Triton
II]

So apparently I have an "SB" Triton II. Looking at the description of the
drivers I thought that ata_piix would be the correct driver for it.

... support for PATA on the Intel ESB/ICH/PIIX3/PIIX4 series host
controllers.

Also looking the the comments in ata_piix it looks like my chipset already
supports independent timing and therefore ata_piix is the correct driver to
use.

Please correct me if I am wrong or misunderstood your remarks.

Kind regards,
Michael


