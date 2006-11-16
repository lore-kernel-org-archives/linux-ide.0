From: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: AHCI and add_disk_randomness()
Date: Thu, 16 Nov 2006 13:40:29 +0100
Message-ID: <20061116124029.GA7164@kernel.dk>
References: <1124564609.20061115220130@marki-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from brick.kernel.dk ([62.242.22.158]:36883 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1423869AbWKPMlB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 16 Nov 2006 07:41:01 -0500
Content-Disposition: inline
In-Reply-To: <1124564609.20061115220130@marki-online.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marek Podmaka <marki@marki-online.net>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

On Wed, Nov 15 2006, Marek Podmaka wrote:
> Hello,
> 
>   I have server with Intel 5000V motherboard with integrated AHCI SATA
>   controller. It works well with kernel 2.6.18.2. But I have problem
>   with little entropy available and I'm not sure if one of the reasons
>   is that AHCI driver does not use add_disk_randomness() to contribute
>   to the kernel entropy pool.
> 
>   I'm not very skilled on kernel "hacking"... I tried finding where
>   this is called (it's defined in drivers/char/random.c and used for
>   example in Comapaq SmartArray driver in drivers/block/cciss.c). For
>   the SCSI part, I found it in scsi_lib.c, but I was not able to
>   determine if this is actually used by ahci/libata drivers.
> 
>   If not, would it be possible to implement it? I tried to figure out
>   where to call it by looking at cciss.c, but it seems that this is
>   totally different case, at least for me. I don't know where to add
>   it, because its parameter is struct gendisk *disk and didn't find it
>   used anywhere in ahci or libata.

Since ahci attaches its devices through the scsi layer,
add_disk_randomness() will get called from scsi_end_request() like for
any other scsi controller.

-- 
Jens Axboe

