From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] Drivers: ide: Remove typedef atiixp_ide_timing
Date: Wed, 15 Oct 2014 14:27:58 -0400 (EDT)
Message-ID: <20141015.142758.1663495852272800188.davem@davemloft.net>
References: <20140814164430.GA4237@himangi-Dell>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:53222 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751033AbaJOS3f (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Oct 2014 14:29:35 -0400
In-Reply-To: <20140814164430.GA4237@himangi-Dell>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: himangi774@gmail.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, julia.lawall@lip6.fr

From: Himangi Saraogi <himangi774@gmail.com>
Date: Thu, 14 Aug 2014 22:14:30 +0530

> The Linux kernel coding style guidelines suggest not using typedefs
> for structure types. This patch gets rid of the typedef for
> atiixp_ide_timing.
> 
> The following Coccinelle semantic patch detects the case:
  ...
> Signed-off-by: Himangi Saraogi <himangi774@gmail.com>
> Acked-by: Julia Lawall <julia.lawall@lip6.fr>

Applied, thanks.
