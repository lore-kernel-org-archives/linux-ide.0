From: Andrew Cooks <acooks@gmail.com>
Subject: Re: [Bug 42679] New: DMA Read on Marvell 88SE9128 fails when Intel's IOMMU is on
Date: Fri, 11 May 2012 09:18:05 +0000 (UTC)
Message-ID: <loom.20120511T103733-249@post.gmane.org>
References: <bug-42679-27@https.bugzilla.kernel.org/> <20120130125934.7971c815.akpm@linux-foundation.org> <4F270E8C.2000406@redhat.com> <op.v8w3z0z0c3q55a@localhost> <20120130233211.GM24091@sequoia.sous-sol.org> <op.v8w77qlcc3q55a@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:55581 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752864Ab2EKJUG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 11 May 2012 05:20:06 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-ide@m.gmane.org>)
	id 1SSm15-00056Q-F4
	for linux-ide@vger.kernel.org; Fri, 11 May 2012 11:20:04 +0200
Received: from gw.mrxtech.com.au ([202.72.132.202])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Fri, 11 May 2012 11:20:03 +0200
Received: from acooks by gw.mrxtech.com.au with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Fri, 11 May 2012 11:20:03 +0200
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


On Tue, 31 Jan 2012, Chris Wright <chrisw <at> sous-sol.org> wrote:
>> >Well, the lspci dump in the bugzilla report doesn't show a device
>> >w/BDF=0b:00.1;
>> >so, if the SATA device (which is 0b:00.0) is spitting out 0b:00.1
>> >as the source
>> >of any of its DMA packets, the IOMMU will fault on it, since
>> >0b:00.1 didn't
>> >request DMA mappings (0b:00.0 did).
>> >I semi-recall someone else reporting this 'feature' on this list.
>> >Wonder if pci-quirk has to filter this case (0b:00.0 on this system  
>> means
>> >map for 0b:00.0 & 0b:00.1 -- ick!)
>> >

It would seem that there are multiple Marvell 88SE91xx controllers that use
xx:00.0 and xx:00.1 and only report xx:00.0. I've got the same issue on a
88SE9172 and can't simply move to a different controller without buying more
hardware. Besides, this should work ;)

Is this an issue of a missing entry in some ACPI table?

It's been suggested that a pci-quirk could handle this by mapping both the .0
and .1 entry when the .0 shows up, but what isn't clear to me is where this
should be done. Is it a case of setting the "present" bit for an existing
context entry, or adding an additional context entry?

AC.

