From: Jeff Garzik <jeff@garzik.org>
Subject: Re: PATA drivers queued for 2.6.19
Date: Mon, 04 Sep 2006 08:12:28 -0400
Message-ID: <44FC182C.7090008@garzik.org>
References: <44FC0779.9030405@garzik.org> <po4of2pnhpc0325kqj2hd37b7eh3epcdsm@4ax.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:20354 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750873AbWIDMMb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Sep 2006 08:12:31 -0400
In-Reply-To: <po4of2pnhpc0325kqj2hd37b7eh3epcdsm@4ax.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Grant Coady <gcoady.lk@gmail.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>

Grant Coady wrote:
> I can't see an easy way to arrange multi-boot with different /etc/fstab 
> depending if I'm trying /dev/hdaX or /dev/sdaX.  Parallel '/' partitions?

That's actually pretty darn easy, with a modern distro.  Use filesystem 
labels, and LABEL= in your /etc/fstab.

The LABEL= feature allowed me to bounce between drivers/ide and libata a 
dozen times a day, when I was doing the initial libata development.

	Jeff



-- 
VGER BF report: H 3.84798e-12
