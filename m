From: Lee Trager <Lee@PicturesInMotion.net>
Subject: Re: [PATCH] HPA resume fix
Date: Wed, 30 Aug 2006 04:55:17 -0400
Message-ID: <44F55275.2000400@PicturesInMotion.net>
References: <44F40F06.4010408@PicturesInMotion.net>
 <1156849911.6271.101.camel@localhost.localdomain>
 <20060829114210.GI12257@kernel.dk>
 <1156855828.6271.106.camel@localhost.localdomain>
 <20060829123223.GM12257@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mta6.srv.hcvlny.cv.net ([167.206.4.201]:55907 "EHLO
	mta6.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S1750725AbWH3IzQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 30 Aug 2006 04:55:16 -0400
In-reply-to: <20060829123223.GM12257@kernel.dk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@kernel.dk>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, akpm@osdl.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, bzolnier@gmail.com

Jens Axboe wrote:
> On Tue, Aug 29 2006, Alan Cox wrote:
>   
>> Ar Maw, 2006-08-29 am 13:42 +0200, ysgrifennodd Jens Axboe:
>>     
>>> On Tue, Aug 29 2006, Alan Cox wrote:
>>>       
>>>> For -mm only to get more testing
>>>>
>>>> Acked-by: Alan Cox <alan@redhat.com>
>>>>         
>>> It should go into the state machine as described imho. Bart?
>>>       
>> If it works then yes it can become an explicit state. Firstly we need to
>> find out if it works.
>>     
>
> I think Lee tested and verified both this variant and the first one he
> had, so I hope that it works :-)
>
>   
It looks like we cross mailed. Anyway my patch is going into the mm
sources for testing. For the record I've been using this for the past
few weeks and its working great. I'll try to figure out how to create
it's own resume step next and submit that.
