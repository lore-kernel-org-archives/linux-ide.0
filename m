From: Justin Piszcz <jpiszcz@lucidpixels.com>
Subject: Re: Why is NCQ enabled by default by libata? (2.6.20)
Date: Tue, 27 Mar 2007 13:03:02 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0703271302160.5965@p34.internal.lan>
References: <20070327165802.13160.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lucidpixels.com ([75.144.35.66]:59604 "EHLO lucidpixels.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933688AbXC0RDE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 27 Mar 2007 13:03:04 -0400
In-Reply-To: <20070327165802.13160.qmail@science.horizon.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux@horizon.com
Cc: htejun@gmail.com, jeff@garzik.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org



On Tue, 27 Mar 2007, linux@horizon.com wrote:

>> I meant you do not allocate the entire disk per raidset, which may alter
>> performance numbers.
>
> No, that would be silly.  It does lower the average performance of the
> large RAID-5 area, but I don't know how ext3fs is allocating the blocks
> anyway, so
>
>> 04:00.0 RAID bus controller: Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller (rev 01)
>> I assume you mean 3132 right?
>
> Yes; did I mistype?
>
> 02:00.0 Mass storage controller: Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller (rev 01)
> 03:00.0 Mass storage controller: Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller (rev 01)
> 04:00.0 Mass storage controller: Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller (rev 01)
>
>> I also have 6 seagates, I'd need to run one
>> of these tests on them as well, also you took the micro jumper off the
>> Seagate 400s in the back as well right?
>
> Um... no, I don't remember doing anything like that.  What micro jumper?
> It's been a while, but I just double-checked the drive manual and
> it doesn't mention any jumpers.
>

The 7200.8's don't use a jumper except for "factory use" - the 7200.9s and 
10s I believe have a jumper in the back to enable/disable 3.0GBps 
operation.  Your model # corresponds with a 7200.8, so nevermind about the 
jumper.

Justin.
