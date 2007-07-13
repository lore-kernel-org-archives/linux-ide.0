From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 5/7] libata: integrate freeze/thaw with irq_on/off
Date: Fri, 13 Jul 2007 15:51:29 +0900
Message-ID: <469720F1.3000907@gmail.com>
References: <468F3949.5050800@tw.ibm.com> <468F3CE2.9080709@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.187]:48406 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934719AbXGMGvf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 13 Jul 2007 02:51:35 -0400
Received: by rv-out-0910.google.com with SMTP id k20so3256rvb
        for <linux-ide@vger.kernel.org>; Thu, 12 Jul 2007 23:51:35 -0700 (PDT)
In-Reply-To: <468F3CE2.9080709@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Doug Maxey <dwm@enoyolf.org>, Mark Lord <mlord@pobox.com>, Linux IDE <linux-ide@vger.kernel.org>

Hello,

> +void ata_irq_on(struct ata_port *ap)
>  {
>  	struct ata_ioports *ioaddr = &ap->ioaddr;
> -	u8 tmp;
>  
>  	ap->ctl &= ~ATA_NIEN;
>  	ap->last_ctl = ap->ctl;
>  
>  	iowrite8(ap->ctl, ioaddr->ctl_addr);
> -	tmp = ata_wait_idle(ap);
> +	ata_wait_idle(ap);
>  
>  	ap->ops->irq_clear(ap);
> -
> -	return tmp;
>  }

Missing ata_chk_status() before clearing ATA_NIEN seems a bit dangerous
to me.

-- 
tejun
