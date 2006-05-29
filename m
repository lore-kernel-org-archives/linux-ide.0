From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH alt4 v3] libata resume fixes
Date: Mon, 29 May 2006 01:25:25 -0400
Message-ID: <447A85C5.90202@garzik.org>
References: <20060527195847.GA28334@havoc.gtf.org>	 <20060527205213.GA30686@havoc.gtf.org> <4478BD18.6010908@rtr.ca>	 <4478C0A1.4050003@rtr.ca>  <4478C2C9.3030703@garzik.org> <1148874794.2310.21.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:48318 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751191AbWE2FZa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 May 2006 01:25:30 -0400
In-Reply-To: <1148874794.2310.21.camel@forrest26.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "zhao, forrest" <forrest.zhao@intel.com>
Cc: Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org, torvalds@osdl.org, Jens Axboe <axboe@suse.de>

zhao, forrest wrote:
> On Sat, 2006-05-27 at 17:21 -0400, Jeff Garzik wrote:
>> o_simple_cmd: ata command failed: 4
>>
>> 0xE1 is IDLE IMMEDIATE, so it looks like it is making progress.
>>
>> This makes me realize that ata_bus_probe() won't get the job done
>> alone, 
>> we must do:
>>
>> * host init
>> * phy init
>> * idle immediate
>> * the rest of bus probe
>>
>> Good, good data points here...
> 
> Jeff,
> 
> This observation is very valuable. I'll write the patch for this
> together with the AHCI suspend/resume support for 2.6.1[8/9] soon.

Thanks for your continued work on AHCI.

BTW, you/Hannes' AHCI suspend/resume patch needs to be split up into 
multiple steps, for easier reviewing and applying.  Something like:
* update ahci_{start,stop}_engine, and update all it users
* split out start/stop FIS RX into separate functions, no code flow changes
* use ahci_{start,stop}_fis_rx in appropriate places
* add suspend/resume support

The current AHCI suspend/resume patch does a lot more than just add 
suspend/resume... it modifies the current AHCI probe code and 
operational code in several areas.  We need to be able to evaluate these 
changes outside the context of suspend/resume, because the changes 
affect more than just suspend/resume.

The analogy I use [stolen from Al Viro] is mathematic, for illustrating 
a progression of patches:  when working a mathematical proof, you supply 
the progression leading to the answer, in addition to the answer itself.


> BTW. Have we achieved consensus that the bus resume operation should be
> done in [s/p]ata_pci_device_resume() in 2.6.1[8/9]?

Its pretty much a requirement for FIS-based controllers and Port 
Multipliers.  Since the bus is not an independent object from the device 
model perspective, we must manage it as part of the controller (which 
indeed it is -- a wire and phy managed by the controller hardware).

Long term, I hope that we will have a device model with proper 
dependencies.  That means an object for the bus in addition to objects 
for controller and device.  Once that happens, we can do not only proper 
suspend/resume, but also runtime power management.

	Jeff


