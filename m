From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 05/20] pata_efar: always program master_data before slave_data
Date: Tue, 22 Feb 2011 10:19:07 +0100
Message-ID: <AANLkTi=NQLxRQ+HAsjtWz5HFu7kaJw9sp50kKyK_ZTDv@mail.gmail.com>
References: <20110208122314.19110.4092.sendpatchset@linux-mhg7.site>
	<20110208122409.19110.4233.sendpatchset@linux-mhg7.site>
	<20110208130701.19709cc6@lxorguk.ukuu.org.uk>
	<AANLkTimAioh_xu0qoQCndSWDAYJ4bpWv01NZn_bZ9g2a@mail.gmail.com>
	<20110208132518.300bb098@lxorguk.ukuu.org.uk>
	<4D514754.30203@ru.mvista.com>
	<AANLkTinE5x=hmQ6Oykw3Tb38HVeL5eHxjdnPOdMt930q@mail.gmail.com>
	<4D62C5E1.9070307@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:63665 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752862Ab1BVJTI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 22 Feb 2011 04:19:08 -0500
In-Reply-To: <4D62C5E1.9070307@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Sergei Shtylyov <sshtylyov@mvista.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

On Mon, Feb 21, 2011 at 9:06 PM, Jeff Garzik <jgarzik@pobox.com> wrote:
> On 02/19/2011 04:25 AM, Bartlomiej Zolnierkiewicz wrote:
>>
>> Jeff, would it be possible to queue patches #01-15 for 2.6.39 if the=
re
>> are no further concerns with them (thus leaving the merging of
>> PIIX-like drivers for later)? =A0They got additional testing on ICH4=
 and
>> they look mostly safe& =A0straight-forward compared to #16-21.
>
> This seems to directly contradict what you wrote earlier in the threa=
d,
>
> =A0 =A0 =A0 =A0This is why patches were posted to mailing list with a=
 request
> =A0 =A0 =A0 =A0for a real hardware testing:
>
> =A0 =A0 =A0 =A0"All testing was done using QEMU's PIIX3 controller em=
ulation
> =A0 =A0 =A0 =A0so any testing with real EFAR, IT8213, old PIIX, RDC a=
nd
> =A0 =A0 =A0 =A0Radisys R82600 PATA controllers would be really apprec=
iated.."
>
> =A0 =A0 =A0 =A0instead of request for a merge. =A0It was all there in=
 initial
> =A0 =A0 =A0 =A0mail.
>
> and
>
> =A0 =A0 =A0 =A0I do not really care that much if it will be merged ev=
er
>
> Regardless of this self-contradictory attitude, I do want useful patc=
hes and
> many of these patches seem useful.

Nothing self-contradictory there. :)

=46irst quote is about patches #01-15 only, not whole patchset (#01-20)
like the second one, and I still don't care _that_ much personally if
it gets merged since it is all unpaid & voluntary work.

> So I will continue watching the Bart/Alan/Sergei threads play out, an=
d then
> look at merging the result. =A0In the midst of all the arguing, produ=
ctive
> work / forward progress is occurring, so the end result should be pos=
itive.
>
> It would be nice if we could get at least an "it works" test for the =
older
> hardware, since those are the changes /least/ likely to be tested by
> queueing to linux-next.

I was thinking about re-doing ata_piix part in a way that we could
merge it now by adding support for older PIIX-alikes to ata_piix and
making it enabled only if "all_piixalikes" module parameter is
specified.   This way older drivers would be left untouched for now
and we can easily get in-tree testing for a new code.  Does it sound
as a viable alternative?

Thanks,
Bartlomiej
