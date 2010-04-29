From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 1/2] libata: don't flush dcache on slab pages
Date: Wed, 28 Apr 2010 20:16:27 -0400
Message-ID: <4BD8CFDB.9060109@pobox.com>
References: <20100321215222.GA27709@Chamillionaire.breakpoint.cc> <20100428200637.GA4578@Chamillionaire.breakpoint.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f194.google.com ([209.85.211.194]:53720 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754666Ab0D2AQa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 28 Apr 2010 20:16:30 -0400
Received: by ywh32 with SMTP id 32so8862876ywh.33
        for <linux-ide@vger.kernel.org>; Wed, 28 Apr 2010 17:16:29 -0700 (PDT)
In-Reply-To: <20100428200637.GA4578@Chamillionaire.breakpoint.cc>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Cc: linux-ide@vger.kernel.org

On 04/28/2010 04:06 PM, Sebastian Andrzej Siewior wrote:
> * Sebastian Andrzej Siewior | 2010-03-21 22:52:22 [+0100]:
>
>> page_mapping() check this via VM_BUG_ON(PageSlab(page)) so we bug here
>> with the according debuging turned on.
>>
>> Signed-off-by: Sebastian Andrzej Siewior<sebastian@breakpoint.cc>
>
> Jeff, a month passed since I posted this patch. Any reason why you
> ignore it?

Typically I wait a couple weeks for the Architecture maintainers to 
voice their objections, if any, on a patch like this.

No objections emerged that weren't addressed so far, we can probably 
push this in.

	Jeff



