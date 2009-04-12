From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] sata_sx4: refresh and convert to new EH
Date: Sun, 12 Apr 2009 07:19:02 -0400
Message-ID: <49E1CE26.9050401@garzik.org>
References: <20090408200511.GA24071@havoc.gtf.org> <a4423d670904111946w2a8f3839n27b77f5473076563@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:44991 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754655AbZDLLTF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 12 Apr 2009 07:19:05 -0400
In-Reply-To: <a4423d670904111946w2a8f3839n27b77f5473076563@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alexander Beregalov <a.beregalov@gmail.com>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Alexander Beregalov wrote:
> 2009/4/9 Jeff Garzik <jeff@garzik.org>:
>> I reviewed and refreshed libata-dev.git#new-eh, now renamed to #sx4.
>>
>> Several bugs and missing pieces in the new-EH conversion were addressed
>> (often by copying highly similar code from sata_promise, a highly
>> similar chip)
>>
>> The only thing left is some "it still works" testing...  any takers?
>>
> 
> Hi Jeff
> 
> I have SX4000 card, it is based on the same PDC20621 chip, but has PATA ports
> (without PATA-SATA bridges).
> Can I help?
> 
> I am newbie here, but I will try to modify the driver to support PATA
> card as well
> and test your patch.

It's unknown how well, or what is needed, to support the SX4000.  You 
are welcome to dive in and figure out what is needed, but you'd be 
asking questions to which we wouldn't have answers.

	Jeff




