From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: IDE class driver with SATA controllers
Date: Wed, 01 Sep 2004 09:19:42 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <4135CC6E.3050508@pobox.com>
References: <DBFABB80F7FD3143A911F9E6CFD477B03F969B@hqemmail02.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:55680 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266508AbUIANUD
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 1 Sep 2004 09:20:03 -0400
In-Reply-To: <DBFABB80F7FD3143A911F9E6CFD477B03F969B@hqemmail02.nvidia.com>
List-Id: linux-ide@vger.kernel.org
To: Andrew Chew <achew@nvidia.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl, Alan Cox <alan@lxorguk.ukuu.org.uk>

Andrew Chew wrote:
> The reason I'm asking is because it would seem like a good thing to have
> SATA controllers that are broadly compatible with IDE to be usable
> without having to modify the core kernel drivers.  This would at least
> allow a user to perform a Linux install on a SATA drive even if that
> kernel doesn't have explicit support for the SATA controller.  A
> kernel/driver update can then take place after the install.
> 
> Also, are there plans for libata to take over the IDE class driver
> functionality in the future?


Once ATAPI is complete, then I will green-light PATA support in libata.

Since libata already supports the standard bmdma stuff, and can even 
work in PIO-only mode without DMA (or even without interrupts, in 100% 
polling mode), it is definitely possible to drive the hardware.

If you want to play, and don't care about lack of ATAPI support (i.e. 
just disks), then it is possible today to do this.  #define 
ATA_FORCE_PIO and play away :)

With regards to libata being the default, making that an _option_ is 
feasible, but we will probably default to the IDE driver for quite some 
time.  There are issues of /dev/hda versus /dev/sda, keeping existing 
user setups working, etc.

	Jeff


