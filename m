From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 03/19] libata: samsung_cf: fix handling
 platform_get_irq result
Date: Fri, 25 Sep 2015 11:50:56 -0400
Message-ID: <20150925155056.GI4449@mtj.duckdns.org>
References: <20150924145317.GA25415@mtj.duckdns.org>
 <1443163411-25668-1-git-send-email-a.hajda@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yk0-f170.google.com ([209.85.160.170]:35096 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932221AbbIYPvA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 25 Sep 2015 11:51:00 -0400
Content-Disposition: inline
In-Reply-To: <1443163411-25668-1-git-send-email-a.hajda@samsung.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrzej Hajda <a.hajda@samsung.com>
Cc: linux-kernel@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, linux-ide@vger.kernel.org

On Fri, Sep 25, 2015 at 08:43:31AM +0200, Andrzej Hajda wrote:
> The function can return negative value.
> 
> The problem has been detected using proposed semantic patch
> scripts/coccinelle/tests/assign_signed_to_unsigned.cocci [1].
> 
> [1]: http://permalink.gmane.org/gmane.linux.kernel/2046107
> 
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>

Applied to libata/for-4.4.

Thanks.

-- 
tejun
