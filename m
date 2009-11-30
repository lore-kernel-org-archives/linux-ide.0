From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: libata PM question
Date: Mon, 30 Nov 2009 14:42:21 +1100
Message-ID: <1259552541.2076.56.camel@pasglop>
References: <1259547765.2076.48.camel@pasglop>
	 <1259547943.2076.50.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:47324 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752687AbZK3DnF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 29 Nov 2009 22:43:05 -0500
In-Reply-To: <1259547943.2076.50.camel@pasglop>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Jeff Garzik <jeff@garzik.org>

On Mon, 2009-11-30 at 13:25 +1100, Benjamin Herrenschmidt wrote:
> On Mon, 2009-11-30 at 13:22 +1100, Benjamin Herrenschmidt wrote:
> > Hi there !
> > 
> > So I (finally !) resumed work on pata_macio.c to replace ide/pmac.c :-)
> > 
> > I've started looking at the suspend/resume stuff. It looks like most of
> > it just comes for free thanks to libata, yay ! :-)
> 
>  .../...
> 
> Oh, another question... where do we spin the disk down & park it on
> suspend ? I'm missed at least that part :-)

Oh and finally, one last question for today ...

In drivers/ide, we have a call to ledtrig_ide_activity() inside
ide_do_rw_disk() which allows me to flash the front light on
the powerbook.

libata has no such thing.

It's as simple as adding that call, if we want to keep the trigger named
"ide-disk" but where to put it then ? In ata_scsi_rw_xlat() ? Yuck :-)

Another option is to stick it in drivers/scsi/sd.c but the trigger
should not be named ide-disk anymore ... Also it will start tiggering
for any "pseudo scsi" device in the machine which is note quite the
purpose... It would be nice if it really only triggered on libata and as
such blink the led only for the internal HD on those powerbooks (unless
you have some libata based PCMCIA stuff but that doesn't matter).

Anyway, nothing fancy, just a quick hack to get the activity led
back :-) I could always stick it somewhere in pata_macio.c but that
would suck probably even more.

Cheers,
Ben.
 

