From: "Morrison, Tom" <tmorrison@empirix.com>
Subject: RE: Responding to 2 thread <2.6.23.8 - Hang with sata_mv (7042)...> AND  <Bug: get EXT3-fs error Allocating block in system zone>
Date: Tue, 11 Dec 2007 12:53:07 -0500
Message-ID: <BD261180E6D35F4D9D32F3E44FD3D9010AFF29AC@EMPBEDEX.empirix.com>
References: <BD261180E6D35F4D9D32F3E44FD3D901053E84BD@EMPBEDEX.empirix.com> <45ED682A.9040408@garzik.org> <BD261180E6D35F4D9D32F3E44FD3D9010A7E1B45@EMPBEDEX.empirix.com> <4728A816.8020608@garzik.org> <BD261180E6D35F4D9D32F3E44FD3D9010AAE852F@EMPBEDEX.empirix.com> <473B36D7.8000205@rtr.ca> <BD261180E6D35F4D9D32F3E44FD3D9010AAE8585@EMPBEDEX.empirix.com> <473B44CB.6010209@rtr.ca> <BD261180E6D35F4D9D32F3E44FD3D9010AAE89CA@EMPBEDEX.empirix.com> <473B76E0.7010500@rtr.ca> <BD261180E6D35F4D9D32F3E44FD3D9010AAE911D@EMPBEDEX.empirix.com> <473C7625.2040300@rtr.ca> <BD261180E6D35F4D9D32F3E44FD3D9010AB2CFF0@EMPBEDEX.empirix.com> <473CC4B8.4090607@rtr.ca> <BD261180E6D35F4D9D32F3E44FD3D9010AEF6982@EMPBEDEX.empirix.com> <475D6CC3.2080400@rtr.ca> <BD261180E6D35F4D9D32F3E44FD3D9010AFF2936@EMPBEDEX.empirix.c
 om> <475ECBF5.4050205@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [12.38.203.54] ([12.38.203.54]:36356 "EHLO
	empbedex1.empirix.com" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1751940AbXLKRxN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Dec 2007 12:53:13 -0500
Content-class: urn:content-classes:message
In-Reply-To: <475ECBF5.4050205@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, Tejun Heo <htejun@gmail.com>, hp@syntomax.com

Correct, it has a flat memory map 0-0xFFFFFFFF

I don't make this stuff up and I checked it 3 times 
(with & without this set (#if 0 & #if 1) - just to make 
sure I don't have something else weird going on...

I'll send you privately my sata_mv.c - so you can inspect
that yourself (only custom thing is the EDMA buffers hi/low
buffers are set to point to the physical PCI space which is 
way up in 0xC_xxxx_xxxx space...

tom


-----Original Message-----
From: Mark Lord [mailto:liml@rtr.ca] 
Sent: Tuesday, December 11, 2007 12:42 PM
To: Morrison, Tom
Cc: Jeff Garzik; linux-ide@vger.kernel.org; Tejun Heo; hp@syntomax.com
Subject: Re: Responding to 2 thread <2.6.23.8 - Hang with sata_mv
(7042)...> AND <Bug: get EXT3-fs error Allocating block in system zone>

Morrison, Tom wrote:
>> <snip results that worked>
>> That's a bit strange, actually.. because you said that this system
>>does not have any RAM at any addresses above 0xffffffff.
>> The physical RAM in this system is supposedly from 0 - 0xffffffff
(4Gbytes).

<snip original question>
