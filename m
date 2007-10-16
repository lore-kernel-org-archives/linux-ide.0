From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] Update libata driver for bf548 atapi controller against the 2.6.24 tree.
Date: Wed, 17 Oct 2007 00:24:21 +0200
Message-ID: <200710170024.22103.bzolnier@gmail.com>
References: <1192524207.11166.1.camel@sevens.analog.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:37081 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966424AbXJPWTW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 16 Oct 2007 18:19:22 -0400
Received: by ug-out-1314.google.com with SMTP id z38so174513ugc
        for <linux-ide@vger.kernel.org>; Tue, 16 Oct 2007 15:19:21 -0700 (PDT)
In-Reply-To: <1192524207.11166.1.camel@sevens.analog.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sonic Zhang <sonic.adi@gmail.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Linux IDE <linux-ide@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>

On Tuesday 16 October 2007, Sonic Zhang wrote:
> Changes:
> 1. Remove irq_ack() and port_disable() methods
> 2. Acocomodate for the libata-link patches
> 3. Change Kconfig ATAPI mode option into a module param.
> 4. Add supported WMDMA mode.
> 
> Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>

thanks, looks good

Acked-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
