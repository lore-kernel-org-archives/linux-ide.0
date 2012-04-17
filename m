From: Mark Lord <kernel@teksavvy.com>
Subject: Re: Hotplug borked after suspend/resume in Linux-3.3 ?
Date: Tue, 17 Apr 2012 17:14:47 -0400
Message-ID: <4F8DDD47.8070809@teksavvy.com>
References: <4F8DD4DC.4050503@teksavvy.com> <4F8DD7AB.2050709@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport-out.teksavvy.com ([206.248.143.162]:59707 "EHLO
	ironport-out.teksavvy.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752881Ab2DQVOt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Apr 2012 17:14:49 -0400
In-Reply-To: <4F8DD7AB.2050709@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Lin Ming <ming.m.lin@intel.com>

On 12-04-17 04:50 PM, Jeff Garzik wrote:
> On 04/17/2012 04:38 PM, Mark Lord wrote:
>> Okay, so why isn't SATA hotplug working in linux-3.3.2 ?
>> I don't know when it stopped working, but it's a blooming pain in the sysadmin.
>>
>> I need to hotplug a SATA drive into an AHCI port,
>> preferably without having to reboot first.
>>
>> Is there a patch available already for this regression?
> 
> hrm...  smells like runtime PM stuff.
> 
> Can you try "libata: disable runtime pm for hotpluggable port"?
> 
> You probably have to edit ahci_port_pluggable() to make it unconditionally return true.

Okay tried the ahci_port_pluggable() hack, no difference.
The patch above fixes the issue on two systems here with motherboard SATA,
and has zero effect on the AHCI ExpressCard in my notebook.

The notebook issue is definitely PCIe hotplug b0rkage, not libata.
I fixed that once, a few years ago, but it seems to have crept back
into the kernel again when I wasn't paying close attention.

Dunno when, could have been there for ages now.

But the libata regression is new.  And fixable here, at least.
I think whatever broke it should get reverted ASAP until you are
happy with a more permanent solution.

Otherwise the solution above is what I'm now patching into all of my systems here.

Cheers
