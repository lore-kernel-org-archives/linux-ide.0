From: Jeff Garzik <jeff@garzik.org>
Subject: Re: PCI SATA controllers on embedded, no-BIOS targets
Date: Thu, 07 Sep 2006 21:46:29 -0400
Message-ID: <4500CB75.6050504@garzik.org>
References: <44EB32E4.8080706@mvista.com> <44EB33BB.4090101@gmail.com> <44EB3650.1080404@mvista.com> <44EB3E2F.4040504@gmail.com> <44EB3F70.6000702@gmail.com> <44EB40DA.3010904@mvista.com> <44EB4658.3060207@gmail.com> <44EB7E13.5090807@mvista.com> <44EBCA7D.60808@gmail.com> <4500A5D4.50606@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:43691 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751881AbWIHBqe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 7 Sep 2006 21:46:34 -0400
In-Reply-To: <4500A5D4.50606@mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kevin Hilman <khilman@mvista.com>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

Kevin Hilman wrote:
> I've now been using a patched sata_sil driver for a while to support PCI
> IO space on my embedded ARM target.  Do you have any plans of pushing
> support for this upstream?

MMIO doesn't work at all?

I'm a bit reluctant to push this into mainline, particularly when I feel 
that the sata_sil driver could still be updated to use only 32-bit MMIO 
transactions without much problem.

	Jeff


