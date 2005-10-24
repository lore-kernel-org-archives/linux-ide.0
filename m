From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: > 2TB storage
Date: Mon, 24 Oct 2005 08:53:47 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0510240851490.29876@shark.he.net>
References: <2E9B8131C44AF746B1E06BF9B15A434B088E37B7@mail.siliconimage.com>
 <435D0268.7060907@pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:14807 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751116AbVJXPxs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 24 Oct 2005 11:53:48 -0400
Received: from shark.he.net ([66.160.160.2]) by xenotime.net for <linux-ide@vger.kernel.org>; Mon, 24 Oct 2005 08:53:47 -0700
In-Reply-To: <435D0268.7060907@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Carlos Pardo <Carlos.Pardo@siliconimage.com>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, Edward Falk <efalk@google.com>

On Mon, 24 Oct 2005, Jeff Garzik wrote:

> Carlos Pardo wrote:
> > To everyone,
> >
> > Has anyone tested libATA drivers using disks bigger than 2 Terabytes? I just attached what is
> > essentially a 2.2 TB disk drive to a Silicon Image 3114 chipset. It reported around 300 Megabytes
> > instead of the expected 2200 Megabytes. How is the disk geometry determined ? Is it done by
> > reading the IDENTIFY data or by accessing the BIOS ? Thanks in advance for any feedback.
>
> We read IDENTIFY DEVICE data directly, and use that...
>
> Make sure you have CONFIG_LBD turned on, as Randy mentioned.  There may
> be other factors at play here too that I'm not seeing...

With CONFIG_LBD=n and drive size near max 32-bit value,
there is a drive size calculation overflow error.
That's (another) reason that I asked for precise message logs.

It only affects the reported size (in the message log).
James has a fix for it.

-- 
~Randy
