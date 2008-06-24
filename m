From: Mark Lord <mlord@pobox.com>
Subject: Re: FW: ICH10R PMP support
Date: Tue, 24 Jun 2008 03:15:44 -0400
Message-ID: <48609F20.4060608@pobox.com>
References: <023701c8d4dd$d737fa10$85a7ee30$@com>
 <485F6830.1040000@pobox.com> <485F7356.5050605@kernel.org>
 <48609C8F.90805@pobox.com> <48609E01.1050802@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:48459 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751898AbYFXHQJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 24 Jun 2008 03:16:09 -0400
In-Reply-To: <48609E01.1050802@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Milo Medin <medin@m2znetworks.com>, linux-ide@vger.kernel.org, Grant Grundler <grundler@google.com>

Tejun Heo wrote:
> Mark Lord wrote:
>> Tejun Heo wrote:
>>> Mark Lord wrote:
>> ..
>>>> The 7042 is the best of the Marvell chips, for Linux.
>>> How high does it go bandwidth-wise?
>> ..
>>
>> The limiting factor will be the bus width of the card
>> and the slot into which it is plugged, I suspect.
..

Note that this has yet to be confirmed in practice,
though I don't know if anyone has really tried hard yet.

Perhaps Grant Grundler ? 

..
> Cool.  I was asking because sil3124 and 32 seem to have inherent
> bandwidth limit regardless of the bus it lives on.  I'm planning on
> checking out 3132-2 chips to see whether they improved on that front.
..

Cheers
-- 
Mark Lord
Real-Time Remedies Inc.
mlord@pobox.com
