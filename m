From: Kevin Hilman <khilman@mvista.com>
Subject: Re: PCI SATA controllers on embedded, no-BIOS targets
Date: Fri, 08 Sep 2006 09:29:36 -0700
Message-ID: <45019A70.9060601@mvista.com>
References: <44EB32E4.8080706@mvista.com> <44EB33BB.4090101@gmail.com> <44EB3650.1080404@mvista.com> <44EB3E2F.4040504@gmail.com> <44EB3F70.6000702@gmail.com> <44EB40DA.3010904@mvista.com> <44EB4658.3060207@gmail.com> <44EB7E13.5090807@mvista.com> <44EBCA7D.60808@gmail.com> <4500A5D4.50606@mvista.com> <4500CB75.6050504@garzik.org> <45011B44.3060101@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:53465 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1750847AbWIHQ3n (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 8 Sep 2006 12:29:43 -0400
In-Reply-To: <45011B44.3060101@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Jeff Garzik wrote:
>> Kevin Hilman wrote:
>>> I've now been using a patched sata_sil driver for a while to support PCI
>>> IO space on my embedded ARM target.  Do you have any plans of pushing
>>> support for this upstream?
>>
>> MMIO doesn't work at all?
>>
>> I'm a bit reluctant to push this into mainline, particularly when I
>> feel that the sata_sil driver could still be updated to use only
>> 32-bit MMIO transactions without much problem.
> 
> Hello, Kevin, Jeff.
> 
> IIRC, Kevin's platform can't do any MMIO.  

Actually, this platform (XScale IXP425, big-endian) can do MMIO.  I have
an e100 PCI card on this board where the driver is using MMIO.  I also
have a Promise Ultra133 PCI card, but not sure if that driver is using
memory space or IO space.

Kevin
