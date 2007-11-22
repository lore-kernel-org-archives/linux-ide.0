From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] pata_jmicron: fix disabled port handling in	jmicron_pre_reset()
Date: Thu, 22 Nov 2007 14:06:29 +0900
Message-ID: <47450E55.6020305@gmail.com>
References: <20071119090611.GE30919@htj.mynetwork.cxm>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.187]:48830 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750769AbXKVFGg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 Nov 2007 00:06:36 -0500
Received: by rv-out-0910.google.com with SMTP id k20so2278195rvb
        for <linux-ide@vger.kernel.org>; Wed, 21 Nov 2007 21:06:35 -0800 (PST)
In-Reply-To: <20071119090611.GE30919@htj.mynetwork.cxm>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

Tejun Heo wrote:
> There are two bugs in disabled port handling.
> 
> * test in PORT_PATA0 is reversed
> * ->prereset should return -ENOENT for disabled ports not 0
> 
> The first bug makes the PATA channel considered disabled but the
> second bug saves the day by returning 0.  The net result is that cable
> is always left at ATA_CBL_UNKNOWN.  This results in false 80c
> configuration and thus transfer errors.
> 
> This patch fixes both bugs.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

Jeff, this wasn't pushed to Linus.  Can you please put this into
#upstream-fixes?

Thanks.

-- 
tejun
