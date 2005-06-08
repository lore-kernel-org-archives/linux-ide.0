From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2/4] if condition fix for __atapi_pio_bytes()
Date: Wed, 8 Jun 2005 15:39:05 +0200
Message-ID: <58cb370e0506080639185392e9@mail.gmail.com>
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
Received: from wproxy.gmail.com ([64.233.184.205]:65230 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261231AbVFHNjH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 8 Jun 2005 09:39:07 -0400
Received: by wproxy.gmail.com with SMTP id 67so324679wri
        for <linux-ide@vger.kernel.org>; Wed, 08 Jun 2005 06:39:05 -0700 (PDT)
In-Reply-To: <42A6DD5E.30408@tw.ibm.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Albert Lee <albertcc@tw.ibm.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>

On 6/8/05, Albert Lee <albertcc@tw.ibm.com> wrote:

> ata_data_xfer() also does rounding: 'unsigned int words = buflen >> 1;'

Indeed and atapi_[input,output]_bytes() always do rounding.

What about simple...

        count++; /* round odd transfers */
	ata_data_xfer(ap, buf, count, do_write);

?

Bartlomiej
