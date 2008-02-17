From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 1/4] : More use DIV_ROUND_UP
Date: Sun, 17 Feb 2008 18:17:47 +0100
Message-ID: <200802171817.48155.bzolnier@gmail.com>
References: <Pine.LNX.4.58.0802161548370.1185@pc-041.diku.dk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.188]:47523 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753474AbYBQRKg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 17 Feb 2008 12:10:36 -0500
Received: by mu-out-0910.google.com with SMTP id i10so1225230mue.5
        for <linux-ide@vger.kernel.org>; Sun, 17 Feb 2008 09:10:35 -0800 (PST)
In-Reply-To: <Pine.LNX.4.58.0802161548370.1185@pc-041.diku.dk>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Julia Lawall <julia@diku.dk>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

On Saturday 16 February 2008, Julia Lawall wrote:
> From: Julia Lawall <julia@diku.dk>
> 
> The kernel.h macro DIV_ROUND_UP performs the computation (((n) + (d) - 1) /
> (d)) but is perhaps more readable.
> 
> An extract of the semantic patch that makes this change is as follows:
> (http://www.emn.fr/x-info/coccinelle/)
> 
> // <smpl>
> @haskernel@
> @@
> 
> #include <linux/kernel.h>
> 
> @depends on haskernel@
> expression n,d;
> @@
> 
> (
> - (n + d - 1) / d
> + DIV_ROUND_UP(n,d)
> |
> - (n + (d - 1)) / d
> + DIV_ROUND_UP(n,d)
> )
> 
> @depends on haskernel@
> expression n,d;
> @@
> 
> - DIV_ROUND_UP((n),d)
> + DIV_ROUND_UP(n,d)
> 
> @depends on haskernel@
> expression n,d;
> @@
> 
> - DIV_ROUND_UP(n,(d))
> + DIV_ROUND_UP(n,d)
> // </smpl>
> 
> Signed-off-by: Julia Lawall <julia@diku.dk>

applied, thanks
