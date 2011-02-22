From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 05/20] pata_efar: always program master_data before
 slave_data
Date: Tue, 22 Feb 2011 11:14:00 +0000
Message-ID: <20110222111400.1114e8c5@lxorguk.ukuu.org.uk>
References: <20110208122314.19110.4092.sendpatchset@linux-mhg7.site>
	<20110208122409.19110.4233.sendpatchset@linux-mhg7.site>
	<20110208130701.19709cc6@lxorguk.ukuu.org.uk>
	<AANLkTimAioh_xu0qoQCndSWDAYJ4bpWv01NZn_bZ9g2a@mail.gmail.com>
	<20110208132518.300bb098@lxorguk.ukuu.org.uk>
	<4D514754.30203@ru.mvista.com>
	<AANLkTinE5x=hmQ6Oykw3Tb38HVeL5eHxjdnPOdMt930q@mail.gmail.com>
	<4D62C5E1.9070307@pobox.com>
	<AANLkTi=NQLxRQ+HAsjtWz5HFu7kaJw9sp50kKyK_ZTDv@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:59721 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752260Ab1BVLNA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 22 Feb 2011 06:13:00 -0500
In-Reply-To: <AANLkTi=NQLxRQ+HAsjtWz5HFu7kaJw9sp50kKyK_ZTDv@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Sergei Shtylyov <sshtylyov@mvista.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

> I was thinking about re-doing ata_piix part in a way that we could
> merge it now by adding support for older PIIX-alikes to ata_piix and
> making it enabled only if "all_piixalikes" module parameter is
> specified.   This way older drivers would be left untouched for now
> and we can easily get in-tree testing for a new code.  Does it sound
> as a viable alternative?

That is the bit to me that makes the least sense. Each of the devices in
question is found only in the chipset so they can never be in combination
on a board (except multiple PIIX4 which is already covered)

Merging them makes it more likely stuff breaks and increases memory usage
- its a lose/lose situation.

Alan
