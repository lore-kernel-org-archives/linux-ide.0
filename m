From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: Problem with Samsung SH-183A and VIA Sata Controller
Date: Thu, 1 Feb 2007 20:30:25 +0000
Message-ID: <20070201203025.707f3954@localhost.localdomain>
References: <f0b738400702011031m1d457f5fucd07b5ed4cb711f7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:46023 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422979AbXBAUSD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 1 Feb 2007 15:18:03 -0500
In-Reply-To: <f0b738400702011031m1d457f5fucd07b5ed4cb711f7@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Nils Lavesson <nils.lavesson@gmail.com>
Cc: linux-ide@vger.kernel.org, Tejun Heo <htejun@gmail.com>

> version 2.6.18, 2.6.19.1 and they give the same result. If I connect
> the drive to my SiI 3114 controller and boot 2.6.20-rc6 the drive
> works perfectly.

Very interesting it is tied to the controller, but that fits what Tejun
was seeing.

> I also tried booting kernel version 2.6.17. It gives an error message
> and stalls for a while during boot, but the drive is working somewhat.
> I managed to read the contents of a cd a few days ago, but when I
> tried the same thing today my computer hung half way through. I
> haven't been able to play dvds.
> 
> Any ideas?

I posted a patch to the IDE list yesterday for testing which performs the
workarounds the old IDE layer does for this. I'll forward you a copy
