From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: fixed a bug of adma in rhel4u5 with HDS7250SASUN500G.
Date: Fri, 11 Jan 2008 08:29:26 -0600
Message-ID: <47877D46.9030700@shaw.ca>
References: <4781F008.9070404@gmail.com> <4782422C.8020202@rtr.ca>
 <4782B73B.8080309@shaw.ca> <4782BC48.4000309@gmail.com>
 <4782C008.3030902@shaw.ca> <4782CB62.7040901@gmail.com>
 <4782CEF9.3040708@gmail.com> <4782DFFE.50301@shaw.ca>
 <4782E5A8.9010305@gmail.com> <4782E63E.1000606@gmail.com>
 <4782E78F.9050205@shaw.ca> <4782E912.1050204@gmail.com>
 <4783493A.7070800@gmail.com> <47838B57.8020407@shaw.ca>
 <47842A54.2060107@gmail.com> <47842ABA.2060605@gmail.com>
 <47844471.4070705@shaw.ca> <47845708.6060900@gmail.com>
 <478567D8.10601@shaw.ca>
 <15F501D1A78BD343BE8F4D8DB854566B1BFE2ABF@hkemmail01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from idcmail-mo1so.shaw.ca ([24.71.223.10]:54454 "EHLO
	pd4mo1so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756284AbYAKO3g (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 Jan 2008 09:29:36 -0500
Received: from pd3mr2so.prod.shaw.ca
 (pd3mr2so-qfe3.prod.shaw.ca [10.0.141.178]) by l-daemon
 (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0JUH006YQHLBXP20@l-daemon> for linux-ide@vger.kernel.org; Fri,
 11 Jan 2008 07:29:35 -0700 (MST)
Received: from pn2ml10so.prod.shaw.ca ([10.0.121.80])
 by pd3mr2so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05 (built Sep
 5 2006)) with ESMTP id <0JUH0009RHLAIC50@pd3mr2so.prod.shaw.ca> for
 linux-ide@vger.kernel.org; Fri, 11 Jan 2008 07:29:35 -0700 (MST)
Received: from [192.168.1.113] ([70.64.130.4])
 by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0JUH001SVHL9Y360@l-daemon> for linux-ide@vger.kernel.org; Fri,
 11 Jan 2008 07:29:34 -0700 (MST)
In-reply-to: <15F501D1A78BD343BE8F4D8DB854566B1BFE2ABF@hkemmail01.nvidia.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kuan Luo <kluo@nvidia.com>
Cc: Tejun Heo <htejun@gmail.com>, Mark Lord <liml@rtr.ca>, Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Allen Martin <AMartin@nvidia.com>, Peer Chen <pchen@nvidia.com>

Kuan Luo wrote:
> hi robert,
> 	I have fixed a bug in rhel4u5 2.6.9-55 when running adma mode
> with HDS7250SASUN500G.
> 	Could you check this code and if no problem,  then help me to
> submit to the newest kernel.

It seems like a reasonable change - I'm sure you guys would know better 
than I whether it's the right thing to do. The patch got newline wrapped 
and whitespace damaged, however. Can you repost (even as attachment) so 
people can try it out?

> 
> for 2.6.9-55
> diff -Nupr a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
> --- a/drivers/ata/sata_nv.c	2008-01-14 14:37:32.000000000 +0800
> +++ b/drivers/ata/sata_nv.c	2008-01-14 14:37:21.000000000 +0800
> @@ -802,7 +802,7 @@ static irqreturn_t nv_adma_interrupt(int
>  				ata_port_printk(ap, KERN_ERR, "CPB
> error, stat=0x%x\n", status);
>  				have_global_err = 1;
>  			}
> -			if ((status & NV_ADMA_STAT_DONE) ||
> have_global_err) {
> +			if ((status & (NV_ADMA_STAT_CMD_COMPLETE |
> NV_ADMA_STAT_DONE)) || have_global_err) {
>  				/** Check CPBs for completed commands */
>  
>  				if(ata_tag_valid(ap->active_tag))
> @@ -814,6 +814,7 @@ static irqreturn_t nv_adma_interrupt(int
>  					u32 active = ap->sactive;
>  					while( (pos = ffs(active)) ) {
>  						pos--;
> +						if ((notifier_clears[i]
> & (1 << pos)) || have_global_err)
>  						nv_adma_check_cpb(ap,
> pos, have_global_err ||
>  							(notifier_error
> & (1 << pos)) );
>  						active &= ~(1 << pos );
> 
> for 2.6.24-rc7
> 
> diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
> index ed5dc7c..6bffd39 100644
> --- a/drivers/ata/sata_nv.c
> +++ b/drivers/ata/sata_nv.c
> @@ -1010,8 +1010,7 @@ static irqreturn_t nv_adma_interrupt(int irq, void
> *dev_instance)
>  				continue;
>  			}
>  
> -			if (status & (NV_ADMA_STAT_DONE |
> -				      NV_ADMA_STAT_CPBERR)) {
> +			if (status & (NV_ADMA_STAT_DONE |
> NV_ADMA_STAT_CMD_COMPLETE | NV_ADMA_STAT_CPBERR)) {
>  				u32 check_commands;
>  				int pos, error = 0;
>  
> @@ -1023,8 +1022,8 @@ static irqreturn_t nv_adma_interrupt(int irq, void
> *dev_instance)
>  				/** Check CPBs for completed commands */
>  				while ((pos = ffs(check_commands)) &&
> !error) {
>  					pos--;
> -					error = nv_adma_check_cpb(ap,
> pos,
> -						notifier_error & (1 <<
> pos));
> +					if ((notifier_clears[i] & (1 <<
> pos)) || (status & NV_ADMA_STAT_CPBERR))
> +						error =
> nv_adma_check_cpb(ap, pos, notifier_error & (1 << pos));
>  					check_commands &= ~(1 << pos);
>  				}
>  			}
> -----------------------------------------------------------------------------------
> This email message is for the sole use of the intended recipient(s) and may contain
> confidential information.  Any unauthorized review, use, disclosure or distribution
> is prohibited.  If you are not the intended recipient, please contact the sender by
> reply email and destroy all copies of the original message.
> -----------------------------------------------------------------------------------
> 
