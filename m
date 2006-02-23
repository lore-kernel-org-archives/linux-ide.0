From: Tejun Heo <htejun@gmail.com>
Subject: Re: regarding ata_piix initialization trouble
Date: Thu, 23 Feb 2006 20:52:43 +0900
Message-ID: <43FDA20B.4000307@gmail.com>
References: <43FD6794.8020902@gmail.com> <43FD8721.6080909@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.182]:2440 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750907AbWBWLvi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 23 Feb 2006 06:51:38 -0500
Received: by pproxy.gmail.com with SMTP id e30so33010pya
        for <linux-ide@vger.kernel.org>; Thu, 23 Feb 2006 03:51:37 -0800 (PST)
In-Reply-To: <43FD8721.6080909@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Jean-Fran?ois Stenuit <jfs@keytradebank.com>, "0602@eq.cz" <0602@eq.cz>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Jeff Garzik wrote:
> Tejun wrote:
> 
>> Hello, Jean & 0602.
>>
>> I was digging ICH docs to reimplement ata_piix initialization and 
>> found out that 6300ESB lists high bits (the present bits) of PCS 
>> register as reserved. But they indiciate that the bits might change 
>> anytime just as in other docs. I think something went wrong with those 
>> bits in that particular chipset and Intel decided to ignore the bits.
>>
>> I'm wondering whether your problems are related to this. Can you guys 
>> please run 'lspci -n' on your machines which had the piix 
>> initialization trouble and report the result here?
> 
> 
> Note that we still get the PCS bits wrong because, e.g. they only apply 
> to ports 0 and 2 on some chipsets, not ports 0 and 1 like you would expect.
> 

Jeff, can you please elaborate? I'm currently looking at datasheets for 
ICH5, 6, 7 and 6300ESB but can't really understand what you're saying. 
Doesn't PCS + MAP give the whole picture?

-- 
tejun
