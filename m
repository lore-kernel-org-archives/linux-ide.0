From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 3/4] libata: make ata_set_mode() responsible for failure
 handling
Date: Mon, 20 Mar 2006 20:54:58 -0500
Message-ID: <441F5CF2.4080108@pobox.com>
References: <11422375531645-git-send-email-htejun@gmail.com> <44152F3D.50307@pobox.com> <20060313094401.GD2091@htj.dyndns.org> <441541BE.80505@pobox.com> <20060313101434.GF2091@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:29670 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030221AbWCUBzF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 20 Mar 2006 20:55:05 -0500
In-Reply-To: <20060313101434.GF2091@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: albertcc@tw.ibm.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> On Mon, Mar 13, 2006 at 04:56:14AM -0500, Jeff Garzik wrote:
> 
>>Tejun Heo wrote:
>>
>>>On Mon, Mar 13, 2006 at 03:37:17AM -0500, Jeff Garzik wrote:
>>>
>>>
>>>>I have the following concern with this patch (#3) however:
>>>>
>>>>
>>>>
>>>>>-static void ata_dev_set_mode(struct ata_port *ap, struct ata_device 
>>>>>*dev)
>>>>>+static int ata_dev_set_mode(struct ata_port *ap, struct ata_device *dev)
>>>>>{
>>>>>-	if (!ata_dev_present(dev) || (ap->flags & ATA_FLAG_PORT_DISABLED))
>>>>>-		return;
>>>>
>>>>I think you drop too many ATA_FLAG_PORT_DISABLED tests in this patch, 
>>>>leading the code to potentially miss a previously-flagged PORT_DISABLED 
>>>>(perhaps by an LLDD).
>>>>
>>>
>>>
>>>Hmmm... the plan is to disallow LLDD's take ports or devices offline
>>
>>>from low level callbacks.  They should just let upper layer know by
>>
>>>returning failure code.
>>
>>Long term that plan is fine, but you still have to deal with the 
>>existing API one way or another.  ata_port_disable() is called directly 
>>by a bunch of Alan's PATA drivers, and by ata_piix and sata_mv.
>>
>>Thus you would either need to keep the PORT_DISABLED checks or convert 
>>the drivers in question to a better API.
>>
>>So just check those ata_port_disable() cases...
>>
> 
> 
> AFAICS, ata_piix doesn't call ata_port_disable() directly, but
> sata_mv() does, through mv_host_intr() -> mv_err_intr()
> ->mv_stop_and_reset() -> __mv_phy_reset().  I'll check the code path
> such that disabled ports are handled properly.  Thanks for pointing
> out.

Yeah, sorry, for ata_piix I was looking at vanilla linux-2.6.git rather 
than libata-dev.git#upstream... :)

	Jeff



