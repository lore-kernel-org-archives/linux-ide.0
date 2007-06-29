From: Mark Lord <liml@rtr.ca>
Subject: Re: PROBLEM: ata_piix.c for the ICH5 SATA Controller.
Date: Fri, 29 Jun 2007 11:56:30 -0400
Message-ID: <46852BAE.6070505@rtr.ca>
References: <cd98e0260706280546m5d8c8f91kb639731e6e2da8db@mail.gmail.com>	 <4683F340.2020905@rtr.ca> <cd98e0260706290439n475dc02cw552e47fdd953b575@mail.gmail.com> <46851F65.5070400@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:3663 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932603AbXF2Pzx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 29 Jun 2007 11:55:53 -0400
In-Reply-To: <46851F65.5070400@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Johny Mail list <maillist.johny@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Mark Lord wrote:
> Johny Mail list wrote:
>> 2007/6/28, Mark Lord <liml@rtr.ca>:
>>> I have an ugly (but working) hack for the ICH5 ata_piix driver
>>> to support hot insertion/removal of drives, but I don't know if/when
>>> I'll be pushing it upstream.
>>
>> Yes it hang permanently there, after this messages i generally reboot
>> the server.
>> Yes it not support SATA drive hot insertion/removal, but i have make
>> the same test on windows. I unplug one disk when i'm logged and the
>> system don't stop. The drive is removed from the devices list.
>>
>> If you can give me the patch for testing it... I would give you my
>> returns about the good/bad functioning in my case.
> 
> Okay, Here is a working patch for a very specific variant of ICH5.
> If your PCI IDs don't match what the patch is looking for,
> then it should have no effect -- you may need to patch the patch
> to contain the correct PCI IDs (from lspci -n).
> * * *
> 
> Implement ICH5 chipset handling for drive hot insertion/removal.
> This cannot go upstream, as it conflicts with a more generic
> polled-hotplug framework that is currently in development.
> 
> Hot-inserted drives are automatically detected within a second or two,
> and are ready-to-use within 30 seconds or so.  This could be even faster,
> but the 2.6.18.8 libata implementation of error-handling is what slows
> us down here.
...

This patch was for 2.6.18.8 -- it *might* apply to newer kernels,
but I haven't ported it forward yet.

Cheers
