From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: Promise PDC20269 - PIO Only?
Date: Tue, 21 Oct 2003 16:27:08 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200310211627.08401.bzolnier@elka.pw.edu.pl>
References: <200310181819.08930.jeremyhu@uclink4.berkeley.edu> <200310201315.34213.jeremyhu@uclink4.berkeley.edu> <1066700373.3723.2.camel@eradicator.outersquare.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:56555 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263102AbTJUOW5
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 21 Oct 2003 10:22:57 -0400
In-Reply-To: <1066700373.3723.2.camel@eradicator.outersquare.org>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Jeremy Huddleston <jeremy@outersquare.org>
Cc: linux-ide@vger.kernel.org


DMA is enabled correctly on all drives by Linux IDE driver,
(please note that BIOS leaved them in PIO).

--bartlomiej

> Oct 20 18:32:04 eradicator hde: attached ide-disk driver.
> Oct 20 18:32:04 eradicator hde: host protected area => 1
> Oct 20 18:32:04 eradicator hde: 240121728 sectors (122942 MB) w/7936KiB
> Cache, CHS=238216/16/63, UDMA(133)
> Oct 20 18:32:04 eradicator hdg: attached ide-disk driver.
> Oct 20 18:32:04 eradicator hdg: host protected area => 1
> Oct 20 18:32:04 eradicator hdg: 240121728 sectors (122942 MB) w/7936KiB
> Cache, CHS=238216/16/63, UDMA(133)
> Oct 20 18:32:04 eradicator hdh: attached ide-disk driver.
> Oct 20 18:32:04 eradicator hdh: host protected area => 1
> Oct 20 18:32:04 eradicator hdh: 240121728 sectors (122942 MB) w/2048KiB
> Cache, CHS=14946/255/63, UDMA(133)
> Oct 20 18:32:04 eradicator hdi: attached ide-disk driver.
> Oct 20 18:32:04 eradicator hdi: host protected area => 1
> Oct 20 18:32:04 eradicator hdi: 320173056 sectors (163929 MB) w/7936KiB
> Cache, CHS=19929/255/63, UDMA(133)
> Oct 20 18:32:04 eradicator hdk: attached ide-disk driver.
> Oct 20 18:32:04 eradicator hdk: host protected area => 1
> Oct 20 18:32:04 eradicator hdk: 320173056 sectors (163929 MB) w/7936KiB
> Cache, CHS=19929/255/63, UDMA(133)

