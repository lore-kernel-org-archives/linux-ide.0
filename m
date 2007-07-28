From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] au1xxx: fix au1xxx_set_pio_mode()
Date: Sat, 28 Jul 2007 23:57:12 +0200
Message-ID: <200707282357.12194.bzolnier@gmail.com>
References: <200707262155.19693.bzolnier@gmail.com> <46A901F6.2000007@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:53333 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754025AbXG1Xoj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 28 Jul 2007 19:44:39 -0400
Received: by ug-out-1314.google.com with SMTP id j3so879618ugf
        for <linux-ide@vger.kernel.org>; Sat, 28 Jul 2007 16:44:38 -0700 (PDT)
In-Reply-To: <46A901F6.2000007@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Thursday 26 July 2007, Sergei Shtylyov wrote:
> Bartlomiej Zolnierkiewicz wrote:
> 
> > Set transfer mode on the device before programming the host controller for
> > the new timings (matches what auide_tune_chipset() is doing wrt DMA modes).
> 
>    It's not that the most other drives are doing something different... :-)
> 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> 
> Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

added
