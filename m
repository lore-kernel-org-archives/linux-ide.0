From: Michael Thonke <iogl64nx@gmail.com>
Subject: Re: Playing with SATA NCQ
Date: Sun, 29 May 2005 15:01:23 +0200
Message-ID: <4299BD23.6010004@gmail.com>
References: <20050526140058.GR1419@suse.de> <429793C8.8090007@gmail.com> <42979C4F.8020007@pobox.com> <42979FA3.1010106@gmail.com> <20050528121258.GA17869@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.196]:32915 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261297AbVE2NB0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 29 May 2005 09:01:26 -0400
Received: by wproxy.gmail.com with SMTP id 69so1569417wra
        for <linux-ide@vger.kernel.org>; Sun, 29 May 2005 06:01:26 -0700 (PDT)
In-Reply-To: <20050528121258.GA17869@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Jens Axboe wrote,

>
>There's really nothing to be tuned. If NCQ is enabled for your drive, it
>will be printed in dmesg after the lba48 flag, such as:
>
>ata1: dev 0 ATA, max UDMA/133, 488281250 sectors lba48 ncq
>
>If you don't see NCQ there, your drive/controller doesn't support it.
>Likewise you will have a queueing depth of > 1 if NCQ is enabled, check
>/sys/block/sdX/device/queue_depth to see what the configured queueing
>depth is for that device.
>
>  
>
Hi Jens,

thanks for the short info now my next question how many queue depths
are healty and wanted?

For my Intel Corporation 82801GR/GH (ICH7 Family) Serial ATA Storage
Controllers cc=AHCI (rev 01)
and Samsung Hd160JJ SATAII drive the default queue is 30

    ioGL64NX_MACH~# cat /sys/block/sda/device/{model,queue_depth}
    SAMSUNG HD160JJ
    30

    hdparm -Tt /dev/sda

    /dev/sda:
    Timing cached reads: 4724 MB in 2.00 seconds = 2360.00 MB/sec
    Timing buffered disk reads: 164 MB in 3.02 seconds = 54.28 MB/sec

On random access the drives is a bit noisy but the subjective feeling is
great
everything goes a bit faster.

And whats about the option /sys/block/sdx/device/queue_type = simple
what can be done here?

Thanks in advance
Best regards
Michael



