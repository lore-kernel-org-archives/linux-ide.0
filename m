From: Brad Campbell <brad@wasp.net.au>
Subject: Re: [OOPS] 2.6.21-rc6-git5 in cfq_dispatch_insert
Date: Mon, 16 Apr 2007 07:23:45 +0400
Message-ID: <4622EC41.40701@wasp.net.au>
References: <4621FAF0.7000705@wasp.net.au> <46220339.9080205@wasp.net.au> <20070415235348.GJ3691@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754392AbXDPDXz@vger.kernel.org>
In-Reply-To: <20070415235348.GJ3691@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: lkml <linux-kernel@vger.kernel.org>, axboe@kernel.dk, jgarzik@pobox.com, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Adrian Bunk wrote:
> [ Cc's added, additional information is in http://lkml.org/lkml/2007/4/15/32 ]
> 
> On Sun, Apr 15, 2007 at 02:49:29PM +0400, Brad Campbell wrote:
>> Brad Campbell wrote:
>>> G'day all,
>>>
>>> All I have is a digital photo of this oops. (It's 3.5mb). I have serial 
>>> console configured, but Murphy is watching me carefully and I just can't 
>>> seem to reproduce it while logging the console output.
>>>
>> And as usual, after trying to capture one for 4 days, I get one 10 mins 
>> after I've sent the E-mail :)
>>
>> I think I've just found a way to make this easier to reproduce as /dev/sdd 
>> was not even mounted this
>> time. I just cold booted and started an md5sum -c run on a directory of 
>> about 180GB.
> 
> 
> Is this also present with kernel 2.6.20 or is it a regression?
> 

Yes, I reproduced it with 2.6.20 but appear to be unable to do so with 2.6.19.



-- 
"Human beings, who are almost unique in having the ability
to learn from the experience of others, are also remarkable
for their apparent disinclination to do so." -- Douglas Adams
