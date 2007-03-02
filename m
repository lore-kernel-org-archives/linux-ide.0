From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: implement and use ata_wait_idle_quiet()
Date: Fri, 02 Mar 2007 17:51:16 -0500
Message-ID: <45E8AA64.9080207@garzik.org>
References: <20070227142606.GI20322@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:54395 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992701AbXCBWvS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 2 Mar 2007 17:51:18 -0500
In-Reply-To: <20070227142606.GI20322@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> ata_wait_idle() complains when the device isn't idle 10ms wait.
> However, this function sometimes is used on empty ports.  As SATA
> controllers report arbitrary status on empty ports, this causes
> spurious warning messages.
> 
> * separate ata_wait_idle_quiet() from ata_wait_idle()
> * use _quiet version in ata_irq_on()
> * fix warning message in ata_wait_idle() to use ata_port_printk()
>   while at it
> 
> This makes spurious abnormal status messages seen in many sff
> controllers.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

My feeling is that this will also hide bugs, such as in the AHCI case

	Jeff



