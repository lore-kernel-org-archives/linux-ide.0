From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 29/32] ide-tape: remove mtio.h related comments
Date: Sun, 27 Jan 2008 19:24:02 +0100
Message-ID: <200801271924.02978.bzolnier@gmail.com>
References: <1201427300-3954-1-git-send-email-petkovbb@gmail.com> <1201427300-3954-24-git-send-email-petkovbb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:9355 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754930AbYA0TcU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 27 Jan 2008 14:32:20 -0500
Received: by fg-out-1718.google.com with SMTP id e21so1431369fga.17
        for <linux-ide@vger.kernel.org>; Sun, 27 Jan 2008 11:32:19 -0800 (PST)
In-Reply-To: <1201427300-3954-24-git-send-email-petkovbb@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <petkovbb@googlemail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <bbpetkov@yahoo.de>

On Sunday 27 January 2008, Borislav Petkov wrote:
> From: Borislav Petkov <bbpetkov@yahoo.de>
> 
> Those are already in mtio.h.
> 
> Signed-off-by: Borislav Petkov <bbpetkov@yahoo.de>

applied

> ---
>  drivers/ide/ide-tape.c |   96 +++++++----------------------------------------
>  1 files changed, 15 insertions(+), 81 deletions(-)

[...]

> -static int idetape_chrdev_ioctl (struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg)
> +static int idetape_chrdev_ioctl(struct inode *inode, struct file *file,
> +		uint cmd, ulong arg)

I undid this change

lets stick to 'unsigned int' and 'unsigned long' like 99% of the kernel code
