From: Mark Lord <kernel@teksavvy.com>
Subject: Re: [BUG] libahci returns stale result tf much of the time.
Date: Mon, 04 Oct 2010 13:31:24 -0400
Message-ID: <4CAA0F6C.6080609@teksavvy.com>
References: <4C9C3878.9010206@teksavvy.com> <AANLkTi=85A9ueu9YYrh0jOKFgc+fqbaUhkRLt7=Bzx2M@mail.gmail.com> <4C9C44D0.1030409@teksavvy.com> <AANLkTinOECHi_7+y7yT-GZXxW0c4vrJOuRz80kejt2+N@mail.gmail.com> <4C9CA385.5090709@teksavvy.com> <4C9CA673.4090104@teksavvy.com> <4C9D33C0.8050900@gmail.com> <4CA99BCB.8080904@gmail.com> <4CAA0885.8060906@teksavvy.com> <4CAA0996.5080403@teksavvy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.181]:22367 "EHLO
	ironport2-out.pppoe.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752734Ab0JDRb0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Oct 2010 13:31:26 -0400
In-Reply-To: <4CAA0996.5080403@teksavvy.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Robert Hancock <hancockrwd@gmail.com>, Seed <seedrubbish@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

On 10-10-04 01:06 PM, Mark Lord wrote:
..
>> That's my theory, too (slow updating of the area).
>> I haven't pursued it further yet, but I will.
>>
>> This is really disruptive for me here, as my primary eSATA
>> adaptor in my notebook is JMB360, and it gets used a LOT.
>
> Okay, I just now ran a quick test on another machine with AHCI: Same bug:
>
> 00:1f.2 SATA controller: Intel Corporation 82801HR/HO/HH (ICH8R/DO/DH) 6 port SATA AHCI Controller (rev 02)
>
> So it's probably universal. Try it with this simple test:
>
> hdparm -I /dev/sdX ## this works
> hdparm -Z /dev/sdX ## this will fail --> obsolete vendor-specific command
> hdparm -I /dev/sdX ## this fails when following the above
>
> hdparm -z /dev/sdX ## force some regular I/O, to clear the bad state from the driver
> hdparm -I /dev/sdX ## this now works again


The issue also seems to be present in 2.6.32.8 on that same Intel AHCI platform,
so it probably has nothing to do with the libahci split.

Cheers
