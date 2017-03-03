From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata: transport: Remove circular dependency at free
 time
Date: Fri, 3 Mar 2017 10:36:48 -0800
Message-ID: <20170303183648.GA20712@wtj.duckdns.org>
References: <CAP8WD_ZJ9EgssJgTu8EOtKodtnfxO8tqhN6iAnuMHq2VQ7MoaQ@mail.gmail.com>
 <20170303170009.36744-1-gwendal@chromium.org>
 <faa6496f-f72e-733a-f7a4-3e2587cd8e61@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33889 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752089AbdCCV0W (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 3 Mar 2017 16:26:22 -0500
Received: by mail-pf0-f194.google.com with SMTP id x66so10842893pfb.1
        for <linux-ide@vger.kernel.org>; Fri, 03 Mar 2017 13:26:21 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <faa6496f-f72e-733a-f7a4-3e2587cd8e61@cogentembedded.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Gwendal Grignou <gwendal@chromium.org>, gregkh@linuxfoundation.org, linux-ide@vger.kernel.org

On Fri, Mar 03, 2017 at 09:28:45PM +0300, Sergei Shtylyov wrote:
> > Reported-by: Matthew Whitehead <tedheadster@gmail.com>
> > Tested-by: Matthew Whitehead <tedheadster@gmail.com>
> > Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> 
>    You're saying it's Tejun's patch but there's no sign-off from him?

It probably should have sth like Patch-originally-by: from me but
Gwendal as the author.  I'll address the review points when applying.

Thanks.

-- 
tejun
