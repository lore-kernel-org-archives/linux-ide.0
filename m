From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] IDE: Don't powerdown Compaq Triflex IDE device on
 suspend
Date: Tue, 11 Oct 2011 15:02:25 -0400 (EDT)
Message-ID: <20111011.150225.289373201920187790.davem@davemloft.net>
References: <alpine.DEB.2.00.1105152228530.12411@artax.karlin.mff.cuni.cz>
	<201110111856.05491.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([198.137.202.13]:47075 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753424Ab1JKTDJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Oct 2011 15:03:09 -0400
In-Reply-To: <201110111856.05491.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: mikulas@artax.karlin.mff.cuni.cz, jgarzik@pobox.com, linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Date: Tue, 11 Oct 2011 18:56:05 +0200

> Mikulas Patocka wrote:
> 
>> Don't powerdown Compaq Triflex IDE device on suspend
>> 
>> This fixes APM suspend on Compaq Armada 7400.
>> APM BIOS doesn't suspend if IDE is powered down when suspending.
>> The Triflex controller is found only on old Compaq boards,
>> so this patch will hopefully have no side effects.
>> 
>> This patch fixes a suspend regression introduced in 
>> feb22b7f8e62b1b987a3a1dbad95af767a1df832
>> 
>> Signed-off-by: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
> 
> Reviewed-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> 
> This patch is still valid for 3.1.  Dave, ping?

Feedback was given on this patch, and changes were requested.  The patch
was never fixed up and resubmitted by the author:

	http://patchwork.ozlabs.org/patch/95665/
