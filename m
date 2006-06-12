From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 06/10] libata: implement new Power Management framework
Date: Mon, 12 Jun 2006 17:34:58 +0100
Message-ID: <1150130098.25462.10.camel@localhost.localdomain>
References: <11501274293403-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:31912 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751172AbWFLQUn (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 12 Jun 2006 12:20:43 -0400
In-Reply-To: <11501274293403-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jgarzik@pobox.com, lkml@rtr.ca, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org

Ar Maw, 2006-06-13 am 00:50 +0900, ysgrifennodd Tejun Heo:
> Suspend is performed parallely on all ports of a host_set and resume
> is done parallely in background to decrease the time necessary before
> responding to user.

Do we need a disk count here - some large disk setups rely on the fact
drives don't all spin up at once to avoid overloading the PSU ?

Something like four disk spinups at a time ought to avoid biting anyone
too badly and would mean normal users saw a parallel spinup.

Alan
