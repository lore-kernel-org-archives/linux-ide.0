From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: libata default FUA support
Date: Wed, 2 Mar 2011 22:33:19 -0600
Message-ID: <AANLkTikqm0X_quj_y1-1UqbHeFLDMaFLbFB8o0JKXmRL@mail.gmail.com>
References: <20110301203313.GA1656@gentoo.trippels.de>
	<4D6D952D.8030609@gmail.com>
	<4D6DF231.5090702@msgid.tls.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:35058 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758136Ab1CCEdT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 Mar 2011 23:33:19 -0500
Received: by iwn34 with SMTP id 34so606688iwn.19
        for <linux-ide@vger.kernel.org>; Wed, 02 Mar 2011 20:33:19 -0800 (PST)
In-Reply-To: <4D6DF231.5090702@msgid.tls.msk.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Markus Trippelsdorf <markus@trippelsdorf.de>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

On Wed, Mar 2, 2011 at 1:30 AM, Michael Tokarev <mjt@tls.msk.ru> wrote:
> 02.03.2011 03:54, Robert Hancock wrote:
>> On 03/01/2011 02:33 PM, Markus Trippelsdorf wrote:
>>> FUA support is currently switched off by default in
>>> drivers/ata/libata-core.c.
>>> Given that many modern drives do support FUA now, wouldn't it make =
sense
>>> to switch it on without setting a (undocumented) kernel/module
>>> parameter?
>
> After reading your email Markus, I rebooted two my home boxes
> after adding libata.fua=3D1 to the kernel line. =A0And to my surprize=
,
> only one, the oldest, drive from 3 I have supports it. =A0I've
> two WDs, one is the famous WD20EARS (first series with "advanced
> format", ie, 4kb sectors, and 2Tb size) which is less than half
> a year old, and another WD7500AACS, 750Gb, their prev-gen variant,
> both "green" series. =A0And another from Hitachi, one of their
> "enterprize" series, 500Gb HUA7210, bought about 3 years ago.
> From the 3, only Hitachi reports "supports DPO and FUA" after
> rebooting with fua=3D1.

That only refers to the non-NCQ FUA support. FUA support for NCQ
appears to be mandatory but libata doesn't currently do this (i.e. FUA
is only reported if the drive reports the non-NCQ FUA commands are
supported).

>
>> I believe I proposed this some time ago. Essentially all modern driv=
es
>> should support FUA now, since it's part of the definition of the NCQ
>> (FPDMA) read/write commands. However, as I recall one of the objecti=
ons
>> to enabling it was that since it's just a bit in a command, there's =
a
>> possibility that some drives may ignore it by accident or design, wh=
ich
>> is less likely with an explicit cache flush command. I'm not very
>> inclined to agree myself (if you go down that road of pre-emptively
>> predicting drive implementer stupidity, where do you stop?) but that=
's
>> what was raised.
>
> This is interesting as per above - the WDs I have definitely supports
> NCQ, and does that quite well (their scalability is a bit better than
> the one from Hitachi), but does not support FUA, or at least linux
> treats them as such.
>
>> Another complication is that NCQ can be disabled at runtime either b=
y
>> user request or by error-handling fallback, and not all drives that
>> support NCQ also support the FUA versions of the non-NCQ read/write
>> commands, so changes in NCQ enable status may also need to result in
>> changes in FUA support status on the block device.
>
> Well, the only way to find out is to actually try to enable it.
> So far, the hitachi drive (which is a main drive on this my
> workstation, -- system, development, compilation etc) works
> without issues, and kernel compile time reduced for about 2%
> (I didn't perform good tests so far, so that 2% may be just
> random noize - will take a closer look in a few days to this).
>
>> I believe the way the block layer uses it, basically it only saves t=
he
>> overhead of one transaction to the drive. It might be significant on
>> some workloads (especially on high IOPS drives like SSDs) but it's
>> likely not a huge deal.
>
> One transaction per what? =A0If it means extra, especially "large"
> transaction (lile flush with a wait) per each fsync-like call,
> that can be huge deal actually, especially on database-like
> workloads (lots of small syncronous random writes).
>
> Thanks!
>
> /mjt
>
