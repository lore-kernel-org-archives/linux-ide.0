From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] pata_hpt37x: Fix outstanding bug reports on the HPT374
 and 37x cable detect
Date: Tue, 6 Nov 2007 14:59:35 +0000
Message-ID: <20071106145935.154b9335@the-village.bc.nu>
References: <20071105225338.20ef476f@the-village.bc.nu>
	<47307DEE.3050700@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:55191 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751938AbXKFO73 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Nov 2007 09:59:29 -0500
In-Reply-To: <47307DEE.3050700@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: akpm@osdl.org, jeff@garzik.org, linux-ide@vger.kernel.org

> > +	if (chip_table == &hpt374) {
> > +		freq = hpt374_read_freq(dev);
> > +		if (freq == 0)
> > +			return -ENODEV;
> 
>     Not sure whether this check is necessary...

If the device is hot unplugged we can get a zero return error case. It
seems cleaner to catch the error case rather than attempt to prove it
does no harm later.

pre_reset one fixed in my tree and will check and push.
