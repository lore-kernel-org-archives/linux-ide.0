From: Michael Thonke <iogl64nx@gmail.com>
Subject: Re: Playing with SATA NCQ
Date: Sun, 29 May 2005 20:10:52 +0200
Message-ID: <429A05AC.9020805@gmail.com>
References: <20050526140058.GR1419@suse.de> <429793C8.8090007@gmail.com> <42979C4F.8020007@pobox.com> <42979FA3.1010106@gmail.com> <20050528121258.GA17869@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.203]:38327 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261393AbVE2SLC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 29 May 2005 14:11:02 -0400
Received: by wproxy.gmail.com with SMTP id 68so1391649wri
        for <linux-ide@vger.kernel.org>; Sun, 29 May 2005 11:10:59 -0700 (PDT)
In-Reply-To: <20050528121258.GA17869@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Jens Axboe schrieb:

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
Hello again,

the queue_depth of 30 is okay? On boot the CFQ scheduler tells:

      cfq: depth 4 reached, tagging now on

This only appears with AHCI enabled what does that mean?

Also a question which options can be set in queue_type?

Best regard and thanks for help

Greets
    Michael


