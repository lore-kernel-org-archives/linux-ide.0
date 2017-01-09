From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] Fix interface autodetection in legacy IDE driver
 (trial #2)
Date: Mon, 09 Jan 2017 15:25:43 -0500 (EST)
Message-ID: <20170109.152543.2104649985463993961.davem@davemloft.net>
References: <20161230005232.GA9069@giustizia>
        <CGME20161230160554epcas1p3830e973edb084440f85e5bb24dbf1f1f@epcas1p3.samsung.com>
        <2007222.eymCZIUvPG@amdc3058>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([184.105.139.130]:49874 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752144AbdAIUZo (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 9 Jan 2017 15:25:44 -0500
In-Reply-To: <2007222.eymCZIUvPG@amdc3058>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: b.zolnierkie@samsung.com
Cc: lramos.prof@yahoo.com.br, linux-ide@vger.kernel.org, petkovbb@gmail.com

From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 30 Dec 2016 17:05:51 +0100

> Yes, it was a conscious decision.

I understand things now, I'll revert this change, thanks everyone.
