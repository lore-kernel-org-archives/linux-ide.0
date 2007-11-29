From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 05/13] libata: improve ATAPI draining
Date: Thu, 29 Nov 2007 16:26:11 +0900
Message-ID: <474E6993.3070008@gmail.com>
References: <11961764391983-git-send-email-htejun@gmail.com> <11961764403671-git-send-email-htejun@gmail.com> <474E5C22.7010405@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.181]:60754 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751987AbXK2H0V (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 29 Nov 2007 02:26:21 -0500
Received: by wa-out-1112.google.com with SMTP id v27so2082227wah
        for <linux-ide@vger.kernel.org>; Wed, 28 Nov 2007 23:26:18 -0800 (PST)
In-Reply-To: <474E5C22.7010405@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, liml@rtr.ca, jens.axboe@oracle.com

Albert Lee wrote:
> If the trailing data is odd-lengthed, normally the situation is that
> we have odd-lengthed real data before the trailing data. e.g. The real
> data is 9 bytes, but the drive returns 10 bytes (so, the trailing data
> is 1 byte).
> 
> In ata_data_xfer(), we have the following code:
> 
>     /* Transfer trailing 1 byte, if any. */
>     ... (for write case) ...
>     iowrite16(le16_to_cpu(align_buf[0]), ap->ioaddr.data_addr);  or
> 
>     ... (for read case) ...
>     ioread16(ap->ioaddr.data_addr)
> 
> The PATA bus is actually 16-bit wide. So, ata_data_xfer() actually
> implicitly transfers one more byte than we see if it's odd-lengthed.
> 
> That's why in atapi_pio_bytes(), the trailing length was round down
> instead round up.

Hmmm... it's tricky.  When draining a partial chunk because of
odd-length short buffer on even-length chunk, it needs to be rounded
down but on all other cases it needs to be rounded up, right?

This is basically because count isn't updated with actually consumed
number of bytes.  I'll fix it and post an updated patch.

Thanks.

-- 
tejun
