From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] Au1200: IDE driver build fix
Date: Tue, 15 Apr 2008 22:55:15 +0200
Message-ID: <200804152255.15926.bzolnier@gmail.com>
References: <200804142303.04661.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:30875 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765603AbYDOVTy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 Apr 2008 17:19:54 -0400
Received: by fg-out-1718.google.com with SMTP id l27so2140210fgb.17
        for <linux-ide@vger.kernel.org>; Tue, 15 Apr 2008 14:19:53 -0700 (PDT)
In-Reply-To: <200804142303.04661.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, linux-mips@linux-mips.org

On Monday 14 April 2008, Sergei Shtylyov wrote:
> The driver fails to compile with CONFIG_BLK_DEV_IDE_AU1XXX_MDMA2_DBDMA enabled:
> 
> drivers/ide/mips/au1xxx-ide.c: In function `auide_build_dmatable':
> drivers/ide/mips/au1xxx-ide.c:256: error: implicit declaration of function
> `sg_virt'
> drivers/ide/mips/au1xxx-ide.c:275: error: implicit declaration of function
> `sg_next'
> drivers/ide/mips/au1xxx-ide.c:275: warning: assignment makes pointer from
> integer without a cast
> 
> Fix this by including <linux/scatterlist.h>. While at it, remove the #include's
> without which the driver happily builds.
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

applied
