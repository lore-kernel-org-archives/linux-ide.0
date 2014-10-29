From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [RFC PATCH 1/5] block, ioprio: include caching advice via ionice
Date: Wed, 29 Oct 2014 15:02:42 -0400
Message-ID: <x49bnoupulp.fsf@segfault.boston.devel.redhat.com>
References: <20141029180454.4879.75088.stgit@stg-AndroidDev-VirtualBox>
	<20141029182345.4879.98373.stgit@stg-AndroidDev-VirtualBox>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40784 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756619AbaJ2TCs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 29 Oct 2014 15:02:48 -0400
In-Reply-To: <20141029182345.4879.98373.stgit@stg-AndroidDev-VirtualBox>
	(Jason B. Akers's message of "Wed, 29 Oct 2014 11:23:45 -0700")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Jason B. Akers" <jason.b.akers@intel.com>
Cc: linux-ide@vger.kernel.org, axboe@fb.com, kapil.karkra@intel.com, dan.j.williams@intel.com, linux-kernel@vger.kernel.org

"Jason B. Akers" <jason.b.akers@intel.com> writes:

> From: Dan Williams <dan.j.williams@intel.com>
>
> Steal one unused bit from the priority class and two bits from the
> priority data, to implement a 3 bit cache-advice field.  Similar to the
> page cache advice from fadvise() these hints are meant to be consumed
> by hybrid drives.  Solid State Hyrbid-Drives, as defined by the SATA-IO
> Specification, implement up to a 4-bit cache priority that can be
> specified along with a FPDMA command.

ionice is about setting an I/O scheduling class for a *process*.  So,
unless I've missed something, this does not seem like the right
interface for passing I/O hints.

You mention fadvise hints, which sounds like a good fit (and madvise
would be equally interesting), but I don't see where you've wired them
up in this patch set.  Did I miss it?

Cheers,
Jeff
