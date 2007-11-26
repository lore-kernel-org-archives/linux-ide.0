From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] [libata] Return proper ATA INT status in pata_bf54x driver.
Date: Mon, 26 Nov 2007 11:04:38 -0500
Message-ID: <474AEE96.9070708@garzik.org>
References: <1196070656.15520.4.camel@eight.analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:44466 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752106AbXKZQEk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 26 Nov 2007 11:04:40 -0500
In-Reply-To: <1196070656.15520.4.camel@eight.analog.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: sonic zhang <sonic.adi@gmail.com>
Cc: Linux IDE <linux-ide@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>

sonic zhang wrote:
> INT status can be OR.
> 
> 
> Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>
> 
> ---
>  drivers/ata/pata_bf54x.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)

applied


