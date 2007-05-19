From: Tejun Heo <htejun@gmail.com>
Subject: Re: [Pkg-sysvinit-devel] [PATCH] libata: remove	libata.spindown_compat
Date: Sat, 19 May 2007 13:14:03 +0200
Message-ID: <464EDBFB.3050307@gmail.com>
References: <464C6A0E.7020601@gmail.com> <1179572779.23670.13.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.239]:17563 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756727AbXESLOY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 19 May 2007 07:14:24 -0400
Received: by nz-out-0506.google.com with SMTP id r28so1624931nza
        for <linux-ide@vger.kernel.org>; Sat, 19 May 2007 04:14:21 -0700 (PDT)
In-Reply-To: <1179572779.23670.13.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Miquel van Smoorenburg <miquels@cistron.nl>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Daniel Drake <dsd@gentoo.org>, Francesco Pretto <ceztko@gmail.com>, Chuck Ebbert <cebbert@redhat.com>, hmh@hmh.eng.br, pkg-sysvinit-devel@lists.alioth.debian.org, Henrique de Moraes Holschuh <hmh@debian.org>

Miquel van Smoorenburg wrote:
>> In ATA, this is achieved by issuing FLUSH CACHE followed by STANDBYNOW
>> and the IDE drivers (drivers/ide/*) have always issued the sequence
>> prior to powering off. libata uses SCSI sd driver as its high level
>> disk driver and the sd driver, unfortunately, issues only the cache
>> flush command during shutdown. This is mainly because SCSI disks can be
>> accessed by multiple initiators (hosts) and spinning down disks because
>> one initiator goes down can disturb others. Because of this
>> implementation detail, libata drivers up to kernel version 2.6.21 don't
>> issue the STANDBYNOW command before powering off.
> 
> This is not quite correct.
> 
> The reason halt(8) spins down IDE disks is that, way back when (november
> 2001 I guess, from the changelog), the IDE drivers did not flush the
> cache on poweroff. The result was that on some machines, poweroff was so
> fast that the power of the drive got turned off while it still had some
> unflushed data in the write-cache, resulting in filesystem corruption.
> This problem did not exist with SCSI, apparently.
> 
> To fix this issue, halt(8) started issueing WIN_STANDBYNOW1 (0xE0) and
> WIN_STANDBYNOW2 (0x94) ioctls before halt and poweroff, as that was more
> reliable than "flush cache" and the effect was the same.

One culprit there is that, according to the spec, STANDBYNOW doesn't
necessarily imply cache flush and AFAIK issuing STANDBYNOW to libata
devices is to avoid emergency unload.  Can you comment on this Henrique?

Would changing "the IDE drivers have always" to "recent IDE drivers
issue" be enough?

Thanks.

-- 
tejun
