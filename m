From: Michael Schmitz <schmitz@biophys.uni-duesseldorf.de>
Subject: Re: [PATCH 2/3] ide: add ide_[un]lock_hwgroup() helpers
Date: Wed, 19 Nov 2008 03:33:52 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0811190236550.24738@zirkon.biophys.uni-duesseldorf.de>
References: <200811182116.00351.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout-venus.uni-duesseldorf.de ([134.99.128.32]:46764 "EHLO
	mail.rz.uni-duesseldorf.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751479AbYKSCdz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 18 Nov 2008 21:33:55 -0500
In-reply-to: <200811182116.00351.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, Elias Oltmanns <eo@nebensachen.de>

> -	while (!hwgroup->busy) {
> -		hwgroup->busy = 1;
> -		/* for atari only */
> -		ide_get_lock(ide_intr, hwgroup);
> +	while (!ide_lock_hwgroup(hwgroup)) {

Something I've run into while working on the locking stuff: what happens if the 
above ide_lock_hwgroup(hwgroup) sleeps for long enough to trigger the request 
timer? 

I'll think about the ramifications of your patch in the context of what I tested 
WRT unlocking whenever hwgroup->busy is cleared, and get back to you. 

	Michael
