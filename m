From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide: fix serverworks.c UDMA regression
Date: Tue, 16 Oct 2007 21:25:41 +0200
Message-ID: <200710162125.41987.bzolnier@gmail.com>
References: <4713B9FA.8050803@cybernetics.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:40084 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936033AbXJPUtm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 16 Oct 2007 16:49:42 -0400
Received: by ug-out-1314.google.com with SMTP id z38so159272ugc
        for <linux-ide@vger.kernel.org>; Tue, 16 Oct 2007 13:49:40 -0700 (PDT)
In-Reply-To: <4713B9FA.8050803@cybernetics.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tony Battersby <tonyb@cybernetics.com>
Cc: linux-ide@vger.kernel.org, stable@kernel.org

On Monday 15 October 2007, Tony Battersby wrote:
> The patch described by the following excerpt from ChangeLog-2.6.22 makes
> it impossible to use UDMA on a Tyan S2707 motherboard (SvrWks CSB5):
> 
> commit 2d5eaa6dd744a641e75503232a01f52d0768884c
> Author: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Date:   Thu May 10 00:01:08 2007 +0200
> 
>     ide: rework the code for selecting the best DMA transfer mode (v3)
> 
>     ...
> 
> This one-line patch against 2.6.23 fixes the problem.

Thanks!! (and sorry for the bug)

> Signed-off-by: Tony Battersby <tonyb@cybernetics.com>

applied

Greg/Chris: this is a perfect candidate for 2.6.23.2

> ---
> --- linux-2.6.23/drivers/ide/pci/serverworks.c.orig	2007-10-15 12:15:01.000000000 -0400
> +++ linux-2.6.23/drivers/ide/pci/serverworks.c	2007-10-15 13:47:29.000000000 -0400
> @@ -97,6 +97,7 @@ static u8 svwks_udma_filter(ide_drive_t 
>  			mode = 2;
>  
>  		switch(mode) {
> +		case 3:	 mask = 0x3f; break;
>  		case 2:	 mask = 0x1f; break;
>  		case 1:	 mask = 0x07; break;
>  		default: mask = 0x00; break;
