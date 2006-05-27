From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Re: 2.6.17-rc5-git1: regression: resume from suspend(RAM)
    fails: libata issue
Date: Sat, 27 May 2006 14:38:46 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605271426030.5623@g5.osdl.org>
References: <1148634262.2310.7.camel@forrest26.sh.intel.com>
 <200605271423.40037.liml@rtr.ca> <Pine.LNX.4.64.0605271144430.5623@g5.osdl.org>
 <200605272245.30108.axboe@suse.de> <4478BD60.40806@garzik.org>
 <20060527211157.GA31275@suse.de> <4478C1DD.2030204@garzik.org>
 <20060527212011.GA31551@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:38802 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964966AbWE0Vi4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 May 2006 17:38:56 -0400
In-Reply-To: <20060527212011.GA31551@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: Jeff Garzik <jeff@garzik.org>, Mark Lord <liml@rtr.ca>, "zhao, forrest" <forrest.zhao@intel.com>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org



On Sat, 27 May 2006, Jens Axboe wrote:
> @@ -4846,6 +4847,7 @@ int ata_pci_device_suspend(struct pci_de
>  
>  int ata_pci_device_resume(struct pci_dev *pdev)
>  {
> +	msleep(500);
>  	pci_set_power_state(pdev, PCI_D0);

That's just insane. Why would we need a delay before going to D0? 
Especially a long one like half a second? 

There's something else going on here, and that delay must be just hiding 
the real issue.

Looking at ata_device_resume(), I think the whole thing is pretty broken.

Just as an example, it calls "ata_set_mode()", but that sounds pretty damn 
broken, and it should probably do

	if (ap->ops->set_mode)
		ap->ops->set_mode(ap);
	else
		ata_set_mode(ap);

like ata_bus_probe() does. Similarly, why shouldn't it do the 
probe_reset/phy_reset that is also done in ata_bus_probe()? If it was 
required in ata_bus_probe(), it sounds like it would damn well be required 
at resume time too - from a hw perspective, there should really be _no_ 
difference between the initial bootup, and a resume event. The hardware is 
in the same state.

(From a _software_ perspective, it's different, of course - one does 
discovery, while the other might instead try to see if the state _matches_ 
what it already knows. But the point is that coming back from power-off 
after a resume should really not be any different than coming back from 
power-off after a bootup)

			Linus
