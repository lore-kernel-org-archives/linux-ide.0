From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Polling (was Re: [PATCHSET 2/2] implement PMP support, take 6)
Date: Fri, 28 Sep 2007 09:54:39 -0400
Message-ID: <46FD079F.3010007@garzik.org>
References: <1190521193410-git-send-email-htejun@gmail.com> <46F9BF3E.5050708@garzik.org> <46FA1B4E.8090103@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:41613 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751670AbXI1Nyq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 28 Sep 2007 09:54:46 -0400
In-Reply-To: <46FA1B4E.8090103@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Jeff Garzik wrote:
> [--snip--]
>> There, even the concept of "port" is fluid, and the libata EH model of
>> freezing and thawing a port (with the desired irq-off result) just
>> doesn't fit the hardware.
> 
> Well, the current model was developed while struggling with the first
> generation PMP hardware which had a lot of quirks.  More focus was on
> making the system run and keeping it that way.  Anyways, now that the
> quirks are better understood, I think we can make PMP register access
> irq-driven safely.
> 
> [--snip--]
>> As such, polling is simply an outmoded concept.  It does not make sense
>> on new hardware, and forcing design decisions down that path only lead
>> to a cascade of similar design decisions -- pmp_read polling being just
>> one example of such a result.
> 
> For pmp read/write, I agree that IRQ driven access would be better but
> even for fairly advanced controllers like ahci or sil24, I think
> resetting-by-polling is a good idea.

Not for SAS/SATA controllers.  These SAS+SATA controllers allow you set 
a bit initiating phy reset, and then receive an interrupt when something 
interesting happens.

The reason why I (we?) am just finding out about this is:  both 
drivers/scsi/libsas and drivers/scsi/ipr are still using the old-EH :(

But overall, anything sufficiently "high level" is not friendly to 
polling -- if a polling model is even possible.


>> Just like the Linux kernel MM platform API presents 3 levels of page
>> table entries, even when the hardware may only have 2, libata high level
>> API _must_ be implemented as 100% asynchronous event driven API.
> 
> Or allow both?
> 
>> If the default implementation chooses to use polling -- i.e. all SFF

Note the line quoted above, immediately following your response...  such 
a setup does permit both:  an asynchronous submit/complete API can be 
implementing under the hood via polling or irq, as the driver chooses.

The main point is to not /require/ polling.


>> controllers -- that's fine.  But in the new SAS/SATA world its clear
>> that we have far too many polling-related assumptions as it is.
>>
>> Polling just flat out doesn't make sense on modern SAS/SATA -- and even
>> a couple modern SATA controllers.  On such controllers, we are notified
>> immediately via interrupt even in the event of errors.
> 
> For SAS, I don't have any strong opinion.  For SATA, I think we
> definitely need to allow or even prefer polling for host port resets.
> 
> Is this NACK on the patchset or can we update PMP access later?

Sorry, yes, it is a NAK:  polling should not be requirement.

I considered making multi-protocol ->qc_issue() a requirement too, but 
that seemed like it might delay things too much.  But consider this a 
strong to-do item...  ->pmp_read and ->pmp_write hooks should be folded 
into ->qc_issue and ata_qc_complete(), because quite often a PMP 
read/write packet can be delivered just like any other packet.  We want 
a single "submit packet to hardware" interface, not multiple ones.

	Jeff



