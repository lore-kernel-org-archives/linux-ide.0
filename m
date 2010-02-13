From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] ahci: disable FPDMA auto-activate optimization on NVIDIA
 	AHCI
Date: Sat, 13 Feb 2010 18:02:12 -0500
Message-ID: <4B772F74.1030509@garzik.org>
References: <4B5FC213.1060601@gmail.com> <4B772BE2.30108@garzik.org> <51f3faa71002131453m4dd2b82cgd8b874866146da60@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yx0-f196.google.com ([209.85.210.196]:62147 "EHLO
	mail-yx0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752527Ab0BMXCO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 13 Feb 2010 18:02:14 -0500
In-Reply-To: <51f3faa71002131453m4dd2b82cgd8b874866146da60@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, ide <linux-ide@vger.kernel.org>, Mike Cui <cuicui@gmail.com>, Peer Chen <pchen@nvidia.com>, Allen Martin <AMartin@nvidia.com>

On 02/13/2010 05:53 PM, Robert Hancock wrote:
> On Sat, Feb 13, 2010 at 4:46 PM, Jeff Garzik<jeff@garzik.org>  wrote:
>> On 01/26/2010 11:33 PM, Robert Hancock wrote:
>>>
>>> Mike Cui reported that his system with an NVIDIA MCP79 (aka MCP7A) chipset
>>> stopped working with 2.6.32. The problem appears to be that 2.6.32 now
>>> enables
>>> the FPDMA auto-activate optimization in the ahci driver. The drive works
>>> fine
>>> with this enabled on an Intel AHCI so this appears to be a chipset bug.
>>> Since MCP79 is a fairly recent NVIDIA chipset and we don't have any info
>>> on
>>> whether any other NVIDIA chipsets have this issue, disable FPDMA AA
>>> optimization
>>> on all NVIDIA AHCI controllers for now.
>>>
>>> Should address http://bugzilla.kernel.org/show_bug.cgi?id=14922
>>>
>>> Signed-off-by: Robert Hancock<hancockrwd@gmail.com>
>>>
>>> ---
>>>
>>> Mike, can you test this out and make sure this resolves the problem for
>>> you?
>>
>> Sigh...   we never did hear back from Mike or NVIDIA on this one, did we?
>>   I've been watching for a response, and haven't seen one to date.
>
> No, I haven't seen a response. It's pretty apparent it should fix the
> problem based on earlier testing, but it would be nice to find out for
> sure which chipsets this affects.

Yep, that's my main concern...  being overly aggressive and zapping it 
on all NVIDIA chipsets, even future ones.

	Jeff




