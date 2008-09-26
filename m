From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PROBLEM: SATA PCI on SB600: unable to reserve I/O region
Date: Fri, 26 Sep 2008 19:32:30 +0100
Message-ID: <20080926193230.21cbf77b@lxorguk.ukuu.org.uk>
References: <20080926151346.GA22930@mail.bin>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:39525 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750885AbYIZScd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 26 Sep 2008 14:32:33 -0400
In-Reply-To: <20080926151346.GA22930@mail.bin>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Piet Plomp <piet@bioinf.nl>
Cc: linux-ide@vger.kernel.org

>   0170-0177 : 0000:00:12.0
>     0170-0177 : ide_generic
>   01f0-01f7 : 0000:00:12.0
>     01f0-01f7 : ide_generic

You have old IDE enabled as well so old IDE claimed the device


>   Probing IDE interface ide0...
>   Probing IDE interface ide1...
>   ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
>   ide1 at 0x170-0x177,0x376 on irq 15

S
