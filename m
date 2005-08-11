From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH libata-dev-2.6:sil24 04/07] sil24: remove irq disable
 code on spurious interrupt
Date: Thu, 11 Aug 2005 15:19:28 -0400
Message-ID: <42FBA4C0.4050304@pobox.com>
References: <20050730101344.1C985988@htj.dyndns.org> <20050730101344.EB905F0C@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:54183 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932388AbVHKTTc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 11 Aug 2005 15:19:32 -0400
In-Reply-To: <20050730101344.EB905F0C@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Carlos.Pardo@siliconimage.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> 04_sil24_remove-irq-disable-on-spurious-interrupt.patch
> 
> 	If interrupt occurs on a disabled port, the driver used to
> 	mask the port's interrupt, but we don't know if such action is
> 	necessary yet and that's not what other drives do.  So, just
> 	do nothing and tell IRQ subsystem that it's not our interrupt.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

ACK


