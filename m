From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 06/13] sata_sil24: implement loss of completion interrupt
 on PCI-X errta fix
Date: Wed, 12 Apr 2006 10:13:00 +0900
Message-ID: <443C541C.3010108@gmail.com>
References: <1144762339715-git-send-email-htejun@gmail.com> <443BE6F9.8020403@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.193]:26036 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751243AbWDLBNO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Apr 2006 21:13:14 -0400
Received: by zproxy.gmail.com with SMTP id o37so1240541nzf
        for <linux-ide@vger.kernel.org>; Tue, 11 Apr 2006 18:13:13 -0700 (PDT)
In-Reply-To: <443BE6F9.8020403@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
>> @@ -738,6 +740,10 @@ static inline void sil24_host_intr(struc
>>      slot_stat = readl(port + PORT_SLOT_STAT);
>>      if (!(slot_stat & HOST_SSTAT_ATTN)) {
>>          struct sil24_port_priv *pp = ap->private_data;
>> +
>> +        if (ap->flags & SIL24_FLAG_PCIX_IRQ_WOC)
>> +            writel(PORT_IRQ_COMPLETE, port + PORT_IRQ_STAT);
>> +
> 
> 
> This looks racy.  Since the interrupt is usually level-triggered, 
> doesn't this introduce the possibility of losing interrupt events?
> 

Above code without the WOC flag test is actually equivalent to...

irq_stat = readl(port + PORT_IRQ_STAT);
if (irq_stat & 0xffff == PORT_IRQ_COMPLETE) {
	writel(PORT_IRQ_COMPLETE, port + PORT_IRQ_STAT);
	/* finish commands */
	return;
}
/* error processing */

So, no race condition that I can think of.  It's just like any other 
interrupt clearing.  Read it, clear it, handle it.  If anything happens 
before the clearing we catch it while handling (in this case, sil24 NCQ 
support will read outstanding command mask after clearing the 
interrupt).  if anything happens after the clearing, we'll be called again.

-- 
tejun
