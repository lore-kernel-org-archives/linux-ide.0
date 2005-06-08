From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2/4] if condition fix for __atapi_pio_bytes()
Date: Wed, 8 Jun 2005 11:48:45 +0200
Message-ID: <58cb370e0506080248378c2cf2@mail.gmail.com>
References: <42A3FF7B.3040201@tw.ibm.com> <42A40214.5080006@tw.ibm.com>
	 <58cb370e050606023238eeecba@mail.gmail.com>
	 <42A66A60.5060105@tw.ibm.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.205]:5195 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261210AbVFHJsq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 8 Jun 2005 05:48:46 -0400
Received: by wproxy.gmail.com with SMTP id 67so233611wri
        for <linux-ide@vger.kernel.org>; Wed, 08 Jun 2005 02:48:46 -0700 (PDT)
In-Reply-To: <42A66A60.5060105@tw.ibm.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Albert Lee <albertcc@tw.ibm.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>

On 6/8/05, Albert Lee <albertcc@tw.ibm.com> wrote:
> Hi Bart:
> 
> >
> >
> > (bytes > qc->nbytes) condition can happen and this part of the patch
> > is fine with me
> > but I fail to see how (qc->cursg_ofs > sg->length) or (count > bytes)
> > can happen...
> >
> >       count = min(sg->length - qc->cursg_ofs, bytes);
> >
> >       /* don't cross page boundaries */
> >       count = min(count, (unsigned int)PAGE_SIZE - offset);
> >
> > Bartlomiej
> >
> >
> 
> Normally (qc->cursg_ofs > sg->length) or (count > bytes) won't happen.
> However, if we apply patch [4/4], which overrun the odd-length buffer by one byte,
> then (qc->cursg_ofs > sg->length) and (count > bytes) could happen.

If so wouldn't it be easier to round 'bytes' instead of 'count' in the patch #4?

* this patch (#2) gets simpler
* no need to round 'bytes' in the patch #3
* rounding can be moved from "sg loop" to the beginning of __atapi_pio_bytes()
  in the patch #4

[ unless I'm missing something ]

Thanks,
Bartlomiej
