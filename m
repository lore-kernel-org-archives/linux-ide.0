From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 3/20] dtc2278: ->io_32bit setting don't have to be identical for master/slave
Date: Mon, 10 Dec 2007 00:52:28 +0100
Message-ID: <200712100052.28528.bzolnier@gmail.com>
References: <200712092208.58494.bzolnier@gmail.com> <200712100015.15735.bzolnier@gmail.com> <20071209230736.2cdb6e44@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:30939 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751136AbXLIXnd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 9 Dec 2007 18:43:33 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1402423ugc
        for <linux-ide@vger.kernel.org>; Sun, 09 Dec 2007 15:43:31 -0800 (PST)
In-Reply-To: <20071209230736.2cdb6e44@the-village.bc.nu>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

On Monday 10 December 2007, Alan Cox wrote:
> > There is absolutely no hardware setup done by IDE subsystem or dtc2278
> > host driver when ->io_32bit setting is changed and since ->io_32bit setting
> 
> So ?
> 
> The original author went to great trouble to specifically enforce the
> behaviour in question and probably did so for a reason. Would it not be

Probably so but please keep in mind the state of IDE subsystem back
then...

> far safer to fix it by keeping that enforcement and fixing where it is
> lost than removing it - especially if you cannot test the hardware ?

What about just enforcing ->io_32bit for both drives in ->init_hwif method
and disallowing any futher changes with 'hwif->no_io_32bit = 1'?

Thanks,
Bart
