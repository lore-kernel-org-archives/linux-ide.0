From: Mark Lord <liml@rtr.ca>
Subject: Re: sata_mv: hard resetting port
Date: Wed, 14 Nov 2007 23:12:36 -0500
Message-ID: <473BC734.9090301@rtr.ca>
References: <473AC34B.8000709@wpkg.org> <473B13D6.3080202@rtr.ca> <473B1617.4010102@wpkg.org> <473B1E39.8090800@rtr.ca> <473BBEDB.80000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:3944 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754968AbXKOEMi (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 14 Nov 2007 23:12:38 -0500
In-Reply-To: <473BBEDB.80000@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Tomasz Chmielewski <mangoo@wpkg.org>, Linux IDE <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> Mark Lord wrote:
>> Tomasz Chmielewski wrote:
>>> Is there an online Kernelish-English dictionary anywhere? ;)
>> ..
>>
>> Unfortunately not.
>>
>> At some point, we *really* need to convice {Tejun,Jeff} that libata
>> messages should be simpler, fewer, and more human readable by default,
>> with perhaps a sysfs flag to re-enable the {Tejun,Jeff}-speak versions.
> 
> Ummm... Okay.  That might have something to do with me not being a
> native speaker.  :-)
> 
> I agree that the current message looks too scary and detailed.  Yeah,
> essages for recovered errors can be shorter and sweeter.  Those messages
> are pretty helpful to developers tho.  Always having duplicate SCSI
> messages don't help either.
> 
> Thanks.  I'm putting it on the todo list but I have to admit it is of
> low priority ATM.
..

Nothing bad intended by that.. I can read the current messages just fine :)
though there do seem to be a *lot* of them.

But that is good for libata, in it's current level of immaturity and rapid
development.  In a release or three, once things settle down a bit,
we'll likely feel more pressure to make things understandable by others.

Cheers
