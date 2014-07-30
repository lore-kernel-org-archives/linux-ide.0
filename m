From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ahci: imx: add missing clk_disable_unprepare() on error
 in imx_sata_enable()
Date: Wed, 30 Jul 2014 12:06:30 -0400
Message-ID: <20140730160630.GC23734@htj.dyndns.org>
References: <1406681647-24808-1-git-send-email-weiyj_lk@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qg0-f47.google.com ([209.85.192.47]:36842 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754109AbaG3QGe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 30 Jul 2014 12:06:34 -0400
Received: by mail-qg0-f47.google.com with SMTP id i50so1817341qgf.6
        for <linux-ide@vger.kernel.org>; Wed, 30 Jul 2014 09:06:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1406681647-24808-1-git-send-email-weiyj_lk@163.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: weiyj_lk@163.com
Cc: Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawn.guo@freescale.com>, Wei Yongjun <yongjun_wei@trendmicro.com.cn>, linux-ide@vger.kernel.org

On Wed, Jul 30, 2014 at 08:54:07AM +0800, weiyj_lk@163.com wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> Add the missing clk_disable_unprepare() before return from
> imx_sata_enable() in the phy reset error handling case.
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Applied to libata/for-3.17.

Thanks.

-- 
tejun
