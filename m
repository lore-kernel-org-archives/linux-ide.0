From: Tejun Heo <tj@kernel.org>
Subject: Re: Port multiplier resets
Date: Sun, 23 Nov 2008 09:53:19 +0900
Message-ID: <4928A97F.5040202@kernel.org>
References: <490DC300.40703@seiner.com> <49194B20.8000209@kernel.org> <4924D733.6070005@seiner.com> <4924D86C.8010107@kernel.org> <492837E0.3080906@seiner.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:51353 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753724AbYKWAxA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 22 Nov 2008 19:53:00 -0500
In-Reply-To: <492837E0.3080906@seiner.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Yan Seiner <yan@seiner.com>
Cc: linux-ide@vger.kernel.org

Yan Seiner wrote:
> Tejun Heo wrote:
>> Yan Seiner wrote:
>>  
>>> Tejun Heo wrote:
>>>    
>>>> 2. Specify libata.force=8.15:1.5Gbps
>>>>         
>>> dumb question:
>>>
>>> Does this go on the kernel parameter line or can I change it without
>>> rebooting the system?
>>>
>>> I don't see it in /sys/module/libata/parameters so I'm guessing it needs
>>> a reboot?
>>>     
>>
>> Yeah, you will need to reboot or reload libata module.  Note that if
>> libata.ko is being loaded from initrd, different distros use different
>> methods to pass parameters to them.
>>
>>   
> Thanks for all your help.   Unfortunately I'm still dead in the water
> with the jmicron controller....  :-(
> 
> If anything, things have gotten worse.  I suspect that the hardware is
> broken, but I'm hoping there's still something I can do.
> 
> The jmicron controller is ata3 and ata4.  Here's my kernel line from grub:
> 
> title           Debian GNU/Linux, kernel 2.6.27.4
> root            (hd0,1)
> kernel          /vmlinuz-2.6.27.4 root=/dev/md0 ro quiet
> libata.force=3.15:1.5Gbps,4.15:1.5Gbps
> initrd          /initrd.img-2.6.27.4
> 
> I'm trying to limit the link from the controller to the PMP to 1.5
> Gbps.  That doesn't seem to be happening.  Worse, now the drives
> connected to that controller aren't being recognized.
> 
> I get "link online but device misclassified, retrying" errors.  It's not
> the drive or the caddy; I've swapped drives, slots, and cables and the
> errors remain with the jmicron ports.
> 
> I'm attaching a log which takes you from boot, to powerup of the
> diskpack, and then a power cycle of the diskpack.  Unfortunately I
> cannot boot with the external drives powered up; the jmicron controller
> hangs (it has a conflict with the scsi controller if any drives are
> attached at boot.)
> 
> I'd appreciate any help at this point.  My only alternative is to
> disable the onboard jmicron and get a PCI-based esata controller.

The parameter isn't getting through.  Please make that work first.  Ask
your distro how to do that and can you try a shorter cable?

-- 
tejun
