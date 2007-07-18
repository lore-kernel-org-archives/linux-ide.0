From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Recommendations on user-space soft/hardreset
Date: Wed, 18 Jul 2007 13:54:35 +0100
Message-ID: <20070718135435.42e4b3f8@the-village.bc.nu>
References: <6b01c6170707171723p4fdae403hf5b605fce4595b7@mail.gmail.com>
	<6b01c6170707171734l12af7fbdt43c28edd32776858@mail.gmail.com>
	<20070718014534.6a0adffe@the-village.bc.nu>
	<6b01c6170707171800t39f2aac5x80a6d33b892fbda8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:39564 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753594AbXGRMr6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Jul 2007 08:47:58 -0400
In-Reply-To: <6b01c6170707171800t39f2aac5x80a6d33b892fbda8@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: flyashi@gmail.com
Cc: linux-ide@vger.kernel.org

> You mean:
> 
> static const struct ata_port_operations sil24_ops = {
> ...
> 	.error_handler		= sil24_error_handler,
> ...
> which then calls
> 	ata_do_eh(ap, ata_std_prereset, sil24_softreset, sil24_hardreset,
> 		  ata_std_postreset);
> 
> How to then specify if you just need a softreset? My understanding is
> all those functions get called.

The neccessary parts get called from libata-eh based upon the flags set
by the error code to indicate how to recover.

> Ugh.. I figured, I was just hoping I wouldn't have to deal with that.
> Any idea on what happens to the user process (blocking, etc.) during
> error handling? Surely if a disk needs to be hardreset during a normal
> error, the user process doesn't hang for up to 30 seconds?

It stalls.

Alan
