From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: > 2TB storage
Date: Mon, 24 Oct 2005 11:48:56 -0400
Message-ID: <435D0268.7060907@pobox.com>
References: <2E9B8131C44AF746B1E06BF9B15A434B088E37B7@mail.siliconimage.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:7113 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751103AbVJXPtE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 24 Oct 2005 11:49:04 -0400
In-Reply-To: <2E9B8131C44AF746B1E06BF9B15A434B088E37B7@mail.siliconimage.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Carlos Pardo <Carlos.Pardo@siliconimage.com>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, Edward Falk <efalk@google.com>

Carlos Pardo wrote:
> To everyone,
> 
> Has anyone tested libATA drivers using disks bigger than 2 Terabytes? I just attached what is
> essentially a 2.2 TB disk drive to a Silicon Image 3114 chipset. It reported around 300 Megabytes
> instead of the expected 2200 Megabytes. How is the disk geometry determined ? Is it done by 
> reading the IDENTIFY data or by accessing the BIOS ? Thanks in advance for any feedback.  

We read IDENTIFY DEVICE data directly, and use that...

Make sure you have CONFIG_LBD turned on, as Randy mentioned.  There may 
be other factors at play here too that I'm not seeing...

	Jeff


