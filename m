From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] IDE: Don't powerdown Compaq Triflex IDE device on
 suspend
Date: Thu, 13 Oct 2011 17:05:05 -0400 (EDT)
Message-ID: <20111013.170505.669965343937278692.davem@davemloft.net>
References: <201110111856.05491.bzolnier@gmail.com>
	<20111011.150225.289373201920187790.davem@davemloft.net>
	<201110121631.52099.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([198.137.202.13]:37378 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752796Ab1JMVFO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 13 Oct 2011 17:05:14 -0400
In-Reply-To: <201110121631.52099.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: mikulas@artax.karlin.mff.cuni.cz, jgarzik@pobox.com, linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Date: Wed, 12 Oct 2011 16:31:51 +0200

> From:	Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
> Subject: [PATCH] IDE: Don't powerdown Compaq Triflex IDE device on suspend
> 
> Don't powerdown Compaq Triflex IDE device on suspend
> 
> This fixes APM suspend on Compaq Armada 7400.
> APM BIOS doesn't suspend if IDE is powered down when suspending.
> The Triflex controller is found only on old Compaq boards,
> so this patch will hopefully have no side effects.
> 
> This patch fixes a suspend regression introduced in 
> feb22b7f8e62b1b987a3a1dbad95af767a1df832 ("ide: add proper PCI PM
> support (v2)").
> 
> Signed-off-by: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
> [bart: add commit's summary in parens]
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Applied.
