From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2/2] ide-cd: add a debug_mask module parameter
Date: Sun, 7 Sep 2008 20:21:24 +0200
Message-ID: <200809072021.25277.bzolnier@gmail.com>
References: <1219496923-20868-1-git-send-email-petkovbb@gmail.com> <1219496923-20868-2-git-send-email-petkovbb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.187]:5477 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755098AbYIGS13 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 7 Sep 2008 14:27:29 -0400
Received: by mu-out-0910.google.com with SMTP id g7so1053152muf.1
        for <linux-ide@vger.kernel.org>; Sun, 07 Sep 2008 11:27:28 -0700 (PDT)
In-Reply-To: <1219496923-20868-2-git-send-email-petkovbb@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <petkovbb@googlemail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

On Saturday 23 August 2008, Borislav Petkov wrote:
> Signed-off-by: Borislav Petkov <petkovbb@gmail.com>

applied

> ---
>  drivers/ide/ide-cd.c |    8 +++++++-
>  1 files changed, 7 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
> index cca1011..5e0b9cd 100644
> --- a/drivers/ide/ide-cd.c
> +++ b/drivers/ide/ide-cd.c
> @@ -53,6 +53,8 @@
>  
>  #include "ide-cd.h"
>  
> +static unsigned long debug_mask = 0x0;

No need to zero it, I fixed it and moved debug_mask next to module_param().
