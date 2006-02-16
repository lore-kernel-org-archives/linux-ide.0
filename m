From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2/3] libata: make ata_device and ata_port use unsigned
	int xfer_mask
Date: Thu, 16 Feb 2006 14:32:09 +0000
Message-ID: <1140100329.28094.17.camel@localhost.localdomain>
References: <11400989462545-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [81.2.110.250] ([81.2.110.250]:14735 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S932486AbWBPOai (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 16 Feb 2006 09:30:38 -0500
In-Reply-To: <11400989462545-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jgarzik@pobox.com, albertcc@tw.ibm.com, bzolnier@gmail.com, linux-ide@vger.kernel.org

On Iau, 2006-02-16 at 23:09 +0900, Tejun Heo wrote:
> This change removes simplifies code in libata-core and makes
> integration of later EH speed-down and per-device trasnfer mode
> configuration easier.  This patch does not change any behavior.

It also makes all the drive code extremely ugly and non-obvious.

We replace clear code like

	speed = dev->pio_mode;

with

       speed = ata_xfer_mask2mode(adev->xfer_mask, ATA_SHIFT_PIO);

I don't think that is exactly an improvement. The replacement of clear
easy to read values in the tables with macros that are convoluted and so
long winded you've even used defines everywhere to avoid repeatign them
is not an improvement either

I'm definitely opposed to this gross uglification of the libata API.
Keep libata clean for driver writers because we have a lot of drivers
which will be written by non-experts and a single core which is
maintained entirely by smart people.

Alan

