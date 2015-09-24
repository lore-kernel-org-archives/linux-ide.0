From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 03/19] libata: samsung_cf: fix handling platform_get_irq
 result
Date: Thu, 24 Sep 2015 10:53:17 -0400
Message-ID: <20150924145317.GA25415@mtj.duckdns.org>
References: <1443103227-25612-1-git-send-email-a.hajda@samsung.com>
 <1443103227-25612-4-git-send-email-a.hajda@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1443103227-25612-4-git-send-email-a.hajda@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrzej Hajda <a.hajda@samsung.com>
Cc: linux-kernel@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Thu, Sep 24, 2015 at 04:00:11PM +0200, Andrzej Hajda wrote:
> The function can return negative value.
> 
> The problem has been detected using proposed semantic patch
> scripts/coccinelle/tests/assign_signed_to_unsigned.cocci [1].
> 
> [1]: http://permalink.gmane.org/gmane.linux.kernel/2046107
> 
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> ---
> Hi,
> 
> To avoid problems with too many mail recipients I have sent whole
> patchset only to LKML. Anyway patches have no dependencies.

Can we just change s3c_ide_info->irq to int instead?

Thanks.

-- 
tejun
