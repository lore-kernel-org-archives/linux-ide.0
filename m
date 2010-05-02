From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Using PATA Platform Driver to access Memory Mapped CF Card
Date: Sun, 2 May 2010 13:29:13 +0100
Message-ID: <20100502132913.1e531bfd@lxorguk.ukuu.org.uk>
References: <4BDAE529.20903@gmail.com>
	<201005010524.40949.marek.vasut@gmail.com>
	<4BDBD4AB.8020200@gmail.com>
	<20100501113346.29225519@lxorguk.ukuu.org.uk>
	<4BDD6897.7000002@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:52449 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752649Ab0EBMX2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 May 2010 08:23:28 -0400
In-Reply-To: <4BDD6897.7000002@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Graeme Russ <graeme.russ@gmail.com>
Cc: linux-ide@vger.kernel.org

> pata_platform_port_ops (.sff_data_xfer = ata_sff_data_xfer_noirq). So I
> will need to create custom data_xfer_noirq and data_xfer functions for the
> 8-bit transfers. Is there an elegant way to override pata_platform's use of
> ata_sff_data_xfer_noirq or will I need to also write a new version of
> pata_platform as well?

Extending pata_platform_info is probably the right thing to do - and
allow it to override the data_xfer operation if a new data_xfer field is
non NULL. See include/linux/ata_platform.h.

So you'll need to tweak pata_platform a spot. Alternatively you could
write a small libata driver specifically for your device - which may make
sense if it supports higher speed modes and speed setting stuff.

Alan
