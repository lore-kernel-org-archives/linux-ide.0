From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: What determines which interrupts are shared under Linux?
Date: Tue, 15 Aug 2006 19:13:01 +0100
Message-ID: <1155665581.24077.302.camel@localhost.localdomain>
References: <44E1D760.6070600@atipa.com>
	 <1155654379.24077.286.camel@localhost.localdomain>
	 <44E1E719.6020005@atipa.com>
	 <1155657316.24077.293.camel@localhost.localdomain>
	 <44E208AD.8060505@atipa.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:50569 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030346AbWHORw2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 15 Aug 2006 13:52:28 -0400
In-Reply-To: <44E208AD.8060505@atipa.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Roger Heflin <rheflin@atipa.com>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

Ar Maw, 2006-08-15 am 12:47 -0500, ysgrifennodd Roger Heflin:
> On the specific kernel that I have I appear to have both IDE and
> sata_nv drivers, is there a way to force things to use sata_nv/libata
> rather than the older ide driver for the NVIDIA sata controller?

You can build 2.6.18-mm like that (say N to AMD/NVIDIA PATA driver, y to
sata_nv and pata_amd libata drivers). Still have to figure out why your
MPT fusion is slow but if its still slow in 2.6.18-mm then it needs
figuring out anyway

