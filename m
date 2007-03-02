From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: Cable detection fixes
Date: Fri, 2 Mar 2007 12:52:26 +0000
Message-ID: <20070302125226.6642c29f@lxorguk.ukuu.org.uk>
References: <20070301173003.5d5ab4a6@lxorguk.ukuu.org.uk>
	<Pine.LNX.4.64.0703011723270.12485@woody.linux-foundation.org>
	<45E77EDD.3010205@garzik.org>
	<20070302063507.GA8345@ellpspace.math.ualberta.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:56411 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1423037AbXCBLs0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Mar 2007 06:48:26 -0500
In-Reply-To: <20070302063507.GA8345@ellpspace.math.ualberta.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: michal@harddata.com
Cc: Jeff Garzik <jeff@garzik.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org

> Hm, I got recently hands on a hardware where 2.6.21-rc1 based
> kernels from Fedora rawhide simply do not boot as there is no
> way to get to disks.  I would not mind some change in behavior
> although so far I can boot at least some earlier kernels.

Doesn't look related at all. Looks like the box you have has chronic IRQ
routing problems.

Alan
