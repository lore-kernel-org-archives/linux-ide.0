From: Jeff Garzik <jeff@garzik.org>
Subject: Re: PMP device port link speed issues
Date: Thu, 25 Oct 2007 06:25:51 -0400
Message-ID: <47206F2F.4020206@garzik.org>
References: <2A6F278C5B66C4459AF4013E77A40CD301003114@zin33exm20.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:45181 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754264AbXJYKZx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 25 Oct 2007 06:25:53 -0400
In-Reply-To: <2A6F278C5B66C4459AF4013E77A40CD301003114@zin33exm20.fsl.freescale.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kalra Ashish-B00888 <ashish.kalra@freescale.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Kalra Ashish-B00888 wrote:
> While testing the "sata_fsl" driver with a Sil3726 based PMP, we had a
> specific configuration where the host port to PMP link speed was
> 1.5Gbps, while the PMP has configured it's device port(s) link speed to
> 3Gbps. This configuration causes NCQ hangs on certain Seagate drives,
> probably because of the link speed difference between host and PMP
> device & PMP device ports and drives.
>  
> Does it makes sense to limit the PMP device port link speeds to the host
> port link speed ? 
>  
> I believe currently sata_pmp_attach() is calling sata_link_init_spd()
> for each PMP device port and thus causing PMP device port link speeds
> being configured independent of host port link speed. Probably the PMP
> device port links should be limited to the host link speed. 

Interesting question.  I'm sure Tejun will chime in, but I'm wondering 
if there is any real use -- even theoretical -- for running downstream 
links faster than the host<->PMP link?

	Jeff




