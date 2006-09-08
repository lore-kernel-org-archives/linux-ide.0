From: Tejun Heo <htejun@gmail.com>
Subject: Re: PCI SATA controllers on embedded, no-BIOS targets
Date: Fri, 08 Sep 2006 09:27:00 +0200
Message-ID: <45011B44.3060101@gmail.com>
References: <44EB32E4.8080706@mvista.com> <44EB33BB.4090101@gmail.com> <44EB3650.1080404@mvista.com> <44EB3E2F.4040504@gmail.com> <44EB3F70.6000702@gmail.com> <44EB40DA.3010904@mvista.com> <44EB4658.3060207@gmail.com> <44EB7E13.5090807@mvista.com> <44EBCA7D.60808@gmail.com> <4500A5D4.50606@mvista.com> <4500CB75.6050504@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.181]:48971 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750809AbWIHH1V (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 8 Sep 2006 03:27:21 -0400
Received: by py-out-1112.google.com with SMTP id n25so670350pyg
        for <linux-ide@vger.kernel.org>; Fri, 08 Sep 2006 00:27:20 -0700 (PDT)
In-Reply-To: <4500CB75.6050504@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Kevin Hilman <khilman@mvista.com>, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Kevin Hilman wrote:
>> I've now been using a patched sata_sil driver for a while to support PCI
>> IO space on my embedded ARM target.  Do you have any plans of pushing
>> support for this upstream?
> 
> MMIO doesn't work at all?
> 
> I'm a bit reluctant to push this into mainline, particularly when I feel 
> that the sata_sil driver could still be updated to use only 32-bit MMIO 
> transactions without much problem.

Hello, Kevin, Jeff.

IIRC, Kevin's platform can't do any MMIO.  Also, although sata_sil can 
be made to use 32-bit address space exclusively, I think having PIO 
access in the meantime can be helpful to many newer ATI mips platforms 
out there.  Please note that w/ ioread/write change, the modified code 
is isolated into init_one(), so the added complexity is small.

Thanks.

-- 
tejun
