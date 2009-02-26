From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: ATA support for 4k sector size
Date: Thu, 26 Feb 2009 00:16:00 -0500
Message-ID: <yq1eixlg4mn.fsf@sermon.lab.mkp.net>
References: <1235600698-6446-1-git-send-email-matthew@wil.cx>
	<49A5CBF7.9000501@zytor.com> <yq1hc2iumg9.fsf@sermon.lab.mkp.net>
	<20090226025043.GJ1363@mit.edu>
	<20090226030735.GA16891@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rcsinet13.oracle.com ([148.87.113.125]:29007 "EHLO
	rgminet13.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750908AbZBZFRG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Feb 2009 00:17:06 -0500
In-Reply-To: <20090226030735.GA16891@parisc-linux.org> (Matthew Wilcox's message of "Wed\, 25 Feb 2009 20\:07\:35 -0700")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: Theodore Tso <tytso@mit.edu>, "Martin K. Petersen" <martin.petersen@oracle.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, sandeen@redhat.com

>>>>> "Matthew" == Matthew Wilcox <matthew@wil.cx> writes:

Matthew> Lowest aligned logical block address=0

Matthew> This disagrees with Martin's assertion.

Quick answer from one of my contacts.  Desktop drives will indeed ship
with an alignment of 1(*).  The alignment is hardwired at time of
manufacture and can't be changed.

(*) I had to go back and reread the ATA spec to grok this.  READ
CAPACITY(16) indicates the lowest naturally aligned LBA.  With LBA 63
offset in play that would be LBA 7.

ATA, on the other hand, indicates how much LBA 0 is offset from the
beginning of the first physical sector.  If LBA 63 is naturally aligned
that means that LBA 0 is offset 512 bytes (physical sector 0 starts at
LBA -1 if you will). Hence IDENTIFY DEVICE word 209 will contain 0x4001.

So you need to tweak your RC16 response a bit...

-- 
Martin K. Petersen	Oracle Linux Engineering
