From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 1/4] ide: don't set hwif->dma_ops in init_dma() method
Date: Fri, 2 Jan 2009 23:32:45 +0100
Message-ID: <200901022332.46065.bzolnier@gmail.com>
References: <200812312152.48007.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f21.google.com ([209.85.218.21]:49617 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756668AbZABWd4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Jan 2009 17:33:56 -0500
Received: by mail-bw0-f21.google.com with SMTP id 14so20505353bwz.13
        for <linux-ide@vger.kernel.org>; Fri, 02 Jan 2009 14:33:55 -0800 (PST)
In-Reply-To: <200812312152.48007.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Wednesday 31 December 2008, Sergei Shtylyov wrote:
> Replace setting of 'hwif->dma_ops' in the 'alim16x3' and 'palm_bk3710' drivers'
> init_dma() methods with initializing the corresponding member of their 'struct
> ide_port_info' instances and remove such setting from the 'hpt366' driver that
> just doesn't use 'sff_dma_ops'. Along with some code save, this prepares us for
> the next patch...
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> 
> ---
> Here are the unfortunate series of patches that hadn't gotten into 2.6.28 --
> I decided not to leave it to the next year despite an extreme overload I had
> during the past several months... :-)

Cool, I applied whole series (it indeed makes code a lot saner/cleaner :).
