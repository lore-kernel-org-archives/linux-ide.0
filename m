From: Ericisko <linux2@rogers.com>
Subject: Re: Pata support on Promise controller under Fedora Core 3
Date: Tue, 26 Oct 2004 07:17:46 -0400 (EDT)
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20041026111746.12695.qmail@web88002.mail.re2.yahoo.com>
References: <019801c4ba4f$451d7e40$0a01a8c0@jbsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web88002.mail.re2.yahoo.com ([206.190.37.189]:20595 "HELO
	web88002.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S262246AbUJZLRw (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 26 Oct 2004 07:17:52 -0400
In-Reply-To: <019801c4ba4f$451d7e40$0a01a8c0@jbsys.com>
List-Id: linux-ide@vger.kernel.org
To: "James  C. Bevier" <jbev@jbsys.com>, Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

James,

I don't have any additional code. I quickly tested it
on my system (PDC20378) and both drives were
recognized.
However, I've got hard lockup after about 1 min. It is
with vanilla 2.6.9-rc3, smp, preempt enabled. Didn't
have time to investigate further.
Are your drives recognized by BIOS? Also, AFAIK PATA
port on 378 supports only ATA (disk) drives, not ATAPI
drives (CD/DVD). Is your second drive disk or CD/DVD?

  Erik

 --- "James  C. Bevier" <jbev@jbsys.com> wrote: 
> Jeff,
> 
> I cut out the attached patch from the sata_promise
> dev patches on kernel.org.  I 
> put it in the latest kernel in Fedora Core 3 RC1. 
> It is version 2.6.9-1.640 
> kernel.  It works well enough to be able to see the
> first PATA drive on the 
> Promise controller.  It does not see the second
> drive.  The code only seems to 
> work for one drive.  Could you (or Erik) provide the
> rest of the code that will 
> see the second drive.  If you could point me to
> specs for the controller or give 
> me the register offset for the last drive, I could
> try to hack at it myself.  I 
> really need this to work in Fedora Core 3.
> 
> Thanks for your help!
> 
> Jim Bevier 
> 

> ATTACHMENT part 2 application/octet-stream
name=linux-2.6.9-sata_promise.patch
 
