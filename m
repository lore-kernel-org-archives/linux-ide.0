From: "Daniel Taylor" <Daniel.Taylor@wdc.com>
Subject: RE: ATA 4 KiB sector issues.
Date: Tue, 9 Mar 2010 14:36:25 -0800
Message-ID: <3E0C3AE547FA504DA5E89EA5A24AC85803E2BD7A@wdscexbe01.sc.wdc.com>
References: <4B94ACE8.4060400@zytor.com> (H. Peter Anvin's message of "Sun,07 Mar 2010 23:53:12 -0800") <yq1r5nubze0.fsf@sermon.lab.mkp.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wdscspam2.wdc.com ([129.253.170.131]:22838 "EHLO
	wdscspam2.wdc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751155Ab0CIWg0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 9 Mar 2010 17:36:26 -0500
Content-class: urn:content-classes:message
In-Reply-To: <yq1r5nubze0.fsf@sermon.lab.mkp.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Martin K. Petersen" <martin.petersen@oracle.com>, "H. Peter Anvin" <hpa@zytor.com>
Cc: James Bottomley <James.Bottomley@suse.de>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>, Mark Lord <kernel@teksavvy.com>, tytso@mit.edu, hirofumi@mail.parknet.co.jp, Andrew Morton <akpm@linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, irtiger@gmail.com, Matthew Wilcox <matthew@wil.cx>, aschnell@suse.de, knikanth@suse.de, jdelvare@suse.de

 
hpa> I would very much like a reference for a platform which has 
hpa> firmware which can successfully boot from 4K-logical media.  It 
hpa> would be very useful for bootloader testing.


I am told that the Mac UEFI platform will boot from 4K logical/physical
drives.

Now I have to scrounge one of the old drives to test it.
