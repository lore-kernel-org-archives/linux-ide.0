From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Linux SATA RAID FAQ
Date: Sat, 14 Aug 2004 16:21:53 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1092496912.27156.6.camel@localhost.localdomain>
References: <411B0F45.8070500@pobox.com>
	 <20040812113413.GA19252@alpha.home.local>  <411D5D70.9070909@clanhk.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from the-village.bc.nu ([81.2.110.252]:15323 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S263775AbUHNQYQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 14 Aug 2004 12:24:16 -0400
In-Reply-To: <411D5D70.9070909@clanhk.org>
List-Id: linux-ide@vger.kernel.org
To: "J. Ryan Earl" <heretic@clanhk.org>
Cc: Willy Tarreau <willy@w.ods.org>, Jeff Garzik <jgarzik@pobox.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On Sad, 2004-08-14 at 01:31, J. Ryan Earl wrote:
> On the brightside, md raid5 is often faster than hardware raid5.  At 
> least on the 7000 and 8000 series of 3ware hardware; the 9000 series 
> looks promising though.  I haven't seen megaraid SATA numbers, and I 
> don't know what happened to the SX8.

Be cautious what you measure. One of he problems until you reach PCI-X
is PCI bandwidth. Thus software md5 can look good but the moment its
combined with other PCI activity goes down the pan entirely.

> When the libata Marvell drivers come out, you'll have a cheap upgrade 
> path for PCI-X boards if you want fast md raid: 

Agreed. PCI-X will change a lot of this for boxes that are not very
cpu/memory limited.
