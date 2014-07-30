From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH] ahci: imx: add missing clk_disable_unprepare() on error
 in imx_sata_enable()
Date: Wed, 30 Jul 2014 10:37:41 +0800
Message-ID: <20140730023740.GA10206@dragon>
References: <1406681647-24808-1-git-send-email-weiyj_lk@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bn1lp0140.outbound.protection.outlook.com ([207.46.163.140]:15904
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754864AbaG3Ch7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 29 Jul 2014 22:37:59 -0400
Content-Disposition: inline
In-Reply-To: <1406681647-24808-1-git-send-email-weiyj_lk@163.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: weiyj_lk@163.com
Cc: Tejun Heo <tj@kernel.org>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, Wei Yongjun <yongjun_wei@trendmicro.com.cn>, linux-ide@vger.kernel.org

On Wed, Jul 30, 2014 at 08:54:07AM +0800, weiyj_lk@163.com wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> Add the missing clk_disable_unprepare() before return from
> imx_sata_enable() in the phy reset error handling case.
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Acked-by: Shawn Guo <shawn.guo@freescale.com>
