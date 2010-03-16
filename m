From: Tejun Heo <tj@kernel.org>
Subject: Re: ATA 4 KiB sector issues.
Date: Tue, 16 Mar 2010 15:22:00 +0900
Message-ID: <4B9F2388.2030803@kernel.org>
References: <4B947393.2050002@kernel.org> <201003100046.24695.arnd@arndb.de>	 <1158166a1003100114j6ea329fbh84bfad65dcac90bf@mail.gmail.com>	 <4B9EED55.10201@kernel.org> <1268720060.21384.10.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:39881 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965305Ab0CPGWa (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 16 Mar 2010 02:22:30 -0400
In-Reply-To: <1268720060.21384.10.camel@mulgrave.site>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: James Bottomley <James.Bottomley@suse.de>
Cc: Denys Vlasenko <vda.linux@googlemail.com>, Arnd Bergmann <arnd@arndb.de>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Daniel Taylor <Daniel.Taylor@wdc.com>, Jeff Garzik <jeff@garzik.org>, Mark Lord <kernel@teksavvy.com>, tytso@mit.edu, "H. Peter Anvin" <hpa@zytor.com>, hirofumi@mail.parknet.co.jp, Andrew Morton <akpm@linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, irtiger@gmail.com, Matthew Wilcox <matthew@wil.cx>, aschnell@suse.de, knikanth@suse.de, jdelvare@suse.de

Hello, James.

On 03/16/2010 03:14 PM, James Bottomley wrote:
> So, it is true to say that picking a certain H/S geometry (which is
> entirely withing the gift of the partitioner) will align msdos label
> partitions, but will be don't care for all other labels: all other
> partition labels (like gpt) use block as offset and don't have any truck
> with the fictitious C/H/S stuff.

For any modern Linux and Windows, CHS simply doesn't matter.  They
don't look at it at all.

> The big problem is that 99% of the x86 systems out there still use the
> ancient msdos label for their boot disks, so aligning H/S going forwards
> will give us a nice "just works" for x86 boxes.

What I don't get is that how picking up a custom geometry can make
things work when there is *no* reliable way to determine which
geometry was used during partitioning once the partitioning is
complete.  Most BIOSs these days will simply report the geometry as
being 255/63 regardless of the geometry used during partitioning.  So,
how can using a custom geometry give that nice "just works" for x86
boxes when nobody knows what geometry is in use?

Thanks.

-- 
tejun
