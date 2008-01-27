From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 06/32] ide-tape: remove IDETAPE_DEBUG_BUGS
Date: Sun, 27 Jan 2008 16:35:17 +0100
Message-ID: <200801271635.17850.bzolnier@gmail.com>
References: <1201427300-3954-1-git-send-email-petkovbb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:9237 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753582AbYA0TcP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 27 Jan 2008 14:32:15 -0500
Received: by fg-out-1718.google.com with SMTP id e21so1431358fga.17
        for <linux-ide@vger.kernel.org>; Sun, 27 Jan 2008 11:32:14 -0800 (PST)
In-Reply-To: <1201427300-3954-1-git-send-email-petkovbb@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <petkovbb@googlemail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <bbpetkov@yahoo.de>

On Sunday 27 January 2008, Borislav Petkov wrote:
> From: Borislav Petkov <bbpetkov@yahoo.de>
> 
> Signed-off-by: Borislav Petkov <bbpetkov@yahoo.de>

applied

> ---
>  drivers/ide/ide-tape.c |   42 ++----------------------------------------
>  1 files changed, 2 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
> index dbececc..efb9d25 100644
> --- a/drivers/ide/ide-tape.c
> +++ b/drivers/ide/ide-tape.c
> @@ -107,7 +107,6 @@ typedef struct os_dat_s {
>   *	The following are used to debug the driver:
>   *
>   *	Setting IDETAPE_DEBUG_LOG to 1 will log driver flow control.
> - *	Setting IDETAPE_DEBUG_BUGS to 1 will enable self-sanity checks in
>   *	some places.

the above line should also go away (I removed it while merging the patch)
