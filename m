From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: RE: IDE-RAID Drive Performance
Date: Tue, 30 Dec 2003 20:31:00 +0100 (CET)
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <Pine.GSO.4.58.0312302027390.3072@mion.elka.pw.edu.pl>
References: <S265848AbTL3QhM/20031230163712Z+18564@vger.kernel.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:43440 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265901AbTL3TbN
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 30 Dec 2003 14:31:13 -0500
In-Reply-To: <S265848AbTL3QhM/20031230163712Z+18564@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org
To: Nicklas Bondesson <nicke@nicke.nu>
Cc: 'Willy Gardiol' <willy@gardiol.org>, linux-ide@vger.kernel.org


No, that are only BIOS settings.
Driver may reprogram the controller.

On Tue, 30 Dec 2003, Nicklas Bondesson wrote:
> Look at this:
>
> PDC20271: not 100% native mode: will probe irqs later
>     ide0: BM-DMA at 0xa800-0xa807, BIOS settings: hda:pio, hdb:pio
>     ide1: BM-DMA at 0xa808-0xa80f, BIOS settings: hdc:pio, hdd:pio
>
> The controller is running in PIO mode not DMA. Could that have something to
> do with the bad speed?
