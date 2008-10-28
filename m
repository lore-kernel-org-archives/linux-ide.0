From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 4/4] libata: clean up the SFF code for coding style
Date: Tue, 28 Oct 2008 10:49:31 +0900
Message-ID: <49066FAB.2080101@kernel.org>
References: <20081017180655.7781.15021.stgit@localhost.localdomain>	<20081017180903.7781.51521.stgit@localhost.localdomain>	<874p34ska1.fsf@denkblock.local> <20081022170218.32122780@lxorguk.ukuu.org.uk> <48FFC6DE.7060605@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:53311 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752041AbYJ1Btz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 27 Oct 2008 21:49:55 -0400
In-Reply-To: <48FFC6DE.7060605@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Elias Oltmanns <eo@nebensachen.de>, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Alan Cox wrote:
>>>>          if (ata_is_atapi(qc->tf.protocol) &&
>>>> -            !(qc->dev->flags & ATA_DFLAG_CDB_INTR))
>>>> +           !(qc->dev->flags & ATA_DFLAG_CDB_INTR))
>>> Ditto.
>>
>> Its lining up the bracketing but hey I'm not fussed, just twiddling where
>> checkpatch warned and the like.
>>
>>>> - err_out:
>>>> +err_out:
>>> Yes, I've wondered about these myself occasionally. Personally, I don't
>>> insert a blank before those labels either and would be in favour of such
>>> a change. But do we actually have a convention regarding this matter?
>>
>> CodingStyle chapter 7 which is of course overridable by Jeff ;)
> 
> libata style has always matched that:  labels go in column 1, without
> any preceding whitespace.

Heh... I am the one who is always putting in the extra space there,
mainly because emacs dictates how I format my code. :-) I'll try to turn
it off.

Thanks.

-- 
tejun
