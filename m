From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Success(?) with SiI + Seagate pessimistic fix disabled.
Date: Sun, 11 Jan 2004 03:14:30 -0500
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <400105E6.6060008@pobox.com>
References: <20040109054800.GA32112@Mayonaise> <20040109090003.GA3032@Mayonaise>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:27782 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265802AbUAKIO4
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 11 Jan 2004 03:14:56 -0500
In-Reply-To: <20040109090003.GA3032@Mayonaise>
List-Id: linux-ide@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
Cc: linux-ide@vger.kernel.org

Eric Wong wrote:
> Eric Wong <normalperson@yhbt.net> wrote:
> <snip success story>
> 
> I'm not feeling any more pessimistic than usual at the moment, so I
> might as well start a one item whitelist.  It works for me, but more
> testing is always a good thing.
> 
> On a related note, I couldn't find a way to get the firmware revision
> from hdparm or dmesg when using libata.
> 
> --- a/drivers/scsi/sata_sil.c
> +++ b/drivers/scsi/sata_sil.c


Well, if you're motivated, there is a blacklist...

google for "mod15write" and click on the first link.


