From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: share PIO limits among devices sharing a channel
Date: Thu, 25 Jan 2007 23:36:56 +0900
Message-ID: <45B8C088.7090606@gmail.com>
References: <20070125112947.GC8606@htj.dyndns.org>	<20070125123030.3093fb32@localhost.localdomain>	<45B8A63F.8060305@pobox.com>	<45B8B0DF.4080602@gmail.com> <20070125135024.32b31a72@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.248]:50536 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965394AbXAYOhE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 Jan 2007 09:37:04 -0500
Received: by an-out-0708.google.com with SMTP id b33so351819ana
        for <linux-ide@vger.kernel.org>; Thu, 25 Jan 2007 06:37:03 -0800 (PST)
In-Reply-To: <20070125135024.32b31a72@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Alan wrote:
>>>> NAK, this is totally wrong
>> Eek.. You actually said this is/was documented and relied upon all over.
>>
>> http://thread.gmane.org/gmane.linux.ide/13184/focus=14486
> 
> What I said (well tried to say since it was apparently vague and caused
> confusion) was relied upon was the hardware being in PIO0 during probe
> (because we don't call the PIO setup methods during probe/reset) and that
> we decide which modes both devices are using *before* we set either of
> them (which the current code appears to do correctly). This is because
> the device may need to know both to apply limits - such as merging
> address setup time.

I see.

>>> I'm curious what the motivation of this patch was?
>> Hope my intentions are explained.
> 
> Yep. I think it's a simple case of confusion about the meaning of an
> email.

Okay, then.  We can just ignore this whole thread.  Thanks for clarifying.

-- 
tejun
