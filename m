From: Bryan O'Sullivan <bos@serpentine.com>
Subject: Re: > 2TB storage
Date: Mon, 24 Oct 2005 09:43:01 -0700
Message-ID: <1130172181.15542.4.camel@camp4.serpentine.com>
References: <2E9B8131C44AF746B1E06BF9B15A434B088E37B7@mail.siliconimage.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hierophant.serpentine.com ([66.92.13.71]:54236 "EHLO
	demesne.serpentine.com") by vger.kernel.org with ESMTP
	id S1751147AbVJXQnF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 24 Oct 2005 12:43:05 -0400
In-Reply-To: <2E9B8131C44AF746B1E06BF9B15A434B088E37B7@mail.siliconimage.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Carlos Pardo <Carlos.Pardo@siliconimage.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, Edward Falk <efalk@google.com>

On Mon, 2005-10-24 at 08:35 -0700, Carlos Pardo wrote:

> Has anyone tested libATA drivers using disks bigger than 2 Terabytes? I just attached what is
> essentially a 2.2 TB disk drive to a Silicon Image 3114 chipset.

Since you appear work for SiImage, was this a SteelVine SV-2000 box?
That ships configured as a port multiplier, not a fake RAID.  There are
no Linux drivers that can usefully talk to it, and no software available
for Linux to reconfigure it out of JBOD mode.  It's a Windows-only box.

	<b

