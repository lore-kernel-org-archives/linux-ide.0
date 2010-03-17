From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: ATA 4 KiB sector issues.
Date: Tue, 16 Mar 2010 23:48:32 -0700
Message-ID: <4BA07B40.9090400@zytor.com>
References: <4B947393.2050002@kernel.org> <201003100046.24695.arnd@arndb.de>	 <1158166a1003100114j6ea329fbh84bfad65dcac90bf@mail.gmail.com>	 <4B9EED55.10201@kernel.org> <1268720060.21384.10.camel@mulgrave.site>	 <4B9F2388.2030803@kernel.org> <1268745897.21384.14.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:41516 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751981Ab0CQGtM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 17 Mar 2010 02:49:12 -0400
In-Reply-To: <1268745897.21384.14.camel@mulgrave.site>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: James Bottomley <James.Bottomley@suse.de>
Cc: Tejun Heo <tj@kernel.org>, Denys Vlasenko <vda.linux@googlemail.com>, Arnd Bergmann <arnd@arndb.de>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Daniel Taylor <Daniel.Taylor@wdc.com>, Jeff Garzik <jeff@garzik.org>, Mark Lord <kernel@teksavvy.com>, tytso@mit.edu, hirofumi@mail.parknet.co.jp, Andrew Morton <akpm@linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, irtiger@gmail.com, Matthew Wilcox <matthew@wil.cx>, aschnell@suse.de, knikanth@suse.de, jdelvare@suse.de

On 03/16/2010 06:24 AM, James Bottomley wrote:
>
> Because the msdos label can only partition in units of cylinders.  If
> you're using an msdos label, picking the right H/S gets you alignment.
>

This is doubly false.

An MS-DOS partition table can partition at any boundary.  Some OSes 
(like some versions of MS-DOS) needed track alignment because their boot 
loaders did not support crossing track boundaries.

Second, the primary field in the (modern) MS-DOS partition table is an 
LBA field.  The CHS fields are largely historic and useless because of 
the 1024-cylinder limitation, and by only being 24 bits total.

	-hpa
