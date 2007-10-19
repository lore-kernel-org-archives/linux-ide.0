From: Tejun Heo <htejun@gmail.com>
Subject: Re: FW: LIBATA issue with SATA drive
Date: Fri, 19 Oct 2007 10:13:46 +0900
Message-ID: <471804CA.9040103@gmail.com>
References: <AF1760336DB49F43983B755855C2A46702AF744B@troe2k1.cs.myharris.net>	 <4716DC7D.6050007@gmail.com> <64bb37e0710181152j7d070258w9b9eeb59cf1f0a1d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.179]:51649 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753329AbXJSBOr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 18 Oct 2007 21:14:47 -0400
Received: by wa-out-1112.google.com with SMTP id v27so403339wah
        for <linux-ide@vger.kernel.org>; Thu, 18 Oct 2007 18:14:47 -0700 (PDT)
In-Reply-To: <64bb37e0710181152j7d070258w9b9eeb59cf1f0a1d@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Torsten Kaiser <just.for.lkml@googlemail.com>
Cc: "Ip, Clarence" <CIP@harris.com>, linux-ide@vger.kernel.org, jens.axboe@oracle.com

Hello,

Torsten Kaiser wrote:
>> The symptom seems very similar to yours but the kernel is 2.6.22 which
>> doesn't have the SG change which you found out to be broken.  Can you
>> update us on how the testing of patched kernel went?
> 
> Sorry I didn't realize that you where still waiting for a 'confirm
> good'. I intended only to mail, if I got the error again, as the debug
> output about SGE_TRM confirmed, that this fix changes the behavior of
> sata_sil24 and there was no really 200% sure method of detecting that
> this bug was gone.
> 
> Anyway, after fixing ata_sg_is_last() by adding the +1 I did not had a
> single failure.
> 
> I'm currently using 2.6.23-mm1 and 16 boots where all good.
> (Apart from the unrelated failure with sata_nv and swncq...)

I see, a different issue then.  It's just weird to see similar issues 
popping up now after allterm the time sata_sil24 has been around.

Clarence, it seems it could be that what's broken is irq routing not 
sata_sil24 itself  I dunno anything about irq routing on PPC440SPE but I 
bet there are kernel parameters to adjust them including irqpoll.  Do 
those have any effect?

--
tejun
