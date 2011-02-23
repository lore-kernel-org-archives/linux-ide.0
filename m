From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 05/20] pata_efar: always program master_data before slave_data
Date: Wed, 23 Feb 2011 09:45:36 +0100
Message-ID: <AANLkTi=jp+q9VYNJvko8P4ju_z86Rw5AxWY9O_reFDai@mail.gmail.com>
References: <20110208122314.19110.4092.sendpatchset@linux-mhg7.site>
	<20110208122409.19110.4233.sendpatchset@linux-mhg7.site>
	<20110208130701.19709cc6@lxorguk.ukuu.org.uk>
	<AANLkTimAioh_xu0qoQCndSWDAYJ4bpWv01NZn_bZ9g2a@mail.gmail.com>
	<20110208132518.300bb098@lxorguk.ukuu.org.uk>
	<4D514754.30203@ru.mvista.com>
	<AANLkTinE5x=hmQ6Oykw3Tb38HVeL5eHxjdnPOdMt930q@mail.gmail.com>
	<4D62C5E1.9070307@pobox.com>
	<AANLkTi=NQLxRQ+HAsjtWz5HFu7kaJw9sp50kKyK_ZTDv@mail.gmail.com>
	<20110222111400.1114e8c5@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:55316 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755049Ab1BWIph convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 23 Feb 2011 03:45:37 -0500
In-Reply-To: <20110222111400.1114e8c5@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jgarzik@pobox.com>, Sergei Shtylyov <sshtylyov@mvista.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Feb 22, 2011 at 12:14 PM, Alan Cox <alan@lxorguk.ukuu.org.uk> w=
rote:
>> I was thinking about re-doing ata_piix part in a way that we could
>> merge it now by adding support for older PIIX-alikes to ata_piix and
>> making it enabled only if "all_piixalikes" module parameter is
>> specified. =A0 This way older drivers would be left untouched for no=
w
>> and we can easily get in-tree testing for a new code. =A0Does it sou=
nd
>> as a viable alternative?
>
> That is the bit to me that makes the least sense. Each of the devices=
 in
> question is found only in the chipset so they can never be in combina=
tion
> on a board (except multiple PIIX4 which is already covered)
>
> Merging them makes it more likely stuff breaks and increases memory u=
sage
> - its a lose/lose situation.

Each device is very similar to other one, so keeping 6 drivers for the
(almost) same stuff makes a little sense from the long-term
maintainability POV,  It is a question of different trade-offs since
on the other side of equation we have 5 drivers less, 1400 LOCs less,
no risk of losing bugfixes and features (which is true already w/
pata_rdc lacking locking fixes + Power Management and pata_oldpiix
lacking parallel scanning feature).

As for increased memory usage -- we are talking here only about 10-20k
more.  If it really is a problem maybe ata_piix can be redesigned into
ata_generic-style manner so with the help of existing config options
we can keep code size / memory usage on a existing level.

Thanks,
Bartlomiej
