From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH -next] ata: sata_dwc_460ex: remove redundant dev_err call
Date: Tue, 19 Jul 2016 14:32:49 -0400
Message-ID: <20160719183249.GK3078@mtj.duckdns.org>
References: <1468927673-437-1-git-send-email-weiyj_lk@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f66.google.com ([209.85.220.66]:36805 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753846AbcGSScv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 Jul 2016 14:32:51 -0400
Received: by mail-pa0-f66.google.com with SMTP id ez1so1750252pab.3
        for <linux-ide@vger.kernel.org>; Tue, 19 Jul 2016 11:32:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1468927673-437-1-git-send-email-weiyj_lk@163.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Wei Yongjun <weiyj_lk@163.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Wei Yongjun <yongjun_wei@trendmicro.com.cn>, linux-ide@vger.kernel.org

On Tue, Jul 19, 2016 at 11:27:53AM +0000, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> There is a error message within devm_ioremap_resource
> already, so remove the dev_err call to avoid redundant
> error message.
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Applied to libata/for-4.8.

Thanks.

-- 
tejun
