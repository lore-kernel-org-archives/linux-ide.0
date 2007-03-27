From: linux@horizon.com
Subject: Re: Why is NCQ enabled by default by libata? (2.6.20)
Date: 27 Mar 2007 12:58:02 -0400
Message-ID: <20070327165802.13160.qmail@science.horizon.com>
References: <Pine.LNX.4.64.0703271242580.5965@p34.internal.lan>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from science.horizon.com ([192.35.100.1]:13587 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S933306AbXC0Q6F (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Mar 2007 12:58:05 -0400
In-Reply-To: <Pine.LNX.4.64.0703271242580.5965@p34.internal.lan>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jpiszcz@lucidpixels.com, linux@horizon.com
Cc: htejun@gmail.com, jeff@garzik.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

> I meant you do not allocate the entire disk per raidset, which may alter 
> performance numbers.

No, that would be silly.  It does lower the average performance of the
large RAID-5 area, but I don't know how ext3fs is allocating the blocks
anyway, so

> 04:00.0 RAID bus controller: Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller (rev 01)
> I assume you mean 3132 right?

Yes; did I mistype?

02:00.0 Mass storage controller: Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller (rev 01)
03:00.0 Mass storage controller: Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller (rev 01)
04:00.0 Mass storage controller: Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller (rev 01)

> I also have 6 seagates, I'd need to run one 
> of these tests on them as well, also you took the micro jumper off the 
> Seagate 400s in the back as well right?

Um... no, I don't remember doing anything like that.  What micro jumper?
It's been a while, but I just double-checked the drive manual and
it doesn't mention any jumpers.
