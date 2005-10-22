From: Mark Lord <mlord@pobox.com>
Subject: Re: [PATCH] libata: add ATAPI module option
Date: Fri, 21 Oct 2005 23:25:32 -0400
Message-ID: <4359B12C.5020800@pobox.com>
References: <20050830215234.GA6991@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from orb.pobox.com ([207.8.226.5]:22985 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S932575AbVJVDZl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 21 Oct 2005 23:25:41 -0400
In-Reply-To: <20050830215234.GA6991@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Jeff Garzik wrote:
>
>  ATAPI is getting close to being ready.  To increase exposure, we enable
>  the code in the upstream kernel, but default it to off (present
>  behavior).  Users must pass atapi_enabled=1 as a module option (if
>  module) or on the kernel command line (if built in) to turn on
>  discovery of their ATAPI devices.

Okay, I give.  How do I specify this option for the case
of having libata + scsi BUILT-IN (no modules).

I tried the usual /boot/grub/menu.lst thing:

    kernel /boot/vmlinuz-2.6.14-rc5 root=/dev/sda5 ro atapi_enabled=1

But still no ATAPI drive.   ???

Hardcoding the modparm to "1" instead of "0" in libata-core.c works though.

Cheers
-- 
Mark Lord
Real-Time Remedies Inc.
mlord@pobox.com

