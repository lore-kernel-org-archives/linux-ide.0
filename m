From: Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: libata default FUA support
Date: Wed, 02 Mar 2011 10:30:57 +0300
Message-ID: <4D6DF231.5090702@msgid.tls.msk.ru>
References: <20110301203313.GA1656@gentoo.trippels.de> <4D6D952D.8030609@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from isrv.corpit.ru ([86.62.121.231]:51020 "EHLO isrv.corpit.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751138Ab1CBHbA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 2 Mar 2011 02:31:00 -0500
In-Reply-To: <4D6D952D.8030609@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: Markus Trippelsdorf <markus@trippelsdorf.de>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

02.03.2011 03:54, Robert Hancock wrote:
> On 03/01/2011 02:33 PM, Markus Trippelsdorf wrote:
>> FUA support is currently switched off by default in
>> drivers/ata/libata-core.c.
>> Given that many modern drives do support FUA now, wouldn't it make sense
>> to switch it on without setting a (undocumented) kernel/module
>> parameter?

After reading your email Markus, I rebooted two my home boxes
after adding libata.fua=1 to the kernel line.  And to my surprize,
only one, the oldest, drive from 3 I have supports it.  I've
two WDs, one is the famous WD20EARS (first series with "advanced
format", ie, 4kb sectors, and 2Tb size) which is less than half
a year old, and another WD7500AACS, 750Gb, their prev-gen variant,
both "green" series.  And another from Hitachi, one of their
"enterprize" series, 500Gb HUA7210, bought about 3 years ago.
>From the 3, only Hitachi reports "supports DPO and FUA" after
rebooting with fua=1.

> I believe I proposed this some time ago. Essentially all modern drives
> should support FUA now, since it's part of the definition of the NCQ
> (FPDMA) read/write commands. However, as I recall one of the objections
> to enabling it was that since it's just a bit in a command, there's a
> possibility that some drives may ignore it by accident or design, which
> is less likely with an explicit cache flush command. I'm not very
> inclined to agree myself (if you go down that road of pre-emptively
> predicting drive implementer stupidity, where do you stop?) but that's
> what was raised.

This is interesting as per above - the WDs I have definitely supports
NCQ, and does that quite well (their scalability is a bit better than
the one from Hitachi), but does not support FUA, or at least linux
treats them as such.

> Another complication is that NCQ can be disabled at runtime either by
> user request or by error-handling fallback, and not all drives that
> support NCQ also support the FUA versions of the non-NCQ read/write
> commands, so changes in NCQ enable status may also need to result in
> changes in FUA support status on the block device.

Well, the only way to find out is to actually try to enable it.
So far, the hitachi drive (which is a main drive on this my
workstation, -- system, development, compilation etc) works
without issues, and kernel compile time reduced for about 2%
(I didn't perform good tests so far, so that 2% may be just
random noize - will take a closer look in a few days to this).

> I believe the way the block layer uses it, basically it only saves the
> overhead of one transaction to the drive. It might be significant on
> some workloads (especially on high IOPS drives like SSDs) but it's
> likely not a huge deal.

One transaction per what?  If it means extra, especially "large"
transaction (lile flush with a wait) per each fsync-like call,
that can be huge deal actually, especially on database-like
workloads (lots of small syncronous random writes).

Thanks!

/mjt
