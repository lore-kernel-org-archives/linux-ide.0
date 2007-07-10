From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] scc_pata.c: Workaround for errata A308
Date: Tue, 10 Jul 2007 23:58:57 +0200
Message-ID: <200707102358.57359.bzolnier@gmail.com>
References: <200707100929.l6A9T95v017616@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:21068 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761093AbXGJWEr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 10 Jul 2007 18:04:47 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1434490ugf
        for <linux-ide@vger.kernel.org>; Tue, 10 Jul 2007 15:04:46 -0700 (PDT)
In-Reply-To: <200707100929.l6A9T95v017616@toshiba.co.jp>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
Cc: kou.ishizaki@toshiba.co.jp, linux-ide@vger.kernel.org

On Tuesday 10 July 2007, Akira Iguchi wrote:
> Workaround for errata A308: turn down the UDMA mode and retry
> the DMA command when the data lost condition is detected.
> 
> Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
> Signed-off-by: Akira Iguchi <akira2.iguchi@toshiba.co.jp>

applied, thanks
