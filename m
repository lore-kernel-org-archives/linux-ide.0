From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 3/5] libata: Implement disk shock protection support
Date: Tue, 05 Aug 2008 08:26:49 +0900
Message-ID: <48979039.4000000@gmail.com>
References: <87prp1kvyy.fsf@denkblock.local>	<20080726062142.29070.10413.stgit@denkblock.local>	<4892B8FE.1070400@gmail.com> <87proooqry.fsf@denkblock.local>	<48970E34.9000706@gmail.com> <87d4kooh4k.fsf@denkblock.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.188]:64819 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755941AbYHDX10 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Aug 2008 19:27:26 -0400
Received: by ti-out-0910.google.com with SMTP id b6so563770tic.23
        for <linux-ide@vger.kernel.org>; Mon, 04 Aug 2008 16:27:25 -0700 (PDT)
In-Reply-To: <87d4kooh4k.fsf@denkblock.local>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Elias Oltmanns <eo@nebensachen.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jeff@garzik.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, Pavel Machek <pavel@ucw.cz>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Elias Oltmanns wrote:
>>> I'm rather afraid this approach is impractical or unfavourable at the
>>> very least. Depending on the configured thresholds, a head unload
>>> request might well be issued unintentionally, e.g. by accidentally
>>> knocking against the table. It is quite alright for the HD to stop I/O
>>> for a moment but if the secondary device on the interface happens to be
>>> a CD writer, it will be very annoying to have CD writing operations fail
>>> due to minor percussions.
>> Why would it fail?
> 
> To be quite honest, I don't know very much about the way CD writing
> works. I just assumed that delaying queue processing for a CD writer for
> several seconds would have very much the same effect as the input buffer
> of cdrecord getting empty prematurely. Do you mean to say that CD
> writing (or any other time expensive operation I haven't thought of)
> won't be affected irrecoverably by interrupted command processing?

Any modern cd/dvd writer can happily recover from buffer underruns.  I
think the physical shock itself has better chance of screwing up the
recording.  The only thing to make sure is that no command is issued to
ATAPI devices.  Other than that, there should be no problem.

>>> Also, if there are two devices on the same
>>> port that support the UNLOAD FEATURE and you issue a head unload request
>>> to both of them in close succession, the IDLE IMMEDIATE to the second
>>> device will be blocked until the timeout for the first has expired.
>> Unload can be implemented as port-wide operation so that it issues IDLE
>> IMMEDIATE to all drives on the port but given that this is mostly for
>> laptop, this discussion is a bit peripheral.
> 
> We can't rule out that the HD is connected as master and CDRW as slave
> to the same controller in a PATA setup. I'm not familiar with the SATA
> configurations in modern laptops though.

On most, they occupy different channels and even when they reside on the
same channel, it just doesn't really matter these days.  And even on
those cases, it would be better to use EH as that will make the IDLE
IMMEDIATE command always win the bus as soon as possible while IDLE
IMMEDIATE queued at the head of the drive queue could lose to an ATAPI
command.

Thanks.

-- 
tejun
