From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 2.6.22-rc5] libata: be less verbose about hpa
Date: Mon, 25 Jun 2007 21:12:46 +0900
Message-ID: <467FB13E.1080108@gmail.com>
References: <467FAAF2.9080104@gmail.com> <20070625131259.62d7b79f@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.179]:10781 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751703AbXFYMMv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 25 Jun 2007 08:12:51 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1781919wah
        for <linux-ide@vger.kernel.org>; Mon, 25 Jun 2007 05:12:51 -0700 (PDT)
In-Reply-To: <20070625131259.62d7b79f@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Alan Cox wrote:
> On Mon, 25 Jun 2007 20:45:54 +0900
> Tejun Heo <htejun@gmail.com> wrote:
> 
>> There's no reason to print out hpa related messages when HPA is not
>> active.  Kill the unconditional message and add a warning message
>> which is printed if HPA size is smaller than the current size.
>>
>> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> Acked-by: Alan Cox <alan@redhat.com>
> 
> (Should it be a dprintk instead of vanish though ?)

I thought about doing KERN_DEBUG but we have printks for both hpa >
current and hpa < current, so if no message is printed hpa == current
and the current sectors is printed in the next line anyway, so I think
we can just drop it.

-- 
tejun
