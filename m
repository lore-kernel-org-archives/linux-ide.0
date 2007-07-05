From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 2.6.22-rc7 2/3] libata: implement HORKAGE_SETXFER
Date: Thu, 05 Jul 2007 21:22:44 +0900
Message-ID: <468CE294.2080705@gmail.com>
References: <20070705043127.GX29122@htj.dyndns.org>	<20070705043501.GY29122@htj.dyndns.org> <20070705132706.743d18d8@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.177]:54673 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756842AbXGEMWw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 5 Jul 2007 08:22:52 -0400
Received: by wa-out-1112.google.com with SMTP id v27so3588045wah
        for <linux-ide@vger.kernel.org>; Thu, 05 Jul 2007 05:22:49 -0700 (PDT)
In-Reply-To: <20070705132706.743d18d8@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Alan Cox wrote:
> On Thu, 5 Jul 2007 13:35:01 +0900
> Tejun Heo <htejun@gmail.com> wrote:
> 
>> Make CFA SETXFER failure handling into HORKAGE.  This will be used to
>> allow other cases to ignore SETXFER failure.
> 
> NAK
> 
>> +			/* Old CFA may refuse SETFEATURES_XFER, which
>> +			 * is just fine
>> +			 */
>> +			if (!(xfer_mask & ~ATA_MASK_PIO))
>> +				dev->horkage |= ATA_HORKAGE_SETXFER;
>> +		} else
> 
> This is specifically done for PIO. An XFER failure for non PIO modes is a
> serious failure and happens in the real world sometimes.

Hmmm... That's what "if (!(xfer_mask & ~ATA_MASK_PIO))" test was for.
Or is it not enough?

-- 
tejun
