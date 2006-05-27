From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] Re: 2.6.17-rc5-git1: regression: resume from suspend(RAM)
    fails: libata issue
Date: Sat, 27 May 2006 17:50:39 -0400
Message-ID: <4478C9AF.30405@garzik.org>
References: <1148634262.2310.7.camel@forrest26.sh.intel.com> <200605271423.40037.liml@rtr.ca> <Pine.LNX.4.64.0605271144430.5623@g5.osdl.org> <200605272245.30108.axboe@suse.de> <4478BD60.40806@garzik.org> <20060527211157.GA31275@suse.de> <4478C1DD.2030204@garzik.org> <20060527212011.GA31551@suse.de> <Pine.LNX.4.64.0605271426030.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:62098 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964942AbWE0Vup (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 May 2006 17:50:45 -0400
In-Reply-To: <Pine.LNX.4.64.0605271426030.5623@g5.osdl.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jens Axboe <axboe@suse.de>, Mark Lord <liml@rtr.ca>, "zhao, forrest" <forrest.zhao@intel.com>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

Linus Torvalds wrote:
> 
> On Sat, 27 May 2006, Jens Axboe wrote:
>> @@ -4846,6 +4847,7 @@ int ata_pci_device_suspend(struct pci_de
>>  
>>  int ata_pci_device_resume(struct pci_dev *pdev)
>>  {
>> +	msleep(500);
>>  	pci_set_power_state(pdev, PCI_D0);
> 
> That's just insane. Why would we need a delay before going to D0? 
> Especially a long one like half a second? 
> 
> There's something else going on here, and that delay must be just hiding 
> the real issue.

It is.  But I thought you wanted something that works?  :)

Your patch + Jens' patch [with the delay MOVED to the end] would get my 
ACK for 2.6.17, and we already have infrastructure queued for 2.6.18 to 
do a better job of kicking the controller and bus.


> Looking at ata_device_resume(), I think the whole thing is pretty broken.
> 
> Just as an example, it calls "ata_set_mode()", but that sounds pretty damn 
> broken, and it should probably do
> 
> 	if (ap->ops->set_mode)
> 		ap->ops->set_mode(ap);
> 	else
> 		ata_set_mode(ap);

Correct.

Furthermore, we probably need to issue IDLE IMMEDIATE command ("wake 
up") before SET FEATURES - XFER MODE.


> like ata_bus_probe() does. Similarly, why shouldn't it do the 
> probe_reset/phy_reset that is also done in ata_bus_probe()? If it was 

It should, most definitely.  Otherwise we skip initializing the 
controller and phy (a key objection of mine all along).


> required in ata_bus_probe(), it sounds like it would damn well be required 
> at resume time too - from a hw perspective, there should really be _no_ 
> difference between the initial bootup, and a resume event. The hardware is 
> in the same state.

Correct, correct, correct :)


> (From a _software_ perspective, it's different, of course - one does 
> discovery, while the other might instead try to see if the state _matches_ 
> what it already knows. But the point is that coming back from power-off 
> after a resume should really not be any different than coming back from 
> power-off after a bootup)

Key difference:  we have no BIOS to give us sane hardware state, so the 
controller is in a different state from bootup.

Lacking controller init (you mention this above), we basically have raw 
silicon defaults.

We are really debugging from scratch here, and there's a lot of work to do.

Just apply the delay patch for 2.6.17, Mr. Get-It-Working ;-)  Else dive 
into the big can of worms and give us time to fix it right...

	Jeff


