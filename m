From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] libata-core More robust parsing for multi_count(v5)
Date: Sat, 21 Mar 2009 09:54:04 -0400
Message-ID: <49C4F17C.2030708@rtr.ca>
References: <49C1047D.4000008@rtr.ca>	<49C11A0C.3070502@rtr.ca> <49C11ED4.2030307@rtr.ca>	<49C19087.5000307@gmail.com> <49C190F1.7010202@kernel.org>	<49C28133.8050401@rtr.ca> <49C281A5.5080404@rtr.ca>	<49C2D642.90706@kernel.org> <49C39690.6090802@rtr.ca>	<49C396CF.7030202@rtr.ca> <20090320140714.2e7770d0@lxorguk.ukuu.org.uk> <49C3B7E9.2000505@rtr.ca> <49C4235D.5070303@kernel.org> <49C43ABA.4010601@pobox.com> <49C44E53.4020409@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:36411 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752737AbZCUNyN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 21 Mar 2009 09:54:13 -0400
In-Reply-To: <49C44E53.4020409@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, IDE/ATA development list <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> Jeff Garzik wrote:
>> Yeah, that has long been a design decision -- avoid all the mechanics of
>> PIO-Multi, simply because we did not have much of a need for it (and
>> still don't).
>>
>> Albert Lee worked on PIO-Multi a while ago, which was mainly to get
>> ATA_{12,16} working, IIRC.
>>
>> But overall, I don't see much of a need to introduce it into the main
>> stack?
> 
> Well, there still are awful lot of PIO only devices out in the wild,
> so improving PIO support seems like a good idea?
..


Tons of CompactFlash cards are used PIO-only with Linux,
and systems could benefit from the reduced interrupt overhead
that multiple gives.  Especially since those same systems tend
to have rather modest embedded CPUs.

We *already* do multiple-sector I/O in libata.
But it currently works partially by accident,
and probably gets shut off much of the time
whenever the EH code is invoked and resets anything.

Cheers

