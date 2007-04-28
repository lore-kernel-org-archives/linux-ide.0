From: Mark Lord <liml@rtr.ca>
Subject: Re: libata fails to recover from HSM violation involving DRQ status
Date: Sat, 28 Apr 2007 16:44:37 -0400
Message-ID: <4633B235.6060401@rtr.ca>
References: <4633AB75.7070107@rtr.ca> <4633B0A6.6090705@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:3341 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964935AbXD1Uok (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 28 Apr 2007 16:44:40 -0400
In-Reply-To: <4633B0A6.6090705@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <htejun@gmail.com>, Alan Cox <alan@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Jeff Garzik wrote:
> Mark Lord wrote:
>..
>> I triggered this by accident, issuing an IDENTIFY command
>> which incorrectly specified ATA_PROT_NODATA.  My error, for sure,
>> but libata never recovered from the "stuck DRQ bit" that resulted.
..
> Maybe we do need to recover from a stuck DRQ bit, but I'll wait until 
> that symptom shows up with a different catalyst.

It's a failure mode that occurs very often (as far as failures go)
with the IDE driver.  *Lots* of occurance.

So as more things migrate to libata, we'll eventually have to deal
with it here, too.  I'm just trying to give us a chance to fix it
before somebody loses data over it.

Actually, I'm not so sure that this problem hasn't *already* been
posted to this very mailing list.

http://lkml.org/lkml/2006/10/1/264
http://www.mail-archive.com/linux-ide@vger.kernel.org/msg05078.html
...

Cheers
