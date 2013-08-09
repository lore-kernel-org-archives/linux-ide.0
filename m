From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/2] ata: pata_arasan: Staticize local symbols
Date: Fri, 9 Aug 2013 11:11:01 +0530
Message-ID: <CAOh2x=n5j4xsNmjficadJMCJZQTzUWectk=-9UOtJj3y-7tX9A@mail.gmail.com>
References: <000001ce94c2$30c95430$925bfc90$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vc0-f180.google.com ([209.85.220.180]:36685 "EHLO
	mail-vc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934308Ab3HIFlC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Aug 2013 01:41:02 -0400
Received: by mail-vc0-f180.google.com with SMTP id gf11so745587vcb.25
        for <linux-ide@vger.kernel.org>; Thu, 08 Aug 2013 22:41:01 -0700 (PDT)
In-Reply-To: <000001ce94c2$30c95430$925bfc90$@samsung.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org

On Fri, Aug 9, 2013 at 11:05 AM, Jingoo Han <jg1.han@samsung.com> wrote:
> These local symbols are used only in this file.
> Fix the following sparse warnings:
>
> drivers/ata/pata_arasan_cf.c:657:6: warning: symbol 'arasan_cf_error_handler' was not declared. Should it be static?
> drivers/ata/pata_arasan_cf.c:686:14: warning: symbol 'arasan_cf_qc_issue' was not declared. Should it be static?
>
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
>  drivers/ata/pata_arasan_cf.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
