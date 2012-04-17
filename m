From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Hotplug borked after suspend/resume in Linux-3.3 ?
Date: Tue, 17 Apr 2012 16:57:29 -0400
Message-ID: <4F8DD939.1050909@pobox.com>
References: <4F8DD4DC.4050503@teksavvy.com> <4F8DD708.8050502@teksavvy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:53989 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752369Ab2DQU5c (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Apr 2012 16:57:32 -0400
Received: by qcro28 with SMTP id o28so4110752qcr.19
        for <linux-ide@vger.kernel.org>; Tue, 17 Apr 2012 13:57:32 -0700 (PDT)
In-Reply-To: <4F8DD708.8050502@teksavvy.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <kernel@teksavvy.com>
Cc: Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

On 04/17/2012 04:48 PM, Mark Lord wrote:
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
>      http://patchwork.ozlabs.org/patch/146326/
>
> Odd that it's been sitting in various people's inboxes since 3.3-rc1
> and hasn't been pushed out yet.

The vast majority of "hotpluggable" ports are not necessarily covered by 
this patch.

	Jeff



