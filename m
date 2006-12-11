From: Tejun Heo <htejun@gmail.com>
Subject: Re: Seagate ST3808110AS and Sil3114 RAID1 trouble.
Date: Mon, 11 Dec 2006 18:21:11 +0900
Message-ID: <457D2307.7060301@gmail.com>
References: <457D1F0F.20204@tin.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.230]:6730 "EHLO
	nz-out-0102.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760362AbWLKJVR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 11 Dec 2006 04:21:17 -0500
Received: by nz-out-0102.google.com with SMTP id s1so753724nze
        for <linux-ide@vger.kernel.org>; Mon, 11 Dec 2006 01:21:17 -0800 (PST)
In-Reply-To: <457D1F0F.20204@tin.it>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mauro Ziliani <mauro.ziliani@tin.it>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Mauro Ziliani wrote:
> Dec 11 00:47:27 mercurio kernel: ata1.00: exception Emask 0x0 SAct 0x0
> SErr 0x280000 action 0x0
> Dec 11 00:47:27 mercurio kernel: ata1.00: (BMDMA stat 0x60)
> Dec 11 00:47:27 mercurio kernel: ata1.00: tag 0 cmd 0x25 Emask 0x1 stat
> 0x51 err 0x4 (device error)
> Dec 11 00:47:27 mercurio kernel: ata1: EH complete

What's the kernel version?  Your drive is reporting errors on reads and
writes.

> Why this happens?

Possibly dying device.

> I control the disk with PowerMax 4.23 and the disk works fine.
> All test are ok.

I dunno what PowerMax tests for.  Can you please the result of 'smartctl
-d ata -a /dev/sdX'?

> Is it better to make the RAID1 throught Sill3114 BIOS or throught
> software md?

Doesn't really matter.  All are software raid anyway.  If you wanna use
BIOS raid, you gotta setup dm raid which goes along with it.

-- 
tejun
