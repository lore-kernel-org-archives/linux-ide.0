From: Mark Lord <lkml@rtr.ca>
Subject: Re: hdparm "unknown 206[12]" features and security...
Date: Wed, 09 Jan 2008 09:44:10 -0500
Message-ID: <4784DDBA.5060505@rtr.ca>
References: <6278d2220801090317g5afda292qd1a8e1a9a802a651@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:2218 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751710AbYAIOoM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 9 Jan 2008 09:44:12 -0500
In-Reply-To: <6278d2220801090317g5afda292qd1a8e1a9a802a651@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Daniel J Blueman <daniel.blueman@gmail.com>
Cc: linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jeff@garzik.org>

Daniel J Blueman wrote:
> Hi Mark,
> 
> I was looking at the features on a new 320GB 2.5" SATA2 disk and
> finding the current hdparm 7.7 doesn't recognise a couple of features
> [1]. I dumped the raw identify data [2], if it is of use.
> 
> Also, do you know what tools to use to set a drive password and unlock
> the drive at boot-time, equivalent to what various laptop BIOSes
> allow.
..

   hdparm --security-help

That code worked for me when I tested it here (libata only!!),
but it has not been widely tested/used by others.

..
>            *    SCT Data Tables (AC5)
>                 unknown 206[12]
>                 unknown 206[13]
..

Thanks.  I'll double-check the latest ATA draft spec again,
but those bits are/were defined as "vendor specific" when I
last checked.

Cheers
