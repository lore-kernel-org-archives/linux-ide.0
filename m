From: Avi Kivity <avi@redhat.com>
Subject: Re: Implementing NVMHCI...
Date: Tue, 14 Apr 2009 15:08:48 +0300
Message-ID: <49E47CD0.3090008@redhat.com>
References: <20090412091228.GA29937@elte.hu> <Pine.LNX.4.62.0904121806060.9521@tamago.serverit.net> <20090412162018.6c1507b4@lxorguk.ukuu.org.uk> <49E213AE.4060506@redhat.com> <alpine.LFD.2.00.0904120950050.4583@localhost.localdomain> <49E2DC96.6090407@redhat.com> <alpine.LFD.2.00.0904130747440.4583@localhost.localdomain> <49E45E9C.1020105@redhat.com> <49E46437.5000804@garzik.org> <49E46779.1040106@redhat.com> <49E47744.3040103@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:58794 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752816AbZDNMKw (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 14 Apr 2009 08:10:52 -0400
In-Reply-To: <49E47744.3040103@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Szabolcs Szakacsits <szaka@ntfs-3g.com>, Grant Grundler <grundler@google.com>, Linux IDE mailing list <linux-ide@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jens Axboe <jens.axboe@oracle.com>, Arjan van de Ven <arjan@infradead.org>

Jeff Garzik wrote:
>>> (c) export information indicating the true sector size, in a manner 
>>> similar to how the ATA driver passes that info to userland 
>>> partitioning tools.
>>
>> Eventually we'll want to allow filesystems to make use of the native 
>> sector size.
>
> At the kernel level, you mean?
>

Yes.  You'll want to align extents and I/O requests on that boundary.

>
> But if you are talking about filesystems directly supporting sector 
> sizes >4kb, well, I'll let Linus and others settle that debate :)  I 
> will just write the driver once the dust settles...

IMO drivers should expose whatever sector size the device have, 
filesystems should expose their block size, and the block layer should 
correct any impedance mismatches by doing RMW.

Unfortunately, sector size > fs block size means a lot of pointless 
locking for the RMW, so if large sector sizes take off, we'll have to 
adjust filesystems to use larger block sizes.

-- 
I have a truly marvellous patch that fixes the bug which this
signature is too narrow to contain.

