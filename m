From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [PATCH 3/5] libata: Implement disk shock protection support
Date: Mon, 04 Aug 2008 22:16:51 -0600
Message-ID: <4897D433.5040409@shaw.ca>
References: <fa.nx0yFPJm+aNXPHgykUrOzZXvvIs@ifi.uio.no> <fa.NfEr7Ik6e8oextyWICW/jR5emeE@ifi.uio.no> <fa.zGvATZImeUo0tHJe4hzlk5+mTiM@ifi.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from idcmail-mo1so.shaw.ca ([24.71.223.10]:8218 "EHLO
	pd2mo1so-dmz.prod.shaw.ca" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751346AbYHEERF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 5 Aug 2008 00:17:05 -0400
In-Reply-To: <fa.zGvATZImeUo0tHJe4hzlk5+mTiM@ifi.uio.no>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Elias Oltmanns <eo@nebensachen.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jeff@garzik.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, Pavel Machek <pavel@ucw.cz>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Tejun Heo wrote:
> Elias Oltmanns wrote:
>> On user request (through sysfs), the IDLE IMMEDIATE command with UNLOAD
>> FEATURE as specified in ATA-7 is issued to the device and processing of
>> the request queue is stopped thereafter until the speified timeout
>> expires or user space asks to resume normal operation. This is supposed
>> to prevent the heads of a hard drive from accidentally crashing onto the
>> platter when a heavy shock is anticipated (like a falling laptop
>> expected to hit the floor). This patch simply stops processing the
>> request queue. In particular, it does not yet, for instance, defer an
>> SRST issued in order to recover from an error on the other device on the
>> interface.
> 
> For libata, the easiest way to achieve the above would be adding a
> per-dev EH action, say, ATA_EH_UNLOAD and schedule EH w/ the action OR'd
> to eh_info->action.  The EH_UNLOAD handler can then issue the command
> wait for the specified number of seconds and continue.  This will be
> pretty simple to implement as command exclusion and stuff are all
> automatically handled by EH framework.
> 
> However, SATA or not, there simply isn't a way to abort commands in ATA.
>  Issuing random command while other commands are in progress simply is
> state machine violation and there will be many interesting results
> including complete system lockup (ATA controller dying while holding the
> PCI bus).  The only reliable way to abort in-flight commands are by
> issuing hardreset.  However, ATA reset protocol is not designed for
> quick recovery.  The machine is gonna hit the ground hard way before the
> reset protocol is complete.

How long does hardreset have to take? I only see a 1ms delay in the 
COMRESET process (sata_link_hardreset). I'd think it would be feasible 
to do something like:

-stop the queue to prevent new commands from being issued
-wait a certain amount of time (20ms or so?) for existing command(s) to 
complete, if they do then issue the idle command
-if time runs out, trigger a hardreset and then issue the idle command

The drive is going to take a little while to actually unload the heads 
anyway, so a few milliseconds delay doesn't seem like a big deal..

> 
> The only way to solve this nicely is either to build the accelerometer
> into the drive and let the drive itself protect itself or implement a
> sideband signal to tell it to duck for cover.  For SATA, this sideband
> signal can be another OOB sequence.  If it's ever implemented this way,
> it will be in SControl, I guess.
> 
> Well, short of that, all we can do is to wait for the currently
> in-flight commands to drain and hope that it happens before the machine
> hits the ground.  Also, that the harddrive is not going through one of
> the longish EH recovery sequences when it starts to fall.  :-(

Well, Lenovo (and others?) have implemented this in Windows somehow.. It 
would be interesting to know what solution they used there (either 
hardreset, issue the command even when busy, or just wait for the 
commands to hopefully finish in time).

