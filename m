From: Yan Seiner <yan@seiner.com>
Subject: Re: [PATCH] SCSI: Add the SGPIO support for sata_nv.c
Date: Sun, 18 Jan 2009 05:49:58 -0800
Message-ID: <49733386.6000604@seiner.com>
References: <20061031104055.GA8898@infradead.org>	 <15F501D1A78BD343BE8F4D8DB854566B0C8DDCF5@hkemmail01.nvidia.com>	 <86802c440711062009t7e98d27fqdfb466b9843da060@mail.gmail.com> <86802c440901180120u3e60e73dm53a37b7cd9034915@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from flatoutfitness.com ([66.178.130.209]:41607 "EHLO www.seiner.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759540AbZAROiv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 18 Jan 2009 09:38:51 -0500
In-Reply-To: <86802c440901180120u3e60e73dm53a37b7cd9034915@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Peer Chen <pchen@nvidia.com>
Cc: linux-ide@vger.kernel.org

Yinghai Lu wrote:
> On Tue, Nov 6, 2007 at 8:09 PM, Yinghai Lu <yhlu.kernel@gmail.com> wrote:
>   
>> On Nov 7, 2006 1:55 AM, Peer Chen <pchen@nvidia.com> wrote:
>>     
>>> Modified and resent out the patch as attachment.
>>> Description about the patch:
>>> Add SGPIO support in sata_nv.c.
>>> SGPIO (Serial General Purpose Input Output) is a sideband serial 4-wire
>>> interface that a storage controller uses to communicate with a storage
>>> enclosure management controller, primarily to control activity and
>>> status LEDs that are located within drive bays or on a storage
>>> backplane. SGPIO is defined by [SFF8485].
>>> In this patch,we drive the LEDs to blink when read/write operation
>>> happen on SATA drives connect the corresponding ports on MCP55 board.
>>>       
I missed the start of  this thread....  Is it possible to blink the 
lights from user space?  This is very useful when trying to locate a 
dead or dying drive.   for example, /dev/sdc dies, but I have no way of 
knowing which one it is without unplugging all the cables one at a 
time.  A userspace utility that would allow me to blink a drive activity 
light would be very useful.

--Yan
