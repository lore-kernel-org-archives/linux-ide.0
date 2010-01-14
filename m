From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Don't use UDMA on VIA UDMA33 controller with Transcend
 SSD
Date: Thu, 14 Jan 2010 19:24:10 +0000
Message-ID: <20100114192410.33b989d5@lxorguk.ukuu.org.uk>
References: <Pine.LNX.4.64.0910211452160.17897@hs20-bc2-1.build.redhat.com>
	<20091026121804.3789c4c0@lxorguk.ukuu.org.uk>
	<Pine.LNX.4.64.0911042021530.19963@hs20-bc2-1.build.redhat.com>
	<201001141649.13073.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:34057 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757028Ab0ANTVR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 Jan 2010 14:21:17 -0500
In-Reply-To: <201001141649.13073.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Mikulas Patocka <mpatocka@redhat.com>, David Miller <davem@davemloft.net>, linux-ide@vger.kernel.org

> The computer locks up if Transcend SSD runs in any of UDMA modes.
> It doesn't lockup with different brand SSD, so this is specific to Transcend.
> 
> bzolnier:
> - limit it to VT82C586A/B + TS64GSSD25-M (per commit 10734fc) for now
> - add warning message

Looks good to me.


> +		printk(KERN_WARNING "%s: disabling UDMA mode due to reported "
> +			"lockups with this device.\n", drive->name);

That sounds odd - I think I'd have put ": not using UDMA mode as lockups
have been reported with this device" or similar.

Ackity-ack
