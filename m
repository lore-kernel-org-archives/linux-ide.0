From: Tejun Heo <htejun@gmail.com>
Subject: Re: [RFT] sata_promise: decode and report error reasons
Date: Thu, 08 Mar 2007 11:44:27 +0900
Message-ID: <45EF788B.3080300@gmail.com>
References: <200703010158.l211wXPS012467@harpo.it.uu.se>	<45EB9DF4.20402@gmail.com> <17903.6217.992304.800959@alkaid.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.177]:46663 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750882AbXCHCo2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 Mar 2007 21:44:28 -0500
Received: by py-out-1112.google.com with SMTP id a29so125489pyi
        for <linux-ide@vger.kernel.org>; Wed, 07 Mar 2007 18:44:27 -0800 (PST)
In-Reply-To: <17903.6217.992304.800959@alkaid.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: linux-ide@vger.kernel.org

Hello,

Jeff clarified most things.  Just few more things.

Mikael Pettersson wrote:
> Which SErrror bits are standard?
> It is true that some of the SError bits are diagnostic rather than
> actual error indicators, as Promise's driver only checks a subset
> of them. I'll fix that.

Pretty much most of them.  Just take a look at SError section in
serialATA spec.  libata EH decodes most of error and some of diagnostic
bits in ata_eh_analyze_serror().

> ATA_DMA_CNT_ERR is when a DMA FIS data size differs from total DMA S/G size.
> I think AC_ERR_ATA_BUS is the correct choice for this one too.

AC_ERR_ATA_BUS is a bit special in that if it happens repeatedly it will
trigger transfer speed adjustment pretty quickly.  The error should be
set iff the error is a transmission error on the wire which is likely to
be fixed by slowing down the transfer rate.  Maybe it should have been
named AC_ERR_ATA_TRANSMISSION or something.

As Jeff pointed out, AC_ERR_HSM is usually used when we can receive the
FIS correctly but it doesn't make sense.  This is usually caused by
driver error or seriously brain damaged firmware.  :-)

Thanks.

-- 
tejun
