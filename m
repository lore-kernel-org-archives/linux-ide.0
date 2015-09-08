From: Andy Smith <andy@strugglers.net>
Subject: Re: NCQ-related READ/WRITE frozen ATA errors with Intel C220 and
 Intel s3610 SSDs
Date: Tue, 8 Sep 2015 21:23:46 +0000
Message-ID: <20150908212346.GG4327@bitfolk.com>
References: <20150809042756.GX4243@bitfolk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bitfolk.com ([85.119.80.223]:50471 "EHLO mail.bitfolk.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751669AbbIHVXr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 8 Sep 2015 17:23:47 -0400
Received: from andy by mail.bitfolk.com with local (Exim 4.72)
	(envelope-from <andy@strugglers.net>)
	id 1ZZQMk-00010c-6x
	for linux-ide@vger.kernel.org; Tue, 08 Sep 2015 21:23:46 +0000
Content-Disposition: inline
In-Reply-To: <20150809042756.GX4243@bitfolk.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

On Sun, Aug 09, 2015 at 04:27:56AM +0000, Andy Smith wrote:
> I've just put together a system based on a Supermicro X10SDV-F
> motherboard, which comes with an Intel C220 SATA controller. I've
> got two Intel DC s3610 SSDs plugged into this, and have
> intermittently been seeing the following ATA errors:
> 
> Jul 23 17:14:41 snaps kernel: [68044.504092] ata2.00: exception Emask 0x0 SAct 0x3000000 SErr 0x0 action 0x6 frozen
> Jul 23 17:14:41 snaps kernel: [68044.504215] ata2.00: failed command: WRITE FPDMA QUEUED
> Jul 23 17:14:41 snaps kernel: [68044.504291] ata2.00: cmd 61/01:c0:00:a8:75/00:00:66:00:00/40 tag 24 ncq 512 out
> Jul 23 17:14:41 snaps kernel: [68044.504291]          res 40/00:01:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> Jul 23 17:14:41 snaps kernel: [68044.504357] ata2.00: status: { DRDY }
> Jul 23 17:14:41 snaps kernel: [68044.504376] ata2.00: failed command: WRITE FPDMA QUEUED
> Jul 23 17:14:41 snaps kernel: [68044.504402] ata2.00: cmd 61/08:c8:d1:b1:b5/00:00:09:00:00/40 tag 25 ncq 4096 out
> Jul 23 17:14:41 snaps kernel: [68044.504402]          res 40/00:01:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> Jul 23 17:14:41 snaps kernel: [68044.504468] ata2.00: status: { DRDY }
> Jul 23 17:14:41 snaps kernel: [68044.504488] ata2: hard resetting link
> Jul 23 17:14:42 snaps kernel: [68044.824115] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> Jul 23 17:14:42 snaps kernel: [68044.825069] ata2.00: configured for UDMA/133
> Jul 23 17:14:42 snaps kernel: [68044.825096] ata2.00: device reported invalid CHS sector 0
> Jul 23 17:14:42 snaps kernel: [68044.825123] ata2.00: device reported invalid CHS sector 0
> Jul 23 17:14:42 snaps kernel: [68044.825153] ata2: EH complete

It turns out this was a bug in the drive firmware, apparently
affecting all Intel DC s3610 and s3710 SSDs, and Intel have quietly
fixed it with a firmware update:

    https://communities.intel.com/thread/77801?start=0&tstart=0

Cheers,
Andy
