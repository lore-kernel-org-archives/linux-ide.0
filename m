From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] Don't use UDMA on VIA UDMA33 controller with Transcend SSD
Date: Thu, 14 Jan 2010 21:17:29 +0100
Message-ID: <201001142117.29522.bzolnier@gmail.com>
References: <Pine.LNX.4.64.0910211452160.17897@hs20-bc2-1.build.redhat.com> <201001141649.13073.bzolnier@gmail.com> <20100114192410.33b989d5@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f225.google.com ([209.85.220.225]:49585 "EHLO
	mail-fx0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932227Ab0ANUb0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 Jan 2010 15:31:26 -0500
Received: by fxm25 with SMTP id 25so484461fxm.21
        for <linux-ide@vger.kernel.org>; Thu, 14 Jan 2010 12:31:24 -0800 (PST)
In-Reply-To: <20100114192410.33b989d5@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Mikulas Patocka <mpatocka@redhat.com>, David Miller <davem@davemloft.net>, linux-ide@vger.kernel.org

On Thursday 14 January 2010 08:24:10 pm Alan Cox wrote:
> > The computer locks up if Transcend SSD runs in any of UDMA modes.
> > It doesn't lockup with different brand SSD, so this is specific to Transcend.
> > 
> > bzolnier:
> > - limit it to VT82C586A/B + TS64GSSD25-M (per commit 10734fc) for now
> > - add warning message
> 
> Looks good to me.

Thanks.

> > +		printk(KERN_WARNING "%s: disabling UDMA mode due to reported "
> > +			"lockups with this device.\n", drive->name);
> 
> That sounds odd - I think I'd have put ": not using UDMA mode as lockups
> have been reported with this device" or similar.

For compatibility reasons the warning message has been kept identical to
the one used by pata_via driver (please see commit 10734fc for details 8)..

--
Bartlomiej Zolnierkiewicz
