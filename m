From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] scc_pata.c: Workaround for errata A308 (take 2)
Date: Wed, 18 Jul 2007 22:47:02 +0200
Message-ID: <200707182247.02664.bzolnier@gmail.com>
References: <200707170307.l6H37e8u003922@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:47679 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755610AbXGRVHM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Jul 2007 17:07:12 -0400
Received: by ug-out-1314.google.com with SMTP id j3so325102ugf
        for <linux-ide@vger.kernel.org>; Wed, 18 Jul 2007 14:07:11 -0700 (PDT)
In-Reply-To: <200707170307.l6H37e8u003922@toshiba.co.jp>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
Cc: sshtylyov@ru.mvista.com, kou.ishizaki@toshiba.co.jp, linux-ide@vger.kernel.org

On Tuesday 17 July 2007, Akira Iguchi wrote:
> Workaround for errata A308: turn down the UDMA mode and retry
> the DMA command when the data lost condition is detected.
> 
> take2:
> udma_filter() hook is used to limit ATAPI UDMA mode.
> 
> Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
> Signed-off-by: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
> ---

The previous patch has already been merged so please rediff this one
to contain only the new changes.

Thanks,
Bart
