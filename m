From: Tejun Heo <htejun@gmail.com>
Subject: Re: 2.6.23-rc7 - _random_ IRQ23 : nobody cared
Date: Fri, 28 Sep 2007 02:55:32 -0700
Message-ID: <46FCCF94.9060400@gmail.com>
References: <20070924083336.7a08fd61@tux.DEF.witbe.net>	<46F7C933.4080003@davidnewall.com>	<20070925090057.5778aa2a@tux.DEF.witbe.net>	<46FAFF7A.5070208@gmail.com> <20070927080551.424e90b9@tux.DEF.witbe.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.229]:42383 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756323AbXI1J5O (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 28 Sep 2007 05:57:14 -0400
Received: by nz-out-0506.google.com with SMTP id s18so1982737nze
        for <linux-ide@vger.kernel.org>; Fri, 28 Sep 2007 02:57:12 -0700 (PDT)
In-Reply-To: <20070927080551.424e90b9@tux.DEF.witbe.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Paul Rolland <rol@as2917.net>
Cc: David Newall <david@davidnewall.com>, Linux Kernel <linux-kernel@vger.kernel.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, rol@witbe.net

Paul Rolland wrote:
>> Can you change driver load order such that the driver for the modem is
>> loaded first?
> 
> As I said, it's not possible, because :
>  - the modem driver is an out-kernel one, so I have to wait the end of the
>    boot process so that it can be loaded,
>  - libata on IRQ23 is the one taking care of my disks, and I suspect it 
>    quite hard to install a modem driver before having the disk driver
>    installed.

You can do both by...

1. Build the modem driver into the kernel.  char drivers are linked in
before ATA ones, so it will attach first.

2. Using a custom initrd with emergency shell.  initrd is loaded by BIOS
so no driver is involved.  I don't actually know how to do this tho.

3. Put in an extra disk controller and boot from it with both drivers
compiled as module.

-- 
tejun
