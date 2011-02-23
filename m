From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 05/20] pata_efar: always program master_data before
 slave_data
Date: Wed, 23 Feb 2011 09:14:37 +0000
Message-ID: <20110223091437.0fb888a2@lxorguk.ukuu.org.uk>
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
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:60745 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932088Ab1BWJNR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 23 Feb 2011 04:13:17 -0500
In-Reply-To: <AANLkTi=jp+q9VYNJvko8P4ju_z86Rw5AxWY9O_reFDai@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Sergei Shtylyov <sshtylyov@mvista.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

> on the other side of equation we have 5 drivers less, 1400 LOCs less,
> no risk of losing bugfixes and features (which is true already w/
> pata_rdc lacking locking fixes + Power Management and pata_oldpiix
> lacking parallel scanning feature).

The parallel scanning feature is somewhat irrelevant on an original PIIX,
if the hardware even supports it which is somewhat of an unknown. If you
have a minor boot time performance concern you'd buy a real computer
instead.

And the other stuff you actually create a problem rather than solving one
- the difficulting testing the rare chips makes it harder to fix ata_piix
bugs and do full testing.

Alan
