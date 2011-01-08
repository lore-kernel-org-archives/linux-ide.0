From: Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: CF Card Adapter White List Candidate
Date: Sat, 08 Jan 2011 13:48:21 +0300
Message-ID: <4D2840F5.10907@msgid.tls.msk.ru>
References: <186863.99156.qm@web112005.mail.gq1.yahoo.com> <AANLkTi=u7eqjdY9QWOOgiWK3VMEZwLxVvZjHdreELhV1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from isrv.corpit.ru ([86.62.121.231]:47092 "EHLO isrv.corpit.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751230Ab1AHKsY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 8 Jan 2011 05:48:24 -0500
In-Reply-To: <AANLkTi=u7eqjdY9QWOOgiWK3VMEZwLxVvZjHdreELhV1@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: Tom Denchfield <td_denchfield@yahoo.com>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

07.01.2011 07:22, Robert Hancock wrote:
> On Wed, Jan 5, 2011 at 11:33 PM, Tom Denchfield <td_denchfield@yahoo.com> wrote:
>> The reason that I mentioned powering my CF adapter with a floppy drive power plug is that the first time I booted after inserting the adapter, I forgot to plug the floppy drive power plug into the adapter.  The adapter's power on LED did not light, and I think that Ubuntu did not see the CF card.
>>
>> The reason that I mentioned the pin that was intentionally left out of the motherboard IDE socket was that I thought that the missing pin might have had something to do with needing to power the adapter with the floppy drive power plug given my experience with forgetting to plug the floppy power plug into the adapter as mentioned in the previous paragraph.
>>
>> The pin that is missing from the motherboard IDE socket is very close to the middle of the IDE socket.  My guess is that the pin is in the in the range #18 to #24.  It is far away from pin #34.  I am going by memory here, but I clearly remember that the missing pin is in the middle.  Pin #34 is going into the CF card adapter when I insert it.  I do not know whether pin #34 is grounded at the mainboard.
> 
> If it's pin 20, that's a key pin that's always missing and which has
> the corresponding hole filled in on the cable side (from compliant
> connectors, anyway), to prevent plugging in the cable the wrong way
> around.
> 
> Not sure where the adapter would be potentially drawing power from on
> the IDE connector - as far as I know there aren't any pins on a
> standard IDE connector which provide continuous power. The adapters
> I've seen all use an extra power connector.

The 20th pin is actually used on some VIA EPIA (mini-itx) motherboards,
exactly for this purpose: to provide power for CF cards like this.
Some IDE to CF adaptors can be set up (with a jumper) to ger power
to the card from there.

/mjt
