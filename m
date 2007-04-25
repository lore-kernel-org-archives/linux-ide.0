From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 0/3] hotplug polling, respin
Date: Wed, 25 Apr 2007 16:35:25 +0900
Message-ID: <462F04BD.3040706@gmail.com>
References: <20070425062538.GU7810@curie-int.orbis-terrarum.net> <462EFE59.2090501@gmail.com> <20070425073037.GF7846@curie-int.orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.177]:13430 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423278AbXDYHfe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Apr 2007 03:35:34 -0400
Received: by py-out-1112.google.com with SMTP id a29so115570pyi
        for <linux-ide@vger.kernel.org>; Wed, 25 Apr 2007 00:35:34 -0700 (PDT)
In-Reply-To: <20070425073037.GF7846@curie-int.orbis-terrarum.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Robin H. Johnson" <robbat2@gentoo.org>
Cc: linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>

Robin H. Johnson wrote:
> On Wed, Apr 25, 2007 at 04:08:09PM +0900, Tejun Heo wrote:
>>> The last submission of this
>>> (http://thread.gmane.org/gmane.linux.ide/13467) already had a tentative
>>> ACK, pending a link power-saving patchset, that I can't find more
>>> details on.
>> Yeap, the implementation is ACKed but interface to userland is NACKed.
>> We need sysfs nodes for ATA devices to do userland interface properly.
>> I'm working hard to get there.
> I'm not sure I follow you here. The only bit of 'userspace' interface I
> see in this series is hotplug_polling_interval. What other userspace
> bits are in question?

What got NACKed is the lack of per-port interface.  More specifically,
stretching the usage of module parameter too far.

>> Thanks a lot for taking care of these patches.  A lot of people have
>> been asking for patches for newer kernels and I couldn't find time to
>> update them.
> As always, it starts with scratching your own itch. My Fusion 500P works
> like a charm with the SIL 3132 that I have - the previous scanning issue
> where it took forever doing 15 scans (1;1,2;1,2,3;1,2,3,4;1,2,3,4,5)
> instead of just 5 seems to have gone away, but the sluggish performance
> remains (the sil24 seeming to not do SATA2 speed stuff, did you hear
> back from SIL?).

Nope.

> As a gauge of interest in the PMP stuff, I'm presently getting about 3
> emails a week asking for work on it.
> 
>> Jeff, can we make a page for PMP patches in linux-ata.org?  It would be
>> a much better place to direct people to.
> I'd host a git tree, but I don't have sufficient stable bandwidth.

We can host the git tree at kernel.org.  I can get a tree setup there
and pull from you.

-- 
tejun
