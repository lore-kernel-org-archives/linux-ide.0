From: manoj.iyer@canonical.com
Subject: Re: ATA taskfile register returns 0xd0 on resume.
Date: Tue, 28 Apr 2009 17:02:00 -0500 (CDT)
Message-ID: <alpine.DEB.2.00.0904281700590.30659@hungry>
References: <alpine.DEB.2.00.0904141312270.8011@hungry> <alpine.DEB.2.00.0904141515010.4289@hungry> <49E509AB.9010004@gmail.com> <alpine.DEB.2.00.0904141719100.4289@hungry> <49E510B6.3080404@gmail.com> <alpine.DEB.2.00.0904150150530.4289@hungry>
 <49E58630.2050401@gmail.com> <alpine.DEB.2.00.0904151747180.4289@hungry> <49EFF722.7030804@gmail.com> <alpine.DEB.2.00.0904232016230.18217@hungry> <49F2BE21.702@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:51165 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753312AbZD1WCU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 28 Apr 2009 18:02:20 -0400
In-Reply-To: <49F2BE21.702@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: manoj.iyer@canonical.com, linux-ide@vger.kernel.org


Tejun,

Sorry for the delayed reponds, I was away for the weekend. I tried the 
same tests with kernel option irqpoll and that did not make any 
difference, I get the same errors I reported earlier.

Cheers
--- manjo

On Sat, 25 Apr 2009, Tejun Heo wrote:

> manoj.iyer@canonical.com wrote:
>>
>> Tejun,
>>
>> I compiled 2.6.29 with your patch, and ran the suspend resume tests.
>>
>> 1. Suspend with AC power connected - resume with AC connected - ok
>> 2. suspend with AC power disconnected - resume with AC disconnected - ok
>> 3. suspend with AC power connected - resume with AC connected - ATA errors.
>>
>> I have attached the dmesg output and the kern.log output as you requested.
>
> Hmmm... does irqpoll help?
>
> -- 
> tejun
>
