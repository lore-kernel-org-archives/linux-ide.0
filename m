From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 1/9] libata: change debugging macros/adjust dbg levels
Date: Fri, 30 Jun 2006 06:19:58 +0900
Message-ID: <44A443FE.9090607@gmail.com>
References: <20060629160926.GB23122@zmei.tnic> <44A3FF72.8090404@gmail.com> <20060629172715.GA21339@gollum.tnic> <44A4174C.7020109@gmail.com> <20060629205315.GA27955@gollum.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.183]:37197 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932661AbWF2VTg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 29 Jun 2006 17:19:36 -0400
Received: by py-out-1112.google.com with SMTP id b36so433859pyb
        for <linux-ide@vger.kernel.org>; Thu, 29 Jun 2006 14:19:35 -0700 (PDT)
In-Reply-To: <20060629205315.GA27955@gollum.tnic>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <bbpetkov@yahoo.de>
Cc: linux-ide <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>

Borislav Petkov wrote:
> On Fri, Jun 30, 2006 at 03:09:16AM +0900, Tejun Heo wrote:
>> Please make
>>
>> +	ATA_MSG_ERR	= 0,
>> +	ATA_MSG_WARN	= 1,
>> +	ATA_MSG_DRV	= 2,
>> +	ATA_MSG_INFO	= 3, /* revalidation messages, EH progress */
>> +	ATA_MSG_VDEBUG	= 4, /* verbose hot path */
>> +	ATA_MSG_CMD	= 5, /* issue / completion */
>> +	ATA_MSG_SG	= 6, /* SG map/unmap handling */
>> +	ATA_MSG_TRACE	= 7, /* function tracing, e.g. enter/exit */
>>
>> And test for msg_enable & (1 << (lv)).  Otherwise the array will be 
>> unnecessarily large.
> Yeah, but this won't work:
> imagine default level is:
> msg_enable = ATA_MSG_INFO;

You can do "msg_enable |= (1 << ATA_MSG_INFO)" or keep ATA_MSG_*'s as 
bit masks and use fls() to index into level array.  Just make sure that 
the level array isn't 512 entries long.

-- 
tejun
