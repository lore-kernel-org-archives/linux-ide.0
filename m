From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 02/11] libata-eh: implement ata_ering
Date: Mon, 15 May 2006 23:57:20 +0900
Message-ID: <446896D0.7060309@gmail.com>
References: <11473536871340-git-send-email-htejun@gmail.com>	 <44665AAB.7000806@pobox.com> <44666D98.1000503@gmail.com>	 <44668249.9000004@pobox.com> <446685D1.4030607@gmail.com>	 <446688C8.6020001@pobox.com>	 <1147700193.26686.7.camel@localhost.localdomain>	 <44688991.8010407@gmail.com>  <44688F69.8030002@gmail.com> <1147704657.26686.49.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.192]:3560 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751444AbWEOO51 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 15 May 2006 10:57:27 -0400
Received: by nz-out-0102.google.com with SMTP id 18so117421nzp
        for <linux-ide@vger.kernel.org>; Mon, 15 May 2006 07:57:26 -0700 (PDT)
In-Reply-To: <1147704657.26686.49.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jgarzik@pobox.com>, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org

Alan Cox wrote:
> On Llu, 2006-05-15 at 23:25 +0900, Tejun Heo wrote:
>> I was too quick to response.  ering keeps track of timestamps of each
>> error and the criteria for speeding down is something like "3 class 1
>> errors during last 15mins", so bitmaps doesn't cut it.
> 
> Sounds like it does
> 
> 
> 	log_class_1_error(dev)
> 	{
> 		if((dev->class1 & 3) < 3) {
> 			dev->class1++;
> 			dev->class1sum++;
> 		} else {
> 			/* 3 this minute alone */
> 			it_happened_now_case();
> 		}
> 	}
> 
> 	class_1_each_minute(dev)
> 	{
> 		dev->class1sum -= (dev->class1 >> 30);
> 		dev->class1 <<= 2;
> 	}
> 

Yeap, of course, it does with periodic shifting.  The 3 in this minute
testing looks neat.

I don't know.  I'm still a bit hesitant because the thing becomes a
little bit more complex (it has more moving parts) and it would be
difficult to define/tune speed down or any other error handling (say,
turning off NCQ) criteria.  But, I might be planning too much.

-- 
tejun
