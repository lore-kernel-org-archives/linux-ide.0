From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 1/6] ata: bf54x: cut drvdata assignment
Date: Tue, 30 May 2017 11:55:45 -0400
Message-ID: <20170530155545.GA15858@htj.duckdns.org>
References: <20170530094644.15566-1-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yb0-f180.google.com ([209.85.213.180]:36456 "EHLO
        mail-yb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750841AbdE3Pzr (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 30 May 2017 11:55:47 -0400
Received: by mail-yb0-f180.google.com with SMTP id 130so21547095ybl.3
        for <linux-ide@vger.kernel.org>; Tue, 30 May 2017 08:55:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170530094644.15566-1-linus.walleij@linaro.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-ide@vger.kernel.org

On Tue, May 30, 2017 at 11:46:39AM +0200, Linus Walleij wrote:
> ata_host_alloc_pinfo() assigns the host pointer to the
> struct device * drvdata, do not assign it a second time.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Applied 1-6 to libata/for-4.13.

Thanks.

-- 
tejun
