From: "Carlos Pardo" <Carlos.Pardo@siliconimage.com>
Subject: RE: > 2TB storage
Date: Mon, 24 Oct 2005 10:11:14 -0700
Message-ID: <2E9B8131C44AF746B1E06BF9B15A434B045D8026@mail.siliconimage.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from siimage.com ([12.24.47.101]:34923 "EHLO mail.siimage.com")
	by vger.kernel.org with ESMTP id S1751175AbVJXRII convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 24 Oct 2005 13:08:08 -0400
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bryan O'Sullivan <bos@serpentine.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, Edward Falk <efalk@google.com>

You are correct. It is actually an SV-2000 configured as "BIG". It concatenates the disk drives to make them look like one gigantic disk. There will soon be a way to configure the SV-2000 under Linux.

C- 

-----Original Message-----
From: Bryan O'Sullivan [mailto:bos@serpentine.com]
Sent: Monday, October 24, 2005 9:43 AM
To: Carlos Pardo
Cc: Jeff Garzik; Tejun Heo; linux-ide@vger.kernel.org; Edward Falk
Subject: Re: > 2TB storage


On Mon, 2005-10-24 at 08:35 -0700, Carlos Pardo wrote:

> Has anyone tested libATA drivers using disks bigger than 2 Terabytes? I just attached what is
> essentially a 2.2 TB disk drive to a Silicon Image 3114 chipset.

Since you appear work for SiImage, was this a SteelVine SV-2000 box?
That ships configured as a port multiplier, not a fake RAID.  There are
no Linux drivers that can usefully talk to it, and no software available
for Linux to reconfigure it out of JBOD mode.  It's a Windows-only box.

	<b
