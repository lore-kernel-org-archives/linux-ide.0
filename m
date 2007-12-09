From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 3/20] dtc2278: ->io_32bit setting don't have to be identical for master/slave
Date: Mon, 10 Dec 2007 00:15:15 +0100
Message-ID: <200712100015.15735.bzolnier@gmail.com>
References: <200712092208.58494.bzolnier@gmail.com> <20071209222736.1c4ba88c@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:54126 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751021AbXLIXG2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 9 Dec 2007 18:06:28 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1397527ugc
        for <linux-ide@vger.kernel.org>; Sun, 09 Dec 2007 15:06:27 -0800 (PST)
In-Reply-To: <20071209222736.1c4ba88c@the-village.bc.nu>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

On Sunday 09 December 2007, Alan Cox wrote:
> > drive->io_32bit is used per PIO transfer so there is no reason to
> > require it to be identical for master/slave.
> 
> Sure about that ?
> 
> The driver has always gone to great pains to ensure that occurs and that
> suggests the author had a good reason for doing it. Have you tested this
> with an actual DTC2278 card ?
> 
> If not - NAK. You risk corruptors for no material benefit.

There is absolutely no hardware setup done by IDE subsystem or dtc2278
host driver when ->io_32bit setting is changed and since ->io_32bit setting
is only ever checked per drive / PIO transfer so this is currently purely
a software limitation (moreover HDIO_DRIVE_CMD and HDIO_DRIVE_TASKFILE
ioctls force 16-bit I/O anyway).

[ I also haven't noticed anything related to this requirement in Winbond
  W83759A datasheet (though I have only quickly skimmed through it)... ]

Bart
