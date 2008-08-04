From: Elias Oltmanns <eo@nebensachen.de>
Subject: Re: [PATCH 3/5] libata: Implement disk shock protection support
Date: Mon, 04 Aug 2008 15:43:38 +0200
Message-ID: <87ljzcopyt.fsf@denkblock.local>
References: <87prp1kvyy.fsf@denkblock.local>
	<20080726062142.29070.10413.stgit@denkblock.local>
	<4892B8FE.1070400@gmail.com>
	<20080801233459.11e9b254@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nebensachen.de ([195.34.83.29]:55168 "EHLO mail.nebensachen.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752627AbYHDNrB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 4 Aug 2008 09:47:01 -0400
In-Reply-To: <20080801233459.11e9b254@lxorguk.ukuu.org.uk> (Alan Cox's message
	of "Fri, 1 Aug 2008 23:34:59 +0100")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jeff@garzik.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, Pavel Machek <pavel@ucw.cz>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>> However, SATA or not, there simply isn't a way to abort commands in ATA.
>
>>  Issuing random command while other commands are in progress simply is
>> state machine violation and there will be many interesting results
>> including complete system lockup (ATA controller dying while holding the
>> PCI bus).  The only reliable way to abort in-flight commands are by
>> issuing hardreset.  However, ATA reset protocol is not designed for
>> quick recovery.  The machine is gonna hit the ground hard way before the
>> reset protocol is complete.
>
> Actually you cau can issue idle immediate on older ATA devices. I am not
> clear if that was stuck back into the current accelerometer friendly
> drives or not. Would need to check with IBLenovo

In ide_atapi_error() IDLE IMMEDIATE is issued even if busy bit is still
set. This made me hope that we could do something similar wrt disk head
unloading. However, since I haven't found anything about this in the
specs and considering Tejun's comments, I'm now wondering whether the
code in ide_atapi_error() isn't a little imprudent. Also, as long as
nothing definite is said about it in the specs, we can only issue IDLE
IMMEDIATE in parallel to other commands on devices we know to support
it, right?

Regards,

Elias
