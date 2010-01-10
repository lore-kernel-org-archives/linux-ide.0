From: Torsten Kaiser <just.for.lkml@googlemail.com>
Subject: Re: MSI broken in libata?
Date: Sun, 10 Jan 2010 05:33:58 +0100
Message-ID: <64bb37e1001092033r1f0b4defw46c1a07101bb2d1b@mail.gmail.com>
References: <64bb37e0912250122n4e0e1842q88c0dad7e99ec6a7@mail.gmail.com>
	 <4B484829.6060405@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f225.google.com ([209.85.220.225]:61469 "EHLO
	mail-fx0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750783Ab0AJEeA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 9 Jan 2010 23:34:00 -0500
In-Reply-To: <4B484829.6060405@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

On Sat, Jan 9, 2010 at 10:11 AM, Tejun Heo <tj@kernel.org> wrote:
> On 12/25/2009 06:22 PM, Torsten Kaiser wrote:
>> As reported in http://lkml.org/lkml/2009/12/19/82 the new MSI suppor=
t
>> for sata_sil24 does not work for me.
>> This is still the same with 2.6.33-rc2.
>>
>> Why I think, this might be a problem within libata:
>> =A0* other drivers can use MSI successful on my system (tg3, radeon,=
 hda-intel)
>> =A0* happens both in sata_sil24 and sata_nv
>> =A0* the count in /proc/interrupts increases for the MSIs assigned t=
o
>> sata_sil24/sata_nv, so interrupt delivery seems to work
>> =A0* only writing seems to fail
>
> How does it fail? =A0Timeouts?

Yes, timeouts.
I posted the error messages in http://lkml.org/lkml/2009/12/19/82 and
http://lkml.org/lkml/2010/1/6/60

> Also, ahci enables MSI by default if
> available and works fine on many configurations so I don't think
> anything in libata core layer is broken regarding MSI (there just
> isn't anything which can break).

The system I'm using does not have a ahci compatible controller, so I
could not compare this.
(And my other system that is using ahci, does not use MSI for that)

I just found it suspicious that 3 other drivers (tg3, hda-intel and
radeon) can use MSI, but both of the libata drivers (sata_sil24 and
sata_nv) fail in a similar way.

I did try the patch from Robert Hancock in
http://lkml.org/lkml/2010/1/6/417 ,but without success.

if you need any more information, or have something for me to try,
please just ask. I did look at the code and the documentation about
enabling MSI, but did not see anything (obvious) wrong, so I don't
know what to try next.

Torsten
