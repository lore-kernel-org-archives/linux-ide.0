From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] Re: 2.6.17-rc5-git1: regression: resume from suspend(RAM)
     fails: libata issue
Date: Sat, 27 May 2006 17:34:54 -0400
Message-ID: <4478C5FE.1090306@garzik.org>
References: <1148634262.2310.7.camel@forrest26.sh.intel.com> <200605271423.40037.liml@rtr.ca> <Pine.LNX.4.64.0605271144430.5623@g5.osdl.org> <200605272245.30108.axboe@suse.de> <4478BD60.40806@garzik.org> <20060527211157.GA31275@suse.de> <4478C1DD.2030204@garzik.org> <20060527212011.GA31551@suse.de> <4478C39A.9060302@garzik.org> <20060527213333.GA32007@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:40082 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964931AbWE0Ve7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 May 2006 17:34:59 -0400
In-Reply-To: <20060527213333.GA32007@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Mark Lord <liml@rtr.ca>, "zhao, forrest" <forrest.zhao@intel.com>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

Jens Axboe wrote:
> On Sat, May 27 2006, Jeff Garzik wrote:
>>> +	msleep(500);
>>> 	pci_set_power_state(pdev, PCI_D0);
>>> 	pci_restore_state(pdev);
>>> 	pci_enable_device(pdev);
>> Does it work if you move msleep() below pci_restore_state()?
>> "	" 	"	"	  below pci_enable_device()?
> 
> Placement makes no difference here, it works after pci_enable_device()
> as well. What matters is the delay coming before the ata_busy_wait().
> You could just stuff it in front of that, if you wanted.

That would increase the wait needlessly, since it would be then done 
per-device, even though the devices spin up in parallel on ata_piix.

	Jeff



