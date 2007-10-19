From: Jeff Garzik <jeff@garzik.org>
Subject: Re: FW: LIBATA issue with SATA drive
Date: Thu, 18 Oct 2007 21:32:24 -0400
Message-ID: <47180928.3020104@garzik.org>
References: <AF1760336DB49F43983B755855C2A46702AF744B@troe2k1.cs.myharris.net>	 <4716DC7D.6050007@gmail.com> <64bb37e0710181152j7d070258w9b9eeb59cf1f0a1d@mail.gmail.com> <471804CA.9040103@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:60913 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759415AbXJSBcb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 18 Oct 2007 21:32:31 -0400
In-Reply-To: <471804CA.9040103@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Torsten Kaiser <just.for.lkml@googlemail.com>, "Ip, Clarence" <CIP@harris.com>, linux-ide@vger.kernel.org, jens.axboe@oracle.com

Tejun Heo wrote:
> Hello,
> 
> Torsten Kaiser wrote:
>>> The symptom seems very similar to yours but the kernel is 2.6.22 which
>>> doesn't have the SG change which you found out to be broken.  Can you
>>> update us on how the testing of patched kernel went?
>>
>> Sorry I didn't realize that you where still waiting for a 'confirm
>> good'. I intended only to mail, if I got the error again, as the debug
>> output about SGE_TRM confirmed, that this fix changes the behavior of
>> sata_sil24 and there was no really 200% sure method of detecting that
>> this bug was gone.
>>
>> Anyway, after fixing ata_sg_is_last() by adding the +1 I did not had a
>> single failure.
>>
>> I'm currently using 2.6.23-mm1 and 16 boots where all good.
>> (Apart from the unrelated failure with sata_nv and swncq...)
> 
> I see, a different issue then.  It's just weird to see similar issues 
> popping up now after allterm the time sata_sil24 has been around.

What kernel version are we talking about?  If it includes sg-chaining 
via a git tree somewhere, sata_sil24 has a bug that was just fixed (by 
removing ata_sg_is_last).

	Jeff



