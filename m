From: "Bryan Wu" <cooloney@kernel.org>
Subject: Re: [PATCH 2/3] [libata/BF54x]: Fix bug - Implement bfin ata interrupt handler to avoid "irq 68 nobody cared"
Date: Fri, 25 Apr 2008 14:27:17 +0800
Message-ID: <386072610804242327g18b28ef4wa8893c0756764103@mail.gmail.com>
References: <1209094676-20360-1-git-send-email-cooloney@kernel.org>
	 <1209094676-20360-3-git-send-email-cooloney@kernel.org>
	 <48116965.7030705@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.29]:58284 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755862AbYDYG1S (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 25 Apr 2008 02:27:18 -0400
Received: by yw-out-2324.google.com with SMTP id 5so468644ywh.1
        for <linux-ide@vger.kernel.org>; Thu, 24 Apr 2008 23:27:18 -0700 (PDT)
In-Reply-To: <48116965.7030705@pobox.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Sonic Zhang <sonic.zhang@analog.com>

On Fri, Apr 25, 2008 at 1:17 PM, Jeff Garzik <jgarzik@pobox.com> wrote:
> Bryan Wu wrote:
>
> > From: Sonic Zhang <sonic.zhang@analog.com>
> >
> > Return IRQ_HANDLED when bfin ata device is busy.
> >
> http://blackfin.uclinux.org/gf/project/uclinux-dist/tracker/?action=TrackerItemEdit&tracker_item_id=3513
> >
> > Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>
> > Signed-off-by: Bryan Wu <cooloney@kernel.org>
> > ---
> >  drivers/ata/pata_bf54x.c |  125
> ++++++++++++++++++++++++++++++++++++++++++++--
> >  1 files changed, 121 insertions(+), 4 deletions(-)
> >
>
>  AFAICS the two new functions you add should be (a) marked 'static' and (b)
> not marked 'inline'.
>
>  We avoid inline these days, preferring to let the compiler make the best
> choice for that platform/CPU.
>

No problem, I will fix it.

-Bryan
