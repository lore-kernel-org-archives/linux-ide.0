From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] cs5520: don't enable VDMA in ->speedproc
Date: Wed, 18 Jul 2007 23:07:44 +0200
Message-ID: <200707182307.44871.bzolnier@gmail.com>
References: <200707132311.19938.bzolnier@gmail.com> <4699037B.4080403@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:48850 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756361AbXGRVHQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Jul 2007 17:07:16 -0400
Received: by ug-out-1314.google.com with SMTP id j3so325096ugf
        for <linux-ide@vger.kernel.org>; Wed, 18 Jul 2007 14:07:15 -0700 (PDT)
In-Reply-To: <4699037B.4080403@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Saturday 14 July 2007, Sergei Shtylyov wrote:
> Bartlomiej Zolnierkiewicz wrote:
> 
> > There is no need to do it in cs5520_tune_chipset() (->speedproc method)
> > since it is correctly handled by cs5520_dma_on() (->ide_dma_on method).
> 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> 
> Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

added
