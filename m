From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] pdc202xx_old: fix resetproc() method
Date: Sun, 7 Jun 2009 13:43:17 +0200
Message-ID: <200906071343.17511.bzolnier@gmail.com>
References: <200905300007.13113.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f213.google.com ([209.85.218.213]:50757 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754331AbZFGNoy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 7 Jun 2009 09:44:54 -0400
Received: by bwz9 with SMTP id 9so2497535bwz.37
        for <linux-ide@vger.kernel.org>; Sun, 07 Jun 2009 06:44:55 -0700 (PDT)
In-Reply-To: <200905300007.13113.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Friday 29 May 2009 22:07:12 Sergei Shtylyov wrote:
> pdc202xx_reset() calls pdc202xx_reset_host() twice, for both channels, while
> that function actually twiddles the single, shared software reset bit -- the
> net effect is a duplicated reset and horrendous 4 second delay happening not
> only on a channel reset but also when dma_lost_irq() and dma_clear() methods
> are called.  Fold pdc202xx_reset_host() into pdc202xx_reset(), fix printk(),
> and move it before the actual reset...
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

applied
