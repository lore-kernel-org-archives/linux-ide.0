From: Tejun Heo <htejun@gmail.com>
Subject: Re: Questions about SATA hotplug in linux 2.6
Date: Fri, 26 Oct 2007 11:56:27 +0900
Message-ID: <4721575B.70706@gmail.com>
References: <20071025.011445.80152909.davem@davemloft.net> <472052C1.2050302@garzik.org> <5CAB7B5D6F8AB84AA868A46B47A50705622EAB@sshaexmb1.amd.com> <472153D3.2020102@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.180]:13603 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752700AbXJZC4o (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 Oct 2007 22:56:44 -0400
Received: by wa-out-1112.google.com with SMTP id v27so854908wah
        for <linux-ide@vger.kernel.org>; Thu, 25 Oct 2007 19:56:43 -0700 (PDT)
In-Reply-To: <472153D3.2020102@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Shane Huang <Shane.Huang@amd.com>, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Shane Huang wrote:
>> 1. If users unplug one SATA HDD(no-root partition) or SATA ODD when
>> the system is running, then plug it back to the same SATA port,
>> Should the system and SATA HDD/ODD still work well?
> 
> Yes.

To add a bit, libata hotplug has grace time of at least 15secs.  If the
same device is plugged out and then plugged in in that time, libata
considers that the device and/or connection has suffered transient
failure and assumes it's the same device and there's no modification to
its content.

This means that if you disconnect a harddrive, write to it and then
connect it back in the grace period corruption will occur.  It will be
fun to have some sort of competition to actually do this.  :-)

>> These questions come up when our QA test our SB700 SATA drivers,
>> but I don't know the SATA hotplug support in linux 2.6.
>> Is there any guy who can give some official confirmation? :-)
> 
> The main thing of note with regards to hotplug is that the associated
> device (/dev/sdb, /dev/scd0, etc.) may change between plug and unplug.
> For example, if you unplug a SATA HDD then plug it back in, the user
> might see /dev/sdb disappear, and /dev/sdd appear -- even if it is the
> exact same HDD, on the exact same port.

Yeah, using LABEL and/or UUID is a good idea.  In the future, it will be
nice to have persistent block device name as netdevices do.

-- 
tejun
