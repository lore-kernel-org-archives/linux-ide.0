From: Mark Lord <kernel@teksavvy.com>
Subject: Re: Hotplug borked after suspend/resume in Linux-3.3 ?
Date: Tue, 17 Apr 2012 16:53:08 -0400
Message-ID: <4F8DD834.5070000@teksavvy.com>
References: <4F8DD4DC.4050503@teksavvy.com> <4F8DD708.8050502@teksavvy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport-out.teksavvy.com ([206.248.143.162]:17742 "EHLO
	ironport-out.teksavvy.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751492Ab2DQUxK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Apr 2012 16:53:10 -0400
In-Reply-To: <4F8DD708.8050502@teksavvy.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

On 12-04-17 04:48 PM, Mark Lord wrote:
> On 12-04-17 04:38 PM, Mark Lord wrote:
>> Okay, so why isn't SATA hotplug working in linux-3.3.2 ?
>> I don't know when it stopped working, but it's a blooming pain in the sysadmin.
>>
>> I need to hotplug a SATA drive into an AHCI port,
>> preferably without having to reboot first.
>>
>> Is there a patch available already for this regression?
> 
> 
> Answering my own question, this patch appears to address the issue.
> I'll test and report back again shortly:
> 
>     http://patchwork.ozlabs.org/patch/146326/
> 
> Odd that it's been sitting in various people's inboxes since 3.3-rc1
> and hasn't been pushed out yet.

Ahh.. perhaps because it doesn't fix the problem I'm seeing here.

Oh well, anyone else got a fix for this regression yet?
Even doing a rescan-scsi-bus doesn't work on the closed down ports.

Basically, any unoccupied AHCI port is dead to the world
after a simple suspend/resume (RAM) cycle.  On one of my machines
I can hot unplug/replug the ExpressCard adapter to recover,
but that doesn't work so well for built-in SATA/eSATA ports.

Thanks.

