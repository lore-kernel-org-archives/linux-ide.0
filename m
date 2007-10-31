From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH #upstream 1/2] libata: relocate forcing PIO0 on reset
Date: Wed, 31 Oct 2007 09:13:26 +0900
Message-ID: <4727C8A6.3000609@gmail.com>
References: <20071029074109.GO11853@htj.dyndns.org> <4727A146.7080701@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.187]:34968 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751989AbXJaANe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Oct 2007 20:13:34 -0400
Received: by rv-out-0910.google.com with SMTP id k20so2025373rvb
        for <linux-ide@vger.kernel.org>; Tue, 30 Oct 2007 17:13:34 -0700 (PDT)
In-Reply-To: <4727A146.7080701@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Chuck Ebbert <cebbert@redhat.com>
Cc: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

Chuck Ebbert wrote:
> On 10/29/2007 03:41 AM, Tejun Heo wrote:
>>   retry:
>> +	ata_link_for_each_dev(dev, &ap->link) {
> 
> How do I backport these loops to 2.6.23?
> 
> I see something like this in the old code:
> 
> 	for (i=0; i < ATA_MAX_DEVICES; i++) {
> 		dev = &ap->device[i];
>                 if (!ata_dev_enabled(dev))
>                         continue;
> 		do_something(dev);
> 	}

Yeap, that's pretty much it.

-- 
tejun
