From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 5/7] libata: move and reduce locking to the pio data xfer
 functions
Date: Fri, 11 May 2007 19:07:22 +0200
Message-ID: <4644A2CA.9070408@gmail.com>
References: <463EAB4D.3000309@tw.ibm.com>	<463ED8B9.4060501@gmail.com>	<463F0B25.40103@tw.ibm.com>	<463F0DAD.5060307@gmail.com>	<463F1374.1010100@tw.ibm.com>	<463F1509.30100@gmail.com>	<46405F50.5090901@tw.ibm.com>	<20070508130025.7693980c@the-village.bc.nu>	<464066A4.1010008@gmail.com>	<20070508132046.70a4d9ed@the-village.bc.nu>	<46406C9A.4000802@gmail.com> <20070508134540.509f4704@the-village.bc.nu> <464073B1.80303@gmail.com> <4644192A.8090809@tw.ibm.com> <46441CA9.4030109@tw.ibm.com> <46447FB5.3040306@gmail.com> <46449067.70107@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.235]:25377 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759079AbXEKRIh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 May 2007 13:08:37 -0400
Received: by wr-out-0506.google.com with SMTP id 76so1114467wra
        for <linux-ide@vger.kernel.org>; Fri, 11 May 2007 10:08:36 -0700 (PDT)
In-Reply-To: <46449067.70107@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@enoyolf.org>, bzolnier@gmail.com, Mark Lord <liml@rtr.ca>

Albert Lee wrote:
> Tejun Heo wrote:
>> Albert Lee wrote:
>>
>>> -static void ata_pio_sector(struct ata_queued_cmd *qc, int last)
>>> +static void ata_pio_sector(struct ata_queued_cmd *qc, int last, int lock)
>>
>> I think the naming of @lock is a bit confusing here.  @clr_hsm_wq or
>> @last_sector, maybe?
>>
> 
> How about "irq_handover"? When set to "true", it means the workqueue is going to
> handover the control of the port to the irq handler.

Oops, forgot to write about this.  Yeah, that sounds good too.  I just
thought @lock was too vague.

Thanks.

-- 
tejun
