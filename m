From: Tejun Heo <htejun@gmail.com>
Subject: Re: Warnings on shutdown (Debian Etch and Kernel 2.6.22.9)
Date: Tue, 23 Oct 2007 19:12:01 +0900
Message-ID: <471DC8F1.9090501@gmail.com>
References: <47099C24.3010504@mandic.com.br> <471DAA1C.4070608@gmail.com> <471DC728.60705@mandic.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.177]:32907 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751615AbXJWKML (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 23 Oct 2007 06:12:11 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1672805wah
        for <linux-ide@vger.kernel.org>; Tue, 23 Oct 2007 03:12:10 -0700 (PDT)
In-Reply-To: <471DC728.60705@mandic.com.br>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Renato S. Yamane" <renatoyamane@mandic.com.br>
Cc: linux-ide@vger.kernel.org, miquels@cistron.nl

Renato S. Yamane wrote:
> Tejun Heo wrote:
>> Renato S. Yamane wrote:
>>> So, my questions is:
>>> - This is dangerous? Can damage something?
>>
>> If your drive sounds funny on shutdown, it could.  Your drive is
>> supposed to sound the same way it sounds when you execute "hdparm -y
>> /dev/sdX".
> 
> No strange sounds :-)
> 
>>> - How can I help to fix this warning?
>>
>> I believe there's already update out but you can edit some configuration
>> file (can't remember which ATM) such that "-h" option is not passed to
>> halt.
> 
> Fixed. Patch is attached. Thanks!

Can you write up something for other debian users so that it can be
included in the linux-ata page && cc Jeff Garzik?

-- 
tejun
