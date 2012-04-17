From: Mark Lord <kernel@teksavvy.com>
Subject: Re: Hotplug borked after suspend/resume in Linux-3.3 ?
Date: Tue, 17 Apr 2012 17:05:40 -0400
Message-ID: <4F8DDB24.9080109@teksavvy.com>
References: <4F8DD4DC.4050503@teksavvy.com> <4F8DD708.8050502@teksavvy.com> <4F8DD939.1050909@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport-out.teksavvy.com ([206.248.143.162]:57388 "EHLO
	ironport-out.teksavvy.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751647Ab2DQVFl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Apr 2012 17:05:41 -0400
In-Reply-To: <4F8DD939.1050909@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

On 12-04-17 04:57 PM, Jeff Garzik wrote:
> On 04/17/2012 04:48 PM, Mark Lord wrote:
>> On 12-04-17 04:38 PM, Mark Lord wrote:
>>> Okay, so why isn't SATA hotplug working in linux-3.3.2 ?
>>> I don't know when it stopped working, but it's a blooming pain in the sysadmin.
>>>
>>> I need to hotplug a SATA drive into an AHCI port,
>>> preferably without having to reboot first.
>>>
>>> Is there a patch available already for this regression?
>>
>>
>> Answering my own question, this patch appears to address the issue.
>> I'll test and report back again shortly:
>>
>>      http://patchwork.ozlabs.org/patch/146326/
>>
>> Odd that it's been sitting in various people's inboxes since 3.3-rc1
>> and hasn't been pushed out yet.
> 
> The vast majority of "hotpluggable" ports are not necessarily covered by this patch.


And what majority of ports are currently broken by linux-3.3 ?
Any idea of what the offending commit may have been,
so I can test against that and perhaps get it reverted then?

So far, my sample of three systems are all broken with this kernel.
That's definitely "regression" territory.  :)

