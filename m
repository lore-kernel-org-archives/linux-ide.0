From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: [PATCH 2/4] if condition fix for __atapi_pio_bytes()
Date: Wed, 08 Jun 2005 11:47:44 +0800
Message-ID: <42A66A60.5060105@tw.ibm.com>
References: <42A3FF7B.3040201@tw.ibm.com> <42A40214.5080006@tw.ibm.com> <58cb370e050606023238eeecba@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bluehawaii.tikira.net ([61.62.22.51]:51686 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S262083AbVFHDsL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 7 Jun 2005 23:48:11 -0400
In-Reply-To: <58cb370e050606023238eeecba@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>

Hi Bart:

> 
> 
> (bytes > qc->nbytes) condition can happen and this part of the patch
> is fine with me
> but I fail to see how (qc->cursg_ofs > sg->length) or (count > bytes)
> can happen...
> 
> 	count = min(sg->length - qc->cursg_ofs, bytes);
> 
> 	/* don't cross page boundaries */
> 	count = min(count, (unsigned int)PAGE_SIZE - offset);
> 
> Bartlomiej
> 
> 

Normally (qc->cursg_ofs > sg->length) or (count > bytes) won't happen.
However, if we apply patch [4/4], which overrun the odd-length buffer by one byte,
then (qc->cursg_ofs > sg->length) and (count > bytes) could happen.


Albert


