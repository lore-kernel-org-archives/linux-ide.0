From: Tejun Heo <htejun@gmail.com>
Subject: Re: disabling sata_nv ADMA for 2.6.24
Date: Thu, 10 Jan 2008 15:59:20 +0900
Message-ID: <4785C248.6000804@gmail.com>
References: <4781F008.9070404@gmail.com> <4782422C.8020202@rtr.ca> <4782B73B.8080309@shaw.ca> <4782BC48.4000309@gmail.com> <4782C008.3030902@shaw.ca> <4782CB62.7040901@gmail.com> <4782CEF9.3040708@gmail.com> <4782DFFE.50301@shaw.ca> <4782E5A8.9010305@gmail.com> <4782E63E.1000606@gmail.com> <4782E78F.9050205@shaw.ca> <4782E912.1050204@gmail.com> <4783493A.7070800@gmail.com> <47838B57.8020407@shaw.ca> <47842A54.2060107@gmail.com> <47842ABA.2060605@gmail.com> <47844471.4070705@shaw.ca> <47845708.6060900@gmail.com> <478567D8.10601@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.182]:51520 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752311AbYAJG71 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 10 Jan 2008 01:59:27 -0500
Received: by wa-out-1112.google.com with SMTP id v27so898452wah.23
        for <linux-ide@vger.kernel.org>; Wed, 09 Jan 2008 22:59:26 -0800 (PST)
In-Reply-To: <478567D8.10601@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: Mark Lord <liml@rtr.ca>, Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Allen Martin <AMartin@nvidia.com>, Peer Chen <pchen@nvidia.com>, Kuan Luo <kluo@nvidia.com>

Robert Hancock wrote:
> However, how about putting in a printk in nv_adma_interrupt handler here:
> 
> /* freeze if hotplugged or controller error */
> if (unlikely(status & (NV_ADMA_STAT_HOTPLUG |
>                NV_ADMA_STAT_HOTUNPLUG |
>                NV_ADMA_STAT_TIMEOUT |
>                NV_ADMA_STAT_SERROR))) {
>     struct ata_eh_info *ehi = &ap->link.eh_info;
>         ata_ehi_clear_desc(ehi);
> --->    ata_port_printk("ADMA status 0x%08x: ", status);
>     __ata_ehi_push_desc(ehi, "ADMA status 0x%08x: ", status);

Alright, will do when I get some time.

-- 
tejun
