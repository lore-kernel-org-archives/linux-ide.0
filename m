From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] pdc202xx_old: fix 'pdc20246_dma_ops'
Date: Sun, 7 Jun 2009 13:43:12 +0200
Message-ID: <200906071343.12891.bzolnier@gmail.com>
References: <200906032234.45030.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f213.google.com ([209.85.220.213]:37756 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754001AbZFGNop (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 7 Jun 2009 09:44:45 -0400
Received: by fxm9 with SMTP id 9so1594329fxm.37
        for <linux-ide@vger.kernel.org>; Sun, 07 Jun 2009 06:44:45 -0700 (PDT)
In-Reply-To: <200906032234.45030.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Wednesday 03 June 2009 20:34:44 Sergei Shtylyov wrote:
> Commit ac95beedf8bc97b24f9540d4da9952f07221c023 (ide: add struct ide_port_ops
> (take 2)) erroneously converted the driver's dma_timeout() and dma_lost_irq()
> methods to call the driver's resetproc() method regardless of whether it was
> defined for this specific controller while it hadn't been defined and hence
> called for PDC20246. So the dma_clear() method, the successor of dma_timeout(),
> shouldn't exist and the dma_lost_irq() method should be standard for PDC20246.
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

applied, thanks!
