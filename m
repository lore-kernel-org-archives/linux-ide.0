From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 05/20] pata_efar: always program master_data before slave_data
Date: Wed, 23 Feb 2011 09:53:58 +0100
Message-ID: <AANLkTikNjMZitsq-XxKMs9hN4Q238tATMpkOwQ_xLk89@mail.gmail.com>
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
	<AANLkTi=jp+q9VYNJvko8P4ju_z86Rw5AxWY9O_reFDai@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:59709 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755139Ab1BWIx7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 23 Feb 2011 03:53:59 -0500
In-Reply-To: <AANLkTi=jp+q9VYNJvko8P4ju_z86Rw5AxWY9O_reFDai@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jgarzik@pobox.com>, Sergei Shtylyov <sshtylyov@mvista.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Feb 23, 2011 at 9:45 AM, Bartlomiej Zolnierkiewicz
<bzolnier@gmail.com> wrote:

> As for increased memory usage -- we are talking here only about 10-20=
k
> more. =A0If it really is a problem maybe ata_piix can be redesigned i=
nto
> ata_generic-style manner so with the help of existing config options
> we can keep code size / memory usage on a existing level.

s/ata_generic/pata_legacy/ of course -- what I have in mind is making
Intel specific code depended on ATA_PIIX and adding new config option
ATA_PIIXALIKE for generic code which would be selected by existing
PATA_[EFAR,IT8213, OLDPIIX,RADISYS,RDC] options.

Thanks,
Bartlomiej
