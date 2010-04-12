From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH 8/10] pdc202xx_old: implement test_irq() method (take
 2)
Date: Tue, 13 Apr 2010 01:07:53 +0400
Message-ID: <4BC38BA9.3090808@ru.mvista.com>
References: <200702140101.26639.sshtylyov@ru.mvista.com> <200906131738.16931.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f219.google.com ([209.85.218.219]:49141 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752982Ab0DLVNo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Apr 2010 17:13:44 -0400
Received: by bwz19 with SMTP id 19so2349bwz.21
        for <linux-ide@vger.kernel.org>; Mon, 12 Apr 2010 14:13:41 -0700 (PDT)
In-Reply-To: <200906131738.16931.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org

Hello, I wrote:

> Implement test_irq() method based on the driver's former dma_test_irq() method.
>
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
>
> ---
> The patch is atop of ide-2.6.git 'for-next' branch.
> Hopefully it won't break the driver -- previosly the bits have been effectively
> ignored...
>
> Changes sice previos take:
> - decided to document the register bits...
>
>  drivers/ide/pdc202xx_old.c |   22 ++++++++++++++++++++++
>  1 files changed, 22 insertions(+)
>
> Index: ide-2.6/drivers/ide/pdc202xx_old.c
> ===================================================================
> --- ide-2.6.orig/drivers/ide/pdc202xx_old.c
> +++ ide-2.6/drivers/ide/pdc202xx_old.c
>   
[...]
> @@ -231,6 +252,7 @@ static void __devinit pdc202ata4_fixup_i
>  static const struct ide_port_ops pdc20246_port_ops = {
>  	.set_pio_mode		= pdc202xx_set_pio_mode,
>  	.set_dma_mode		= pdc202xx_set_mode,
> +	.test_irq		= pdc202xx_test_irq,
>  };
>  
>  static const struct ide_port_ops pdc2026x_port_ops = {
>   

   Ugh, I forgot to modify this structure, it seems... no wonder Russell 
has emphasized that the bug he's fixed only concerns PDC2024x. :-)

WBR, Sergei

