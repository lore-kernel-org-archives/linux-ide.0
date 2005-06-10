From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: [PATCH 2/4] libata: if condition fix for __atapi_pio_bytes()
Date: Fri, 10 Jun 2005 16:31:43 +0800
Message-ID: <42A94FEF.2020503@tw.ibm.com>
References: <42A3FF7B.3040201@tw.ibm.com> <42A7ED91.4090008@pobox.com>	 <42A9436E.9090906@tw.ibm.com> <58cb370e050610005628a5706a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bluehawaii.tikira.net ([61.62.22.51]:40432 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S262519AbVFJIcC (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 10 Jun 2005 04:32:02 -0400
In-Reply-To: <58cb370e050610005628a5706a@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>



Hi Bart:

> n 6/10/05, Albert Lee <albertcc@tw.ibm.com> wrote:
> 
>>Hi Jeff,
>>
>>Resend the patch #2 against the linux-2.6.git tree (0086b5ec7834b78358dea3f713275a9ae2b229ec).
>>
>>Problem:
>>    In __atapi_pio_bytes(), when (bytes > qc->nbytes) or (qc->cursg_ofs > sg->length) or
>>(count > bytes), the if condition is not handled properly.
> 
> 
> Only (bytes > qc->nbytes) can happen now.
> 
> 
Yes exactly.

However, could the patch be kept as is?
Maybe I'm worried too much about something that won't happen.
It makes me feel safer using "if (qc->cursg_ofs >= sg->length)" than
using "if (qc->cursg_ofs == sg->length)".
Using ">=" also make it clearer that we don't want to overrun the buffer.

The correct description of the patch is corrected per your advice:

Problem:
    In __atapi_pio_bytes(), when (bytes > qc->nbytes), the if condition is not handled properly.

Changes:
- Fix the "if condition" for the (bytes > qc->nbytes) situation.
- Althought (qc->cursg_ofs > sg->length) and (count > bytes) situation won't happen,
   the "if conditions" are also changed for safty.

Albert


