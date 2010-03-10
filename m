From: Tejun Heo <tj@kernel.org>
Subject: Re: ATA 4 KiB sector issues.
Date: Wed, 10 Mar 2010 09:20:41 +0900
Message-ID: <4B96E5D9.5070508@kernel.org>
References: <4B947393.2050002@kernel.org> <201003100046.24695.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:36221 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753648Ab0CJAVb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 9 Mar 2010 19:21:31 -0500
In-Reply-To: <201003100046.24695.arnd@arndb.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Daniel Taylor <Daniel.Taylor@wdc.com>, Jeff Garzik <jeff@garzik.org>, Mark Lord <kernel@teksavvy.com>, tytso@mit.edu, "H. Peter Anvin" <hpa@zytor.com>, hirofumi@mail.parknet.co.jp, Andrew Morton <akpm@linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, irtiger@gmail.com, Matthew Wilcox <matthew@wil.cx>, aschnell@suse.de, knikanth@suse.de, jdelvare@suse.de

On 03/10/2010 08:46 AM, Arnd Bergmann wrote:
> On Monday 08 March 2010 04:48:35 Tejun Heo wrote:
>> Unfortunately, while Windows can assume that newer releases won't
>> share the hard drive with older releases including Windows XP, Linux
>> distros can't do that.  There will be many installations where a
>> modern Linux distros share a hard drive with older releases of
>> Windows.  At this point, I can't see a silver bullet solution.
>>
>> Partitioners maybe should only align partitions which will be used by
>> Linux and default to the traditional layout for others while allowing
>> explicit override.  I think Windows XP wouldn't have problem with
>> differently aligned partitions as long as it doesn't actually use them
>> but haven't tested it.
> 
> Any idea if XP can cope with partition tables that use a 32-sector, 128-head
> geometry rather than the default 63-sector, 255-head one? That seems to
> be what some flash memory cards are using and it would make any cylinder
> aligned partition also 4096-byte aligned, at the cost of moving the
> 1024-cylinder boundary from 7.88 GiB to 2 GiB.
> 
> Do we know of anything that requires 63s/255h?

Michal Soltys pointed out that XP doesn't really depend on the legacy
layout although 2000 does (can't boot), so I guess it shouldn't be
much of a problem.

Regarding the gemetry, IIUC changing it isn't meaningful for
compatibility.  Geometry information is obtained using a BIOS call
(the int Xh thing) and the hard disk itself doesn't carry that
information , so unless you go into the BIOS set up and enter those
values manually (and I don't think you can do that on many BIOSs these
days), there's no way for anyone else to know custom geometry other
than solving equations using the CHS and LBA information in the
partition table.

So, feeding custom geometry to a partitioner which uses CHS to
determine the layout is useful to make it create partitions aligned in
certain way but as the information regarding the geometry is not
recorded anywhere, others will just keep using whatever they were
using (255*63) and figure that CHS and LBA in the partition tables
just don't match.

Thanks.

-- 
tejun
