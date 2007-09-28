From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Polling (was Re: [PATCHSET 2/2] implement PMP support, take 6)
Date: Fri, 28 Sep 2007 11:22:50 -0400
Message-ID: <46FD1C4A.8010101@garzik.org>
References: <1190521193410-git-send-email-htejun@gmail.com> <46F9BF3E.5050708@garzik.org> <46FA1B4E.8090103@gmail.com> <46FD079F.3010007@garzik.org> <46FD0D50.8030602@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:57982 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752045AbXI1PWw (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 28 Sep 2007 11:22:52 -0400
In-Reply-To: <46FD0D50.8030602@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Jeff Garzik wrote:
>>> Is this NACK on the patchset or can we update PMP access later?
>> Sorry, yes, it is a NAK:  polling should not be requirement.
>>
>> I considered making multi-protocol ->qc_issue() a requirement too, but
>> that seemed like it might delay things too much.  But consider this a
>> strong to-do item...  ->pmp_read and ->pmp_write hooks should be folded
>> into ->qc_issue and ata_qc_complete(), because quite often a PMP
>> read/write packet can be delivered just like any other packet.  We want
>> a single "submit packet to hardware" interface, not multiple ones.
> 
> Aieee... Another merge delay.  I wish the review process proceeded a bit
> swifter.   The patchset has been around literally for years now and
> submitted for review six times if I have the take number right.  :-(

Well the vast majority of the patches are in, what five out of six 
original patchsets?

Sorry I didn't catch the polling requirement beforehand, it was not 
really clear from a quick read.

	Jeff



