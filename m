From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 08/32] ide-tape: remove struct idetape_capabilities_page_t
Date: Sun, 27 Jan 2008 17:46:34 +0100
Message-ID: <200801271746.34587.bzolnier@gmail.com>
References: <1201427300-3954-1-git-send-email-petkovbb@gmail.com> <1201427300-3954-3-git-send-email-petkovbb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:9237 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754081AbYA0TcS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 27 Jan 2008 14:32:18 -0500
Received: by fg-out-1718.google.com with SMTP id e21so1431358fga.17
        for <linux-ide@vger.kernel.org>; Sun, 27 Jan 2008 11:32:18 -0800 (PST)
In-Reply-To: <1201427300-3954-3-git-send-email-petkovbb@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <petkovbb@googlemail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <bbpetkov@yahoo.de>

On Sunday 27 January 2008, Borislav Petkov wrote:
> From: Borislav Petkov <bbpetkov@yahoo.de>
> 
> All those 2-byte values denoting the different capabilities are being written to
> the local copy of the caps buffer without being converted to big endian for
> simplicity of usage and shorter code later.  Also, we add some comments stating
> which are the fields of the caps page in question in order to alleviate the
> cryptic pointer casting exercises as in e.g. idetape_get_mode_sense_results().
> 
> There should be no functional changes resulting from this patch.
> 
> Signed-off-by: Borislav Petkov <bbpetkov@yahoo.de>

applied

> ---
>  drivers/ide/ide-tape.c |  143 +++++++++++++++++++-----------------------------
>  1 files changed, 57 insertions(+), 86 deletions(-)

[...]

> -	tape->capabilities = *capabilities;		/* Save us a copy */
> -	if (capabilities->blk512)
> +	memcpy(&tape->caps, caps, 20);
> +	if (!!(caps[7] & 0x02))
>  		tape->tape_block_size = 512;
> -	else if (capabilities->blk1024)
> +	else if (!!(caps[7] & 0x04))
>  		tape->tape_block_size = 1024;
> +

I removed needless "!!" and extra newline while merging the patch.
