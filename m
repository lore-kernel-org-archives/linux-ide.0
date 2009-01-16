From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RFC][PATCH] at91_ide driver
Date: Fri, 16 Jan 2009 16:13:42 +0000
Message-ID: <20090116161342.4229667f@lxorguk.ukuu.org.uk>
References: <200901141345.42583.stf_xl@wp.pl>
	<20090114131727.5b0e5193@lxorguk.ukuu.org.uk>
	<49708C55.1020204@ru.mvista.com>
	<200901161603.03699.stf_xl@wp.pl>
	<4970A8FF.4080404@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:51770 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1764966AbZAPQO2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 16 Jan 2009 11:14:28 -0500
In-Reply-To: <4970A8FF.4080404@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Stanislaw Gruszka <stf_xl@wp.pl>, Andrew Victor <linux@maxim.org.za>, Nicolas Ferre <nicolas.ferre@atmel.com>, Haavard Skinnemoen <haavard.skinnemoen@atmel.com>, linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, ddaney@caviumnetworks.com

> the PIO transfer speeds (very significantly) though I'm not sure of the 
> current state of affairs...

16bit only performance is identical (as you'd expect) 32bit is now
identical with the 32bit pio patches applied
