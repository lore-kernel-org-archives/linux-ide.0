From: David Miller <davem@davemloft.net>
Subject: Re: [patch 1/6] ide: add QUANTUM FIREBALLct20 30 with firmware
 APL.090 to ivb_list[]
Date: Tue, 23 Jun 2009 16:11:47 -0700 (PDT)
Message-ID: <20090623.161147.239832722.davem@davemloft.net>
References: <200906232324.37615.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:42460
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752277AbZFWXLm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 23 Jun 2009 19:11:42 -0400
In-Reply-To: <200906232324.37615.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Date: Tue, 23 Jun 2009 23:24:37 +0200

> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Subject: [PATCH] ide: add QUANTUM FIREBALLct20 30 with firmware APL.090 to ivb_list[]
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> ---
> This disk supports UDMA modes > 2.  According to the old bugreport it needs
> forced cable detection when using 80-wire cable and id dump suggested that
> ivb quirk should be used to fix the problem.  Unfortunately I never received
> any feedback about the patch from the bugreporter.

This one seems pretty safe, applied, thanks!

We'll be on the lookout for bug reports that mention this drive
and revert as needed.
