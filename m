From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide: introduce CONFIG_BLK_DEV_IDEDMA_SFF option
Date: Sun, 10 Feb 2008 20:05:32 +0100
Message-ID: <200802102005.32607.bzolnier@gmail.com>
References: <200802092033.59852.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.234]:27143 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754128AbYBJSvk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 10 Feb 2008 13:51:40 -0500
Received: by wx-out-0506.google.com with SMTP id h31so4523507wxd.4
        for <linux-ide@vger.kernel.org>; Sun, 10 Feb 2008 10:51:39 -0800 (PST)
In-Reply-To: <200802092033.59852.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: asalnikov@ru.mvista.com, linux-ide@vger.kernel.org

On Saturday 09 February 2008, Sergei Shtylyov wrote:
> Introduce new option CONFIG_BLK_DEV_IDEDMA_SFF for non-PCI SFF-8038i compatible
> bus mastering IDE controllers (which there are a few known), thus fixing a hack
> made for Palmchip BK3710 controller...
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

thanks, applied

> ---
> Bart, did you mean something like that?
> Anton, make sure it works, just in case... :-)

I later noticed that there is still pci_alloc_consistent() call
which needs to be converted to dma_alloc_coherent() in ide-dma.c... :/
