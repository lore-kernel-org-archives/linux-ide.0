From: Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] Re: 2.6.17-rc5-git1: regression: resume from suspend(RAM)     fails: libata issue
Date: Sat, 27 May 2006 23:33:33 +0200
Message-ID: <20060527213333.GA32007@suse.de>
References: <1148634262.2310.7.camel@forrest26.sh.intel.com> <200605271423.40037.liml@rtr.ca> <Pine.LNX.4.64.0605271144430.5623@g5.osdl.org> <200605272245.30108.axboe@suse.de> <4478BD60.40806@garzik.org> <20060527211157.GA31275@suse.de> <4478C1DD.2030204@garzik.org> <20060527212011.GA31551@suse.de> <4478C39A.9060302@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:20235 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S964943AbWE0Vdn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 May 2006 17:33:43 -0400
Content-Disposition: inline
In-Reply-To: <4478C39A.9060302@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Mark Lord <liml@rtr.ca>, "zhao, forrest" <forrest.zhao@intel.com>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

On Sat, May 27 2006, Jeff Garzik wrote:
> >+	msleep(500);
> > 	pci_set_power_state(pdev, PCI_D0);
> > 	pci_restore_state(pdev);
> > 	pci_enable_device(pdev);
> 
> Does it work if you move msleep() below pci_restore_state()?
> "	" 	"	"	  below pci_enable_device()?

Placement makes no difference here, it works after pci_enable_device()
as well. What matters is the delay coming before the ata_busy_wait().
You could just stuff it in front of that, if you wanted.

-- 
Jens Axboe

