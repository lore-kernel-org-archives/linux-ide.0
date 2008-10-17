From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: how to limit number of sectors each time
Date: Fri, 17 Oct 2008 18:47:00 +0200
Message-ID: <200810171847.00687.bzolnier@gmail.com>
References: <48F6B51B.2000408@alcatel-lucent.com> <20081016061808.GS19428@kernel.dk> <48F6DD54.70004@alcatel-lucent.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.185]:5954 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754832AbYJQQu0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 17 Oct 2008 12:50:26 -0400
Received: by gv-out-0910.google.com with SMTP id e6so206126gvc.37
        for <linux-ide@vger.kernel.org>; Fri, 17 Oct 2008 09:50:25 -0700 (PDT)
In-Reply-To: <48F6DD54.70004@alcatel-lucent.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: gshan <gshan@alcatel-lucent.com>
Cc: Jens Axboe <jens.axboe@oracle.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org


[ added linux-ide@ to cc:, please use it for ATA questions ]

On Thursday 16 October 2008, gshan wrote:
> 
> > (please never send out html only emails, it's considered very bad style
> > on this list)
> >
> > Sounds like you need a quirk/blacklist entry for that drive, if it
> > doesn't support 0x00 as meaning 256 sectors. If you are using libata,
> > you can add a ATA_HORKAGE_MAX_SEC_128 entry to ata_device_blacklist[] in
> > drivers/ata/libata-core.c
> >   
> I'm using IDE driver instead of HD driver.

Then you need to add check for this device to ide_disk_setup()
(prior to blk_queue_max_sectors() call) in drivers/ide/ide-disk.c.

Thanks,
Bart
