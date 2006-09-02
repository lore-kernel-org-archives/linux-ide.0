From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: 2.6.18-rc5-mm1
Date: Sat, 02 Sep 2006 02:47:24 -0700
Message-ID: <44F9532C.2020802@goop.org>
References: <20060901015818.42767813.akpm@osdl.org> <1157158847.20509.10.camel@mhcln03> <20060901183028.1c6da4df.akpm@osdl.org> <44F93EB3.8050500@goop.org> <44F942B9.6050102@goop.org> <20060902084440.GA13361@suse.de> <44F9452F.8090306@goop.org> <20060902085254.GA14123@suse.de> <44F950A3.1000206@goop.org> <44F95110.6010500@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gw.goop.org ([64.81.55.164]:42412 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1750940AbWIBJrY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 2 Sep 2006 05:47:24 -0400
In-Reply-To: <44F95110.6010500@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Greg KH <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>, Matthias Hentges <oe@hentges.net>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>, linux-ide@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>

Jeff Garzik wrote:
>>
>> Reverting them makes the machine work, with basically the same effect 
>> as disabling CONFIG_PCI_MSI: no MSI interrupts appear in 
>> /proc/interrupts, and e1000 & libata are using IO-APIC-fasteoi.  So, 
>> a reasonable result for now.
>
> Did you re-enable CONFIG_PCI_MSI, after reverting the patches?

Yes.  Er.  Hm, perhaps not, it didn't build:

  CC      drivers/pci/htirq.o
drivers/pci/htirq.c: In function 'ht_create_irq':
drivers/pci/htirq.c:126: error: 'PCI_CAP_ID_HT' undeclared (first use in this function)
drivers/pci/htirq.c:126: error: (Each undeclared identifier is reported only once
drivers/pci/htirq.c:126: error: for each function it appears in.)

I'll try again with CONFIG_HT_IRQ disabled...

    J


-- 
VGER BF report: H 0
