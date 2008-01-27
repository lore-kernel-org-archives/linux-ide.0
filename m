From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 21/32] ide-tape: idetape_chrdev_direction_t:shorten enum names
Date: Sun, 27 Jan 2008 19:38:18 +0100
Message-ID: <200801271938.18520.bzolnier@gmail.com>
References: <1201427300-3954-1-git-send-email-petkovbb@gmail.com> <1201427300-3954-16-git-send-email-petkovbb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:9355 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755384AbYA0TcW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 27 Jan 2008 14:32:22 -0500
Received: by fg-out-1718.google.com with SMTP id e21so1431369fga.17
        for <linux-ide@vger.kernel.org>; Sun, 27 Jan 2008 11:32:21 -0800 (PST)
In-Reply-To: <1201427300-3954-16-git-send-email-petkovbb@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <petkovbb@googlemail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <bbpetkov@yahoo.de>

On Sunday 27 January 2008, Borislav Petkov wrote:
> From: Borislav Petkov <bbpetkov@yahoo.de>
> 
> Signed-off-by: Borislav Petkov <bbpetkov@yahoo.de>
> ---
>  drivers/ide/ide-tape.c |   60 ++++++++++++++++++++++++-----------------------
>  1 files changed, 31 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
> index cf308d7..b487d56 100644
> --- a/drivers/ide/ide-tape.c
> +++ b/drivers/ide/ide-tape.c
> @@ -178,11 +178,13 @@ enum {
>  /*
>   *	For general magnetic tape device compatibility.
>   */
> +
> +/* tape directions */
>  typedef enum {
> -	idetape_direction_none,
> -	idetape_direction_read,
> -	idetape_direction_write
> -} idetape_chrdev_direction_t;
> +	idetape_dir_none,
> +	idetape_dir_read,
> +	idetape_dir_write

Could you convert them to upper-case while at it?

> +} idetape_chrdev_dir_t;
