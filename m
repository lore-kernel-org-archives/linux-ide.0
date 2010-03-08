From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: ATA 4 KiB sector issues.
Date: Mon, 08 Mar 2010 15:01:06 -0500
Message-ID: <yq1pr3ea8hp.fsf@sermon.lab.mkp.net>
References: <4B947393.2050002@kernel.org> <yq1zl2ic058.fsf@sermon.lab.mkp.net>
	<4B954224.6010208@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rcsinet11.oracle.com ([148.87.113.123]:37106 "EHLO
	rcsinet11.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755598Ab0CHUDS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 8 Mar 2010 15:03:18 -0500
In-Reply-To: <4B954224.6010208@zytor.com> (H. Peter Anvin's message of "Mon,
	08 Mar 2010 10:29:56 -0800")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, Tejun Heo <tj@kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Daniel Taylor <Daniel.Taylor@wdc.com>, Jeff Garzik <jeff@garzik.org>, Mark Lord <kernel@teksavvy.com>, tytso@mit.edu, hirofumi@mail.parknet.co.jp, Andrew Morton <akpm@linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, irtiger@gmail.com, Matthew Wilcox <matthew@wil.cx>, aschnell@suse.de, knikanth@suse.de, jdelvare@suse.de, Karel Zak <kzak@redhat.com>, Jim Meyering <jim@meyering.net>

>>>>> "hpa" == H Peter Anvin <hpa@zytor.com> writes:

>> Huh, what?  My homedir is on a 4KiB LBS/PBS drive and has been for ~2
>> years.

hpa> For > 2 TiB drives with 4 KiB logical sectors and MS-DOS partition
hpa> tables, it is.

Ah, that.  Already fixed, I believe.


>> With regards to XP compatibility I don't think we should go too much
>> out of our way to accommodate it.  XP has been disowned by its master
>> and I think virtualization will take care of the rest.

hpa> I think that's is wildly optimistic, 

I don't expect XP to go away any time soon.  But do I think that the
number of fresh XP installs in combination with Linux will be fairly
limited.  And general lack of hardware enablement will eventually kill
off XP on raw metal.

I think it's ok that we have stop-gap solutions in place for
interoperability.  But I wouldn't want to waste all our resources on
designing for the past.  I'm much more interested in making sure that
single-boot Linux is doing the right thing.


>> FWIW, recent fdisk has a command line flag that will enable/disable
>> DOS compatible layout.

hpa> Yes, unfortunately it is still on by default.

I agree that this is a don't-be-broken option and I would prefer it the
other way around (I know that's the plan for the next release.  I just
hope the distributions get things right).

-- 
Martin K. Petersen	Oracle Linux Engineering
