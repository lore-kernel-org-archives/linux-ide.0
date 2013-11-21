From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH -next] pata_arasan_cf: add missing clk_disable_unprepare()
 on error path
Date: Thu, 21 Nov 2013 09:23:14 +0530
Message-ID: <CAOh2x=mp+SfwQ9szndOX_t9OV3e+5JrvC2Ch6trb80GeTBWYzw@mail.gmail.com>
References: <CAPgLHd_C+KmJXd1oB4=tsGR66BGXgzFds5aicjxDjeKepxFLsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vb0-f45.google.com ([209.85.212.45]:48376 "EHLO
	mail-vb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751599Ab3KUDxP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 20 Nov 2013 22:53:15 -0500
Received: by mail-vb0-f45.google.com with SMTP id p14so955374vbm.32
        for <linux-ide@vger.kernel.org>; Wed, 20 Nov 2013 19:53:14 -0800 (PST)
In-Reply-To: <CAPgLHd_C+KmJXd1oB4=tsGR66BGXgzFds5aicjxDjeKepxFLsg@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: ejun Heo <tj@kernel.org>, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, yongjun_wei@trendmicro.com.cn, "...)" <linux-ide@vger.kernel.org>

On Thu, Nov 21, 2013 at 8:37 AM, Wei Yongjun <weiyj.lk@gmail.com> wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>
> Add the missing clk_disable_unprepare() before return
> from cf_init() in the error handling case.
>
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> ---
>  drivers/ata/pata_arasan_cf.c | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
