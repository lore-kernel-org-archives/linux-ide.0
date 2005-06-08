From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2/4] if condition fix for __atapi_pio_bytes()
Date: Wed, 8 Jun 2005 15:33:40 +0200
Message-ID: <58cb370e05060806334c997daa@mail.gmail.com>
References: <42A3FF7B.3040201@tw.ibm.com> <42A40214.5080006@tw.ibm.com>
	 <58cb370e050606023238eeecba@mail.gmail.com>
	 <42A66A60.5060105@tw.ibm.com>
	 <58cb370e0506080248378c2cf2@mail.gmail.com>
	 <42A6DD5E.30408@tw.ibm.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.206]:20855 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261202AbVFHNdk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 8 Jun 2005 09:33:40 -0400
Received: by wproxy.gmail.com with SMTP id 67so322217wri
        for <linux-ide@vger.kernel.org>; Wed, 08 Jun 2005 06:33:40 -0700 (PDT)
In-Reply-To: <42A6DD5E.30408@tw.ibm.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Albert Lee <albertcc@tw.ibm.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>

On 6/8/05, Albert Lee <albertcc@tw.ibm.com> wrote:
> 
> Hi Bart:
> 
> >>
> >>Normally (qc->cursg_ofs > sg->length) or (count > bytes) won't happen.
> >>However, if we apply patch [4/4], which overrun the odd-length buffer by one byte,
> >>then (qc->cursg_ofs > sg->length) and (count > bytes) could happen.
> >
> >
> > If so wouldn't it be easier to round 'bytes' instead of 'count' in the patch #4?
> >
> > * this patch (#2) gets simpler
> > * no need to round 'bytes' in the patch #3
> > * rounding can be moved from "sg loop" to the beginning of __atapi_pio_bytes()
> >   in the patch #4
> >
> 
> ata_data_xfer() also does rounding: 'unsigned int words = buflen >> 1;'
> If we only round 'bytes' and moves rounding from "sg loop" to the beginning of __atapi_pio_bytes(),
> then the last 1 bytes of odd length buffer will still be lost.
> 
> Ex. say 'sg->length' is 51, 'qc->cursg_ofs' is 0 and 'bytes' is 52 (rounded), after the min()
>          /* don't overrun current sg */
>         count = min(sg->length - qc->cursg_ofs, bytes);
> 
>       'count' will be 51, and ata_data_xfer() will only transfer 50 bytes.
>   52 - 51 = 1 (1 byte trailing) So the trailing handling code will be invoked and eat the 51th and 52th byte.
> The 51th byte is lost. :(
> 
>    Maybe we can round both 'sg->length' and 'bytes'?
> Ex.
>         bytes += bytes & 0x01;
>          ....
> loop:
>         ....
>         /* don't overrun current sg */
>         sg->length += (sg->length) & 0x01;  // Round sg->length
>         count = min(sg->length - qc->cursg_ofs, bytes);
>       => both 'count' and 'byte' will be 52 here
> 
>    However, this will introduce another rounding into the loop. :(

Another idea - move rounding just before ata_data_xfer() so 'count' will stay 
rounded only for the duration of ata_data_xfer() ('count' is reset for
every sg)
and we won't have to worry about sg->length and 'bytes'.

Or just leave it as it is and reorder patches... :).

Thanks.

> BTW, some cd-rom drive acutally rounds odd length from 51 to 52. (eg. asus crw-5232as on my test machine).
> Overrunning the count and sg (sg->length is 51) by one byte as done in patch #4 can save us one loop in the trailing handling code.
> Ex. count 51 rounded to 52; byte is 52 rounded by device
>      => byte -= count is zero and no need to go the trailing handling code.
> 
> Albert
> 
> 
> 
>
