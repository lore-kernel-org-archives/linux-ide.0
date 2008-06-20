From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [git patches] IDE fixes
Date: Fri, 20 Jun 2008 19:09:48 +0100
Message-ID: <20080620190948.537f7f7a@lxorguk.ukuu.org.uk>
References: <200806202007.38081.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:57946 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751398AbYFTS2N (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 20 Jun 2008 14:28:13 -0400
In-Reply-To: <200806202007.38081.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


> +	PCMCIA_DEVICE_PROD_ID12("TRANSCEND", "TS1GCF45", 0x709b1bf1, 0xf68b632),

That one seems to be a digit short - is it 0x0f68b632 or a typo ?


Alan
