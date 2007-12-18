From: Tejun Heo <htejun@gmail.com>
Subject: Re: Questions about SATA hotplug in linux 2.6
Date: Tue, 18 Dec 2007 18:18:44 +0900
Message-ID: <47679074.9000400@gmail.com>
References: <20071025.011445.80152909.davem@davemloft.net> <472052C1.2050302@garzik.org> <5CAB7B5D6F8AB84AA868A46B47A50705622EAB@sshaexmb1.amd.com> <472153D3.2020102@garzik.org> <4721575B.70706@gmail.com> <B90463BC30D2E446BA423D888DC85E500677BF@sshaexmb1.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.187]:4458 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751580AbXLRJSv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 18 Dec 2007 04:18:51 -0500
Received: by rv-out-0910.google.com with SMTP id k20so2201967rvb.1
        for <linux-ide@vger.kernel.org>; Tue, 18 Dec 2007 01:18:50 -0800 (PST)
In-Reply-To: <B90463BC30D2E446BA423D888DC85E500677BF@sshaexmb1.amd.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Shane Huang <Shane.Huang@amd.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Shane Huang wrote:
> Hi Jeff  and  Tejun:
> 
> 
> I want to continue this discussion with some questions:
> 
>> From: Tejun Heo wrote:
>> Jeff Garzik wrote:
>>> Shane Huang wrote:
>>>> 1. If users unplug one SATA HDD(no-root partition) or SATA ODD when
>>>> the system is running, then plug it back to the same SATA port,
>>>> Should the system and SATA HDD/ODD still work well?
>>> Yes.
>> To add a bit, libata hotplug has grace time of at least 15secs.  If
> the
>> same device is plugged out and then plugged in in that time, libata
>> considers that the device and/or connection has suffered transient
>> failure and assumes it's the same device and there's no modification
> to
>> its content.
>>
>> This means that if you disconnect a harddrive, write to it and then
>> connect it back in the grace period corruption will occur.  It will be
>> fun to have some sort of competition to actually do this.  :-)
>>
>>>> These questions come up when our QA test our SB700 SATA drivers,
>>>> but I don't know the SATA hotplug support in linux 2.6.
>>>> Is there any guy who can give some official confirmation? :-)
>>> The main thing of note with regards to hotplug is that the
> associated
>>> device (/dev/sdb, /dev/scd0, etc.) may change between plug and
> unplug.
>>> For example, if you unplug a SATA HDD then plug it back in, the user
>>> might see /dev/sdb disappear, and /dev/sdd appear -- even if it is
> the
>>> exact same HDD, on the exact same port.
>> Yeah, using LABEL and/or UUID is a good idea.  In the future, it will
> be
>> nice to have persistent block device name as netdevices do.
> 
> 
> When I disconnect SATA ODD and plug it back to the same SATA port after
> several seconds, it can still work well. But if I plug it to a different
> SATA port, it will NOT able to work any more. I will attach the log
> messages at the end of this mail, please check them.
> 
> My Env:
> SB700 + RS780, openSUSE10.3 i386.
> 
> I also find the same symptom on Intel E210882 (ICH5) under RedHat
> RHEL4U5.
> That's to say failure of SATA hotplug to different ports also exist on
> some Intel platforms.
> 
> Do you guys think it's normal? It not, how to make SATA hotplug work on
> different SATA port? Should it be supported by BIOS or hardware?

If you connect it to a different port, the original device will die and
new device will appear.  That's the expected behavior.  In the log, I
only see ata3.00 is dying.  Isn't there any log from different port?

-- 
tejun
