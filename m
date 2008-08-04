From: Elias Oltmanns <eo@nebensachen.de>
Subject: Re: [PATCH 3/5] libata: Implement disk shock protection support
Date: Mon, 04 Aug 2008 18:54:35 +0200
Message-ID: <87d4kooh4k.fsf@denkblock.local>
References: <87prp1kvyy.fsf@denkblock.local>
	<20080726062142.29070.10413.stgit@denkblock.local>
	<4892B8FE.1070400@gmail.com> <87proooqry.fsf@denkblock.local>
	<48970E34.9000706@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nebensachen.de ([195.34.83.29]:44495 "EHLO mail.nebensachen.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753551AbYHDQ55 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 4 Aug 2008 12:57:57 -0400
In-Reply-To: <48970E34.9000706@gmail.com> (Tejun Heo's message of "Mon, 04 Aug
	2008 23:12:04 +0900")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jeff@garzik.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, Pavel Machek <pavel@ucw.cz>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Tejun Heo <htejun@gmail.com> wrote:
> Elias Oltmanns wrote:
>>> For libata, the easiest way to achieve the above would be adding a
>
>>> per-dev EH action, say, ATA_EH_UNLOAD and schedule EH w/ the action OR'd
>>> to eh_info->action.  The EH_UNLOAD handler can then issue the command
>>> wait for the specified number of seconds and continue.  This will be
>>> pretty simple to implement as command exclusion and stuff are all
>>> automatically handled by EH framework.
>> 
>> I'm rather afraid this approach is impractical or unfavourable at the
>> very least. Depending on the configured thresholds, a head unload
>> request might well be issued unintentionally, e.g. by accidentally
>> knocking against the table. It is quite alright for the HD to stop I/O
>> for a moment but if the secondary device on the interface happens to be
>> a CD writer, it will be very annoying to have CD writing operations fail
>> due to minor percussions.
>
> Why would it fail?

To be quite honest, I don't know very much about the way CD writing
works. I just assumed that delaying queue processing for a CD writer for
several seconds would have very much the same effect as the input buffer
of cdrecord getting empty prematurely. Do you mean to say that CD
writing (or any other time expensive operation I haven't thought of)
won't be affected irrecoverably by interrupted command processing?

>
>> Also, if there are two devices on the same
>> port that support the UNLOAD FEATURE and you issue a head unload request
>> to both of them in close succession, the IDLE IMMEDIATE to the second
>> device will be blocked until the timeout for the first has expired.
>
> Unload can be implemented as port-wide operation so that it issues IDLE
> IMMEDIATE to all drives on the port but given that this is mostly for
> laptop, this discussion is a bit peripheral.

We can't rule out that the HD is connected as master and CDRW as slave
to the same controller in a PATA setup. I'm not familiar with the SATA
configurations in modern laptops though.

Regards,

Elias
