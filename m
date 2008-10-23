From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 4/4] libata: clean up the SFF code for coding style
Date: Wed, 22 Oct 2008 20:35:42 -0400
Message-ID: <48FFC6DE.7060605@garzik.org>
References: <20081017180655.7781.15021.stgit@localhost.localdomain>	<20081017180903.7781.51521.stgit@localhost.localdomain>	<874p34ska1.fsf@denkblock.local> <20081022170218.32122780@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:46315 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752058AbYJWAfv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 22 Oct 2008 20:35:51 -0400
In-Reply-To: <20081022170218.32122780@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Elias Oltmanns <eo@nebensachen.de>, linux-ide@vger.kernel.org

Alan Cox wrote:
>>>  		if (ata_is_atapi(qc->tf.protocol) &&
>>> -		    !(qc->dev->flags & ATA_DFLAG_CDB_INTR))
>>> +		   !(qc->dev->flags & ATA_DFLAG_CDB_INTR))
>> Ditto.
> 
> Its lining up the bracketing but hey I'm not fussed, just twiddling where
> checkpatch warned and the like.
> 
>>> - err_out:
>>> +err_out:
>> Yes, I've wondered about these myself occasionally. Personally, I don't
>> insert a blank before those labels either and would be in favour of such
>> a change. But do we actually have a convention regarding this matter?
> 
> CodingStyle chapter 7 which is of course overridable by Jeff ;)

libata style has always matched that:  labels go in column 1, without 
any preceding whitespace.

	Jeff



