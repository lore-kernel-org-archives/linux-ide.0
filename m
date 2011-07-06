From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Problem:  security locked disk and partition table read..
Date: Wed, 6 Jul 2011 12:41:03 +0100
Message-ID: <20110706124103.565cc4c6@lxorguk.ukuu.org.uk>
References: <4D366DF1.3000303@teksavvy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:52543 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752661Ab1GFLi0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 6 Jul 2011 07:38:26 -0400
In-Reply-To: <4D366DF1.3000303@teksavvy.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <kernel@teksavvy.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

> Except.. the kernel (?) sat there for a very long time trying
> (and failing) over and over and over and over and over and over
> to read sector-0 (the partition table).  Of course the reads
> each failed, and then got retried 5-times by SCSI, and then
> retried again a zillion times at a higher level.

It gets prodded by the various partition formats, the userspace hotplug
code and so on, not always for block 0.

> Why so many attempts to read the partition table???

Each partitioning format does its own requests. Normally that is fine but
in this case its bad news.

> Anyway, here's the hack I used:

Presumably we should set a per device flag of 'security locked' and fail
normal I/O to it but allow the other paths ? The 'proper' way would then
be to use the key rings and also a kernel event to poke userspace into
handling it.

Alan
