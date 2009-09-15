From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] ide: fixup for fujitsu disk
Date: Tue, 15 Sep 2009 01:37:14 -0700 (PDT)
Message-ID: <20090915.013714.264392602.davem@davemloft.net>
References: <1252661158-8219-1-git-send-email-wuzhangjin@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:37475
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750785AbZIOIg5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 Sep 2009 04:36:57 -0400
In-Reply-To: <1252661158-8219-1-git-send-email-wuzhangjin@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: wuzhangjin@gmail.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, bzolnier@gmail.com, huhb@lemote.com, zhangfx@lemote.com, yanh@lemote.com

From: Wu <wuzhangjin@gmail.com>
Date: Fri, 11 Sep 2009 17:25:58 +0800

> From: Wu Zhangjin <wuzhangjin@gmail.com>
> 
> This patch will fix the following problem on Yeeloong netbook with
> fujitsu disk.
> 
> irq 14: nobody cared (try booting with the "irqpoll" option)
> Call Trace:
 ...
> References:
> 
> 1. commit 1fde02e7146d4a1bab80fd1506f9018fe71e8521 of
> git://dev.lemote.com/linux_loongson.git
> 2. 8bc1e5aa06a2a9a425c4a6795fc564cba1521487 (ide: respect quirk_drives[]
> list on all controllers)
> 
> Signed-off-by: Yan Hua <yanh@lemote.com>
> Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>

Applied, thank you.
