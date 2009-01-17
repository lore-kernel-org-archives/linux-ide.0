From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RFC][PATCH] at91_ide driver
Date: Sat, 17 Jan 2009 20:20:36 +0000
Message-ID: <20090117202036.610cdcb5@lxorguk.ukuu.org.uk>
References: <200901141345.42583.stf_xl@wp.pl>
	<20090114131727.5b0e5193@lxorguk.ukuu.org.uk>
	<49708C55.1020204@ru.mvista.com>
	<200901161603.03699.stf_xl@wp.pl>
	<4970A8FF.4080404@ru.mvista.com>
	<20090116161342.4229667f@lxorguk.ukuu.org.uk>
	<49723AB5.7000809@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:50276 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754465AbZAQUZg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 17 Jan 2009 15:25:36 -0500
In-Reply-To: <49723AB5.7000809@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Stanislaw Gruszka <stf_xl@wp.pl>, Andrew Victor <linux@maxim.org.za>, Nicolas Ferre <nicolas.ferre@atmel.com>, Haavard Skinnemoen <haavard.skinnemoen@atmel.com>, linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, ddaney@caviumnetworks.com

> (many years ago) with and without 32-bit access enabled in the BIOS 
> Setup and not seeing any significant differences. Perhpas it's worth to 
> re-benchmark this in Linux if I find the time...

On the intel chipsets I have it nearly doubles PIO speed, ditto on the
Delkin cardbus.
