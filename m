From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 16/20] ata_piix: add EFAR SLC90E66 support
Date: Tue, 8 Feb 2011 15:01:45 +0100
Message-ID: <AANLkTimGRnOkBJWiGejonRKGVp5urXDNwa8DKovhNSt0@mail.gmail.com>
References: <20110208122314.19110.4092.sendpatchset@linux-mhg7.site>
	<20110208122534.19110.89437.sendpatchset@linux-mhg7.site>
	<20110208131321.6ceb9a43@lxorguk.ukuu.org.uk>
	<AANLkTikYXWAbCjLpSyEqgDKBsZuM1na-tohLoLJx3Yr4@mail.gmail.com>
	<20110208133809.2386ee86@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:40872 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754234Ab1BHOBr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 Feb 2011 09:01:47 -0500
In-Reply-To: <20110208133809.2386ee86@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Feb 8, 2011 at 2:38 PM, Alan Cox <alan@lxorguk.ukuu.org.uk> wro=
te:
>> such optimizations because maintenance cost > potential savings (i.e=
=2E
>> making SCSI quirks optional, I have draft patch for this, itself cut=
s
>> like 10k).
>
> Interesting in itself but irrelevant because the current situation is
> that a piix change cannot break oldpiix, efar, it8213, radisys etc an=
d
> vice versa. Particuarly important when the other chips are not common=
 so
> test coverage is difficult, and that far outweighs the maintenance
> savings for other things, especially as this is code that just doesn'=
t
> change.
>
>>
>> > It also leads to hideous uglies in the main code paths like this :
>> >
>> > + =A0 =A0 =A0 unsigned int has_sitre =A0=3D (dev->vendor !=3D 0x80=
86 ||
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0dev->device !=3D 0x1230);
>> >
>> > which also has exactly zero comments.
>>
>> has_sitre variable name is documentation in itself for anyone knowin=
g
>> the hardware or has read a chipset/code documentation.
>
> And naturally anyone randomly glancing at the code knows why it's
> checking 0x8086 & 0x1230, and why the radisys check interacts with it=
=2E
>
> Bartlomiej - those are a mess, a complete and total mess. It doesn't
> necessarily argue against folding them together, but at least do a cl=
ean
> job of it.

I beg to differ regardless "the mess" comment but well, you can always
take my work and "add value" to it like in 2009 (when somehow you miss
that your pata_rdc also needs locking fixes but you were more
concerned with little differences between my work and your
"dreamwork"..)
