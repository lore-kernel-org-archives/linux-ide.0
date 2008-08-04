From: Elias Oltmanns <eo@nebensachen.de>
Subject: Re: [PATCH 3/5] libata: Implement disk shock protection support
Date: Mon, 04 Aug 2008 15:26:09 +0200
Message-ID: <87proooqry.fsf@denkblock.local>
References: <87prp1kvyy.fsf@denkblock.local>
	<20080726062142.29070.10413.stgit@denkblock.local>
	<4892B8FE.1070400@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nebensachen.de ([195.34.83.29]:37777 "EHLO mail.nebensachen.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751367AbYHDN3c (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 4 Aug 2008 09:29:32 -0400
In-Reply-To: <4892B8FE.1070400@gmail.com> (Tejun Heo's message of "Fri, 01 Aug
	2008 16:19:26 +0900")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jeff@garzik.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, Pavel Machek <pavel@ucw.cz>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Tejun Heo <htejun@gmail.com> wrote:
> Elias Oltmanns wrote:
>> On user request (through sysfs), the IDLE IMMEDIATE command with UNLOAD
>
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

I'm rather afraid this approach is impractical or unfavourable at the
very least. Depending on the configured thresholds, a head unload
request might well be issued unintentionally, e.g. by accidentally
knocking against the table. It is quite alright for the HD to stop I/O
for a moment but if the secondary device on the interface happens to be
a CD writer, it will be very annoying to have CD writing operations fail
due to minor percussions. Also, if there are two devices on the same
port that support the UNLOAD FEATURE and you issue a head unload request
to both of them in close succession, the IDLE IMMEDIATE to the second
device will be blocked until the timeout for the first has expired.

Generally, blocking SRST and the likes on a port seems acceptable, but
stopping all I/O on a port just because a head unload request has been
issued to a single device attached to it is not an option.

>
> However, SATA or not, there simply isn't a way to abort commands in ATA.
>  Issuing random command while other commands are in progress simply is
> state machine violation and there will be many interesting results
> including complete system lockup (ATA controller dying while holding the
> PCI bus).  The only reliable way to abort in-flight commands are by
> issuing hardreset.  However, ATA reset protocol is not designed for
> quick recovery.  The machine is gonna hit the ground hard way before the
> reset protocol is complete.

Yes, I suspected as much. Thanks for the confirmation.

[...]
>
> Well, short of that, all we can do is to wait for the currently
> in-flight commands to drain and hope that it happens before the machine
> hits the ground.  Also, that the harddrive is not going through one of
> the longish EH recovery sequences when it starts to fall.  :-(

Yes, it's a bit unsatisfactory but it's better than nothing.

Regards,

Elias
