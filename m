From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 0/3] hotplug polling, respin
Date: Wed, 25 Apr 2007 16:08:09 +0900
Message-ID: <462EFE59.2090501@gmail.com>
References: <20070425062538.GU7810@curie-int.orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.180]:56357 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423239AbXDYHIP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Apr 2007 03:08:15 -0400
Received: by py-out-1112.google.com with SMTP id a29so110349pyi
        for <linux-ide@vger.kernel.org>; Wed, 25 Apr 2007 00:08:15 -0700 (PDT)
In-Reply-To: <20070425062538.GU7810@curie-int.orbis-terrarum.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Jeff Garzik <jgarzik@pobox.com>

[cc'ing Jeff]

Robin H. Johnson wrote:
> I've been (very) slowly working on re-spinning Tejun's PMP work.
> 
> As the very first in the body of work, here is the patchset to implement
> hotplug polling.
> 
> The last submission of this
> (http://thread.gmane.org/gmane.linux.ide/13467) already had a tentative
> ACK, pending a link power-saving patchset, that I can't find more
> details on.

Yeap, the implementation is ACKed but interface to userland is NACKed.
We need sysfs nodes for ATA devices to do userland interface properly.
I'm working hard to get there.

Thanks a lot for taking care of these patches.  A lot of people have
been asking for patches for newer kernels and I couldn't find time to
update them.

Jeff, can we make a page for PMP patches in linux-ata.org?  It would be
a much better place to direct people to.

Thanks.

-- 
tejun
