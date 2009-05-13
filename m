From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: Use IGN_SIMPLEX for ALi
Date: Wed, 13 May 2009 14:49:04 +0100
Message-ID: <20090513144904.1fd2cca9@lxorguk.ukuu.org.uk>
References: <20090513135855.11205.36917.stgit@t61.ukuu.org.uk>
	<200905131532.38811.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:58801 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750790AbZEMNtL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 13 May 2009 09:49:11 -0400
In-Reply-To: <200905131532.38811.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org

> [ Sigh, this issue seems to go back to:
> 
>   commit 669a5db411d85a14f86cd92bc16bf7ab5b8aa235
>   Author: Jeff Garzik <jeff@garzik.org>
>   Date:   Tue Aug 29 18:12:40 2006 -0400
> 
>     [libata] Add a bunch of PATA drivers. ]

No its quite recent actually - broke around 2.6.27

The libata drivers try and reset the simplex bits to check if a device is
merely in simplex mode by configuration. Unfortunately on the ALi if you
put the device into a power saving mode and bring it back the simplex
bits get corrupted and the register becomes unwritable (even to restore)

Somewhere around 2.6.27 something started rudely dumping the device into
power saving mode outside of the ATA layer on certain PCs.

So we switch to ignoring the bit in the first place on this chip.

Alan
