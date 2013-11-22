From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH -next] pata_arasan_cf: add missing
 clk_disable_unprepare() on error path
Date: Fri, 22 Nov 2013 17:27:03 -0500
Message-ID: <20131122222703.GE8981@mtj.dyndns.org>
References: <CAPgLHd_C+KmJXd1oB4=tsGR66BGXgzFds5aicjxDjeKepxFLsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yh0-f41.google.com ([209.85.213.41]:34753 "EHLO
	mail-yh0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755278Ab3KVW1L (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 22 Nov 2013 17:27:11 -0500
Received: by mail-yh0-f41.google.com with SMTP id f11so1282121yha.14
        for <linux-ide@vger.kernel.org>; Fri, 22 Nov 2013 14:27:09 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAPgLHd_C+KmJXd1oB4=tsGR66BGXgzFds5aicjxDjeKepxFLsg@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: viresh.linux@gmail.com, grant.likely@linaro.org, rob.herring@calxeda.com, yongjun_wei@trendmicro.com.cn, linux-ide@vger.kernel.org

On Thu, Nov 21, 2013 at 11:07:09AM +0800, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> Add the missing clk_disable_unprepare() before return
> from cf_init() in the error handling case.
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Applied to libata/for-3.13-fixes.  Thanks.

-- 
tejun
