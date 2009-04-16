From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] pata_hpt37x: fix HPT370 DMA timeouts
Date: Thu, 16 Apr 2009 15:22:54 -0400
Message-ID: <49E7858E.8090105@pobox.com>
References: <200904141839.14755.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:37866 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757402AbZDPTXA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 16 Apr 2009 15:23:00 -0400
In-Reply-To: <200904141839.14755.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, stable@kernel.org, alan@lxorguk.ukuu.org.uk

Sergei Shtylyov wrote:
> The libata driver has copied the code from the IDE driver which caused a post
> 2.4.18 regression on many HPT370[A] chips -- DMA stopped to work completely,
> only causing timeouts.  Now remove hpt370_bmdma_start() for good...
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> 
> ---
> The patch is against the recent Linus' tree. It's intended to go into all
> stable kernels starting with 2.6.19, when the PATA drivers were first merged.
> 
> See http://marc.info/?l=linux-ide&m=123912061904872 for the IDE driver patch.
> 
>  drivers/ata/pata_hpt37x.c |   22 ++--------------------
>  1 files changed, 2 insertions(+), 20 deletions(-)

applied


