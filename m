From: <mark@harddata.com>
Subject: Re: Any recommended PATA or SATA chip for kernel 2.6.x ?
Date: Wed, 25 Feb 2004 01:02:48 -0700 (MST)
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <63068.68.151.39.198.1077696168.squirrel@www.harddata.com>
References: <004c01c3fb66$b7ba9440$9c02a8c0@southa.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 198.216-123-194-0.interbaun.com ([216.123.194.198]:27871 "EHLO
	mail.harddata.com") by vger.kernel.org with ESMTP id S262345AbUBYIDP
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 25 Feb 2004 03:03:15 -0500
In-Reply-To: <004c01c3fb66$b7ba9440$9c02a8c0@southa.com>
List-Id: linux-ide@vger.kernel.org
To: kylewong@southa.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

> Hi,
>
> I need to build a six disk IDE md raid-5 with-in a month, Is here anyone
> and recommed some PATA or SATA chip which is known to be trouble free
> and kernel 2.6.x friendly?
>

3ware Escalade Raid controllers are your best bet. They are supported in
the default kernel and provide web and command line administration tools
for linux.

> I found in the market that most PCI IDE card are using "siimage (CMD?),
> HiPoint and IT8212 chip, are they working well with 2.6.x ?

Well when considering SATA last time I checked libata (library used by
open source SATA drivers) didn't support hotswapping. So really you can't
build a proper RAID 5 array without that. Some one can correct me if
Hotswap has now been added.

Some of the proprietary drivers may support hotswap, but I really don't
know. I know we played with the SIL3112a but never tried hotswap.


