From: Tejun Heo <htejun@gmail.com>
Subject: Re: [RFT] major libata update
Date: Wed, 17 May 2006 08:53:23 +0900
Message-ID: <446A65F3.5030706@gmail.com>
References: <20060515170006.GA29555@havoc.gtf.org> <4469B93E.6010201@emc.com> <4469E0DB.1040709@garzik.org> <4469EEC0.4060907@gmail.com> <446A6191.8080307@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.232]:51333 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932291AbWEPXwp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 16 May 2006 19:52:45 -0400
Received: by wr-out-0506.google.com with SMTP id 37so118490wra
        for <linux-ide@vger.kernel.org>; Tue, 16 May 2006 16:52:44 -0700 (PDT)
In-Reply-To: <446A6191.8080307@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Ric Wheeler <ric@emc.com>, linux-ide@vger.kernel.org, Mark Lord <mlord@pobox.com>, Jens Axboe <axboe@suse.de>

Jeff Garzik wrote:
> Tejun Heo wrote:
>> * can we make tags int and use -1 for invalid tag?  ATA_TAG_POISON 
>> looks horrible when printed.
> 
> print with %x :)
> 
> 
>> * it would be nice to have some framework to determine whether the 
>> controller is receiving too many consecutive spurious interrupts.  
>> Say, 32 irqs in a row without intervening valid interrupts is a good 
>> reason to be suspicious about stuck IRQ.  Freezing & resetting will 
>> resolve the situation in most cases.
> 
> well, there is a screaming interrupt detector in the kernel...  Ideally 
>  we should strive to make sure that only happens in debug scenarios :)

AFAIK, it disables the IRQ when triggered.  As stuck IRQ is something we 
see not so rarely with ATA devices, it would be better to deal with them 
more intelligently in libata, IMHO.  libata has ways to recover from 
most of those situations.

>> * With NCQ, some drives generate spurious D2H FISes with I bit set as 
>> if it were executing non-NCQ commands.  So, regardless of controller, 
>> we're likely to see similar problems (but sil24 does all the protocol 
>> handling and ignores such FISes by itself).  This can be combined with 
>> the above freeze on too many spurious, I guess.
> 
> Interesting

D2H is interesting but the spurious SDB FIS Ric is reporting is scary. 
I hope something else is wrong.  :(

-- 
tejun
