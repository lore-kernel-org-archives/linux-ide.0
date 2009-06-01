From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 3/3] icside: remove superfluous ->maskproc method
Date: Tue, 02 Jun 2009 02:48:49 +0400
Message-ID: <4A245AD1.10108@ru.mvista.com>
References: <200906012353.41504.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:62239 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751211AbZFAWtC (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 1 Jun 2009 18:49:02 -0400
In-Reply-To: <200906012353.41504.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

> [inspired by pata_icside]
>   

   I'm not sure you've got it right... These comments about "routing" 
are confusing...

> Enabling/disabling of card IRQs is handled fine by IRQ and IDE
> subsystems so there is no need for custom ->maskproc method.
>
> Moreover icside_maskproc() would enable IRQ only if it was already
> enabled [because of 'if (state->enabled && !mask)' check].
>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> ---
>  drivers/ide/icside.c |   64 +++------------------------------------------------
>  1 file changed, 4 insertions(+), 60 deletions(-)
>
> Index: b/drivers/ide/icside.c
> ===================================================================
> --- a/drivers/ide/icside.c
> +++ b/drivers/ide/icside.c
> @@ -65,8 +65,6 @@ static struct cardinfo icside_cardinfo_v
>  };
>  
>  struct icside_state {
> -	unsigned int channel;
> -	unsigned int enabled;
>  	void __iomem *irq_port;
>  	void __iomem *ioc_base;
>  	unsigned int sel;
> @@ -116,18 +114,11 @@ static void icside_irqenable_arcin_v6 (s
>  	struct icside_state *state = ec->irq_data;
>  	void __iomem *base = state->irq_port;
>  
> -	state->enabled = 1;
> +	writeb(0, base + ICS_ARCIN_V6_INTROFFSET_1);
> +	readb(base + ICS_ARCIN_V6_INTROFFSET_2);
>   
>  
> -	switch (state->channel) {
> -	case 0:
> -		writeb(0, base + ICS_ARCIN_V6_INTROFFSET_1);
> -		readb(base + ICS_ARCIN_V6_INTROFFSET_2);
> -		break;
> -	case 1:
> -		writeb(0, base + ICS_ARCIN_V6_INTROFFSET_2);
> -		readb(base + ICS_ARCIN_V6_INTROFFSET_1);
> -		break;
> -	}
> +	writeb(0, base + ICS_ARCIN_V6_INTROFFSET_2);
> +	readb(base + ICS_ARCIN_V6_INTROFFSET_1);
>   

   Aren't this read supposed to disable channel 1 interrupt again?

MBR, Sergei


