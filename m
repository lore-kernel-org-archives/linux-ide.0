From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH alt4 v2] libata resume fixes
Date: Sat, 27 May 2006 17:00:45 -0400
Message-ID: <4478BDFD.60209@rtr.ca>
References: <20060527195847.GA28334@havoc.gtf.org> <20060527201024.GA29015@havoc.gtf.org> <4478B312.5040901@garzik.org> <4478B611.2030201@rtr.ca> <4478B743.2050006@garzik.org> <4478B971.3060409@rtr.ca> <4478BD09.5010309@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:26858 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S964967AbWE0VAn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 May 2006 17:00:43 -0400
In-Reply-To: <4478BD09.5010309@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: torvalds@osdl.org, linux-ide@vger.kernel.org

Jeff Garzik wrote:
>
> As mentioned elsewhere, Linus's patch falls over when we start resuming 
> controllers with real SATA phy registers, so that would be a separate 
> sata_pci_device_resume() function.

But does it fall over any worse than we already do with the stock kernel?
