From: Grozdan <neutrino8@gmail.com>
Subject: Re: Kernel 2.6.30rc7 limits IDE to UDMA33
Date: Sun, 7 Jun 2009 20:24:11 +0200
Message-ID: <c5bd819b0906071124j21270574h44db963bdc0b552d@mail.gmail.com>
References: <c5bd819b0906021525l13ee9282j1fb270e141985f66@mail.gmail.com>
	 <c5bd819b0906040750w75e0389cod2a03b89ce838d1b@mail.gmail.com>
	 <20090605100505.41b3b818@lxorguk.ukuu.org.uk>
	 <c5bd819b0906050335i4e813887sc8f4d901da86a1aa@mail.gmail.com>
	 <20090605114245.175499e1@lxorguk.ukuu.org.uk>
	 <4A29C163.3080706@gmail.com>
	 <20090606155636.18bc4f2e@lxorguk.ukuu.org.uk>
	 <4A2AB298.7020603@gmail.com>
	 <c5bd819b0906062139s4d8eea3eq2fc21f37deb6172b@mail.gmail.com>
	 <4A2BF785.3020402@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f210.google.com ([209.85.219.210]:35950 "EHLO
	mail-ew0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753290AbZFGSYK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 7 Jun 2009 14:24:10 -0400
In-Reply-To: <4A2BF785.3020402@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, tj@kernel.org, alan@lxorguk.ukuu.org.uk

2009/6/7 Robert Hancock <hancockrwd@gmail.com>:
> Grozdan wrote:
>>
>> 2009/6/6 Robert Hancock <hancockrwd@gmail.com>:
>>>
>>> Thing is somehow the GTM detection isn't working now and it apparently
>>> was
>>> in 2.6.27.1. I'm not seeing any patches to pata_via or libata-acpi that
>>> seem
>>> like they would affect this offhand. Grozdan, would you be able to try
>>> git
>>> bisect to try to figure out what changed the behavior?
>>>
>>> CCing Tejun in case he has any ideas..
>>>
>>
>> I've no idea how and where to do a git bisect so if someone is willing
>> to explain in simple steps, I can try...
>
> Linus's post on here is a pretty simple explanation:
>
> http://kerneltrap.org/node/11753
>

Yes, it's clear to someone who's familiar with git but not to a noob
like me. Where do I run this git? After it's finished what to do next?
How many times do I have to compile kernels? Which kernels exactly?
After booting a "bad" kernel, what then? etc... From reading the
article, the guy has to compile 14!! times just to catch a problem
between kernel 2.6.21 and 2.6.22. I guess in my case I'll have to
compile a lot more than 14 times to catch something between kernel
2.6.27 and 2.6.30 and honestly I don't have time for this right now.
However, I did a diff between the pata_via driver of kernel 2.6.27 and
2.6.30 and there have been changes to it but I'm not sure if they
affect the cable detection...
