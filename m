From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] (2.6.20) pata_oldpiix: fix PIO2 underclocking
Date: Tue, 06 Feb 2007 19:54:10 -0500
Message-ID: <45C92332.3090607@garzik.org>
References: <200702051945.38972.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:57058 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030479AbXBGAyM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Feb 2007 19:54:12 -0500
In-Reply-To: <200702051945.38972.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk

Sergei Shtylyov wrote:
> Fix the PIO mode 2 using mode 0 timings -- this driver should enable the
> fast timing bank starting with PIO2, just like the ata_piix driver does.
> Also, fix/rephrase some comments while at it.
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> 
> ---
>  drivers/ata/pata_oldpiix.c |   18 ++++++++++--------
>  1 files changed, 10 insertions(+), 8 deletions(-)

applied


