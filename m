From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] ata_piix: ignore all zero PCS value on ICH5's
Date: Wed, 01 Feb 2006 11:01:53 +0900
Message-ID: <43E01691.9040600@gmail.com>
References: <438B6E05.8070009@eq.cz> <438D2C19.3030008@gmail.com> <438DA3FA.2010809@eq.cz> <a762e240511301405s433109b7n93e7fdcc7409bef5@mail.gmail.com> <438EC502.1090103@keytradebank.com> <20051201112015.GA10462@htj.dyndns.org> <438EF3B6.7020007@keytradebank.com> <438EFAA5.3070901@gmail.com> <438FA924.1090005@pobox.com> <438FB8B5.8070505@gmail.com> <20051202032605.GA15528@htj.dyndns.org> <43DC510A.1090101@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.196]:41706 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964859AbWBACCB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 31 Jan 2006 21:02:01 -0500
Received: by wproxy.gmail.com with SMTP id 69so262866wri
        for <linux-ide@vger.kernel.org>; Tue, 31 Jan 2006 18:02:00 -0800 (PST)
In-Reply-To: <43DC510A.1090101@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Jean-Fran?ois Stenuit <jfs@keytradebank.com>, Keith Mannthey <kmannth@gmail.com>, "0602@eq.cz" <0602@eq.cz>, Linux-ide <linux-ide@vger.kernel.org>

Jeff Garzik wrote:
> Tejun Heo wrote:
> 
>> Some ICH5's report 0 for PCS even when they have active working ports.
>> This patch makes piix_sata_probe() ignore 0 PCS value on ICH5's and
>> probe all ports in such cases.  And while at it, remove bogus
>> assignment to mask.
>>
> 
> I'm just not too thrilled about this.  I wonder if its an isolated 
> incident related to power or something.  I would wait for more problem 
> reports, before applying this.
> 

I'm not too sure about this one either, but we have two independent 
consistent bug reports and PCS handling in ata_piix isn't that necessary 
or strict to begin with, so....

How about making it a driver option?  ata_piix.ignore_PCS maybe?

-- 
tejun
