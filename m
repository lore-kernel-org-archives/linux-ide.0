From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] Re: 2.6.17-rc5-git1: regression: resume from suspend(RAM)
    fails: libata issue
Date: Sat, 27 May 2006 18:11:29 -0400
Message-ID: <4478CE91.60104@garzik.org>
References: <1148634262.2310.7.camel@forrest26.sh.intel.com> <200605271423.40037.liml@rtr.ca> <Pine.LNX.4.64.0605271144430.5623@g5.osdl.org> <200605272245.30108.axboe@suse.de> <4478BD60.40806@garzik.org> <20060527211157.GA31275@suse.de> <4478C1DD.2030204@garzik.org> <20060527212011.GA31551@suse.de> <Pine.LNX.4.64.0605271426030.5623@g5.osdl.org> <4478C9AF.30405@garzik.org> <Pine.LNX.4.64.0605271453490.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:45971 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964995AbWE0WLi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 May 2006 18:11:38 -0400
In-Reply-To: <Pine.LNX.4.64.0605271453490.5623@g5.osdl.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jens Axboe <axboe@suse.de>, Mark Lord <liml@rtr.ca>, "zhao, forrest" <forrest.zhao@intel.com>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

Linus Torvalds wrote:
> 
> On Sat, 27 May 2006, Jeff Garzik wrote:
>> It is.  But I thought you wanted something that works?  :)
> 
> I want something that can be _understood_ to work, and that clearly 
> doesn't have any downsides.
> 
> Waiting for the target to not be BUSY at resume is such an obviously 
> understandable thing that it's not even funny.

s/target/bus/, agreed.

Remember there might be two devices attached (master/slave), so for the 
master/slave case we will wait for BSY twice, both times with the master 
selected.


> In contrast, having an unconditional half-second delay for each SATA port 
> is not obvious at all, and has potentially huge downsides for totally 
> unrelated users. 

Incorrect:  half-second for each _controller_.

And the only users affected by the delay are ata_piix users doing resume.

Side note -- do you notice that the suspend is really hardcoded for 
ata_piix and Intel laptops at the moment?  Note ata_set_mode() versus 
->set_mode(), complete lack of controller re-init, etc.


>> Your patch + Jens' patch [with the delay MOVED to the end] would get my ACK
>> for 2.6.17, and we already have infrastructure queued for 2.6.18 to do a
>> better job of kicking the controller and bus.
> 
> No way am I adding a random half-second wait. One _millisecond_ or 
> something similar clearly won't impact anybody else. But half a second for 
> a condition that people don't even understand?

Normally I would agree, but the delay would be immediately removed for 
2.6.18.  libata-dev.git#upstream has reorganized the probe code to 
better support this case as well as hotplug.  And in general #upstream 
recovers from errors A LOT better.

So AFAICS there are three paths to success:

1) Apply Jens' patch for 2.6.17, then undo it in 2.6.18 when #upstream 
is merged.

2) Copy a bunch of code into pci_driver::resume and more into 
ata_device_resume(), to do controller and phy init.  And then remove the 
copied code in 2.6.18 when #upstream is merged.

3) Pull #upstream now, and give us another -rc to fix things.

	Jeff




