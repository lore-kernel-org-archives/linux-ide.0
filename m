From: Maxime Bizon <mbizon@freebox.fr>
Subject: Re: "irq 4: nobody cared" when loading ahci driver on ce4100
Date: Tue, 15 Mar 2011 05:20:40 +0100
Message-ID: <1300162840.2118.4.camel@kero>
References: <1300129707.28545.34.camel@sakura.staff.proxad.net>
	 <4D7EB9EB.8030807@gmail.com>
Reply-To: mbizon@freebox.fr
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp4-g21.free.fr ([212.27.42.4]:55681 "EHLO smtp4-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750758Ab1COEUx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 15 Mar 2011 00:20:53 -0400
In-Reply-To: <4D7EB9EB.8030807@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, linux-ide <linux-ide@vger.kernel.org>


On Mon, 2011-03-14 at 18:59 -0600, Robert Hancock wrote:

> Where is ahci_thaw being called? It shouldn't be called before the IRQ
> handler is registered - I think it should only be called from the
> error 

it is not

ahci_pmp_attach/ahci_pmp_detach are the one setting the irq_mask too
soon

-- 
Maxime

