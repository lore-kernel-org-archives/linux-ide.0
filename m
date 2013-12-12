From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH -next] ahci: imx: fix the error handling in
 imx_ahci_probe()
Date: Thu, 12 Dec 2013 10:59:47 -0500
Message-ID: <20131212155947.GH32683@htj.dyndns.org>
References: <CAPgLHd-okGke6OMBe2yaX3NdoDFtcN-47bFfcSRL-8h_7nnmYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yh0-f43.google.com ([209.85.213.43]:35367 "EHLO
	mail-yh0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751094Ab3LLP77 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 12 Dec 2013 10:59:59 -0500
Received: by mail-yh0-f43.google.com with SMTP id a41so445108yho.16
        for <linux-ide@vger.kernel.org>; Thu, 12 Dec 2013 07:59:59 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAPgLHd-okGke6OMBe2yaX3NdoDFtcN-47bFfcSRL-8h_7nnmYw@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: grant.likely@linaro.org, rob.herring@calxeda.com, marex@denx.de, yongjun_wei@trendmicro.com.cn, linux-ide@vger.kernel.org

On Sat, Dec 07, 2013 at 02:00:19PM +0800, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> Release alloced resources instead of direct return from
> imx_ahci_probe() in the error handling case.
> 
> Fixes: 4a23d1793f8e ('ahci: imx: Add i.MX53 support')
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Applied to libata/for-3.14.

Thanks.

-- 
tejun
