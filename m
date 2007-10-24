From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [git patches] IDE updates (part 2)
Date: Wed, 24 Oct 2007 08:53:09 -0400
Message-ID: <471F4035.4030507@garzik.org>
References: <200710131825.24768.bzolnier@gmail.com> <20071014001238.GP8181@ftp.linux.org.uk> <4713C568.2060708@garzik.org> <20071015195807.GF8759@flint.arm.linux.org.uk> <4713C893.3050200@garzik.org> <20071024123851.GB32333@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:36061 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756172AbXJXMxW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 24 Oct 2007 08:53:22 -0400
In-Reply-To: <20071024123851.GB32333@flint.arm.linux.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Al Viro <viro@ftp.linux.org.uk>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Russell King wrote:
> On Mon, Oct 15, 2007 at 04:07:47PM -0400, Jeff Garzik wrote:
>> Russell King wrote:
>>> On Mon, Oct 15, 2007 at 03:54:16PM -0400, Jeff Garzik wrote:
>>>> Al Viro wrote:
>>>>> Proposed addition to icside part, provided that ARM folks ACK it - gets
>>>>> icside to build and AFAICS it's correct:
>>>> ACK from me too...  ARM folks?
>>> Will test tomorrow/Wednesday.
>> Thanks.  Sorry about missing your CC on the libata-wide ata_link 
>> changes.  We should have poked the maintainers on that, for the drivers 
>> we cannot build ourselves.
> 
> I think Viro's patch got an ack from everyone.  Who's dealing with getting
> this regression fix into mainline?  It seems at the moment the patch is in
> limbo.

I was waiting on you, who last said "Will test tomorrow/Wednesday" (with 
presumably an ACK forthcoming after test results)

If it now has your ACK, it's ready and waiting in my mbox queue to be 
merged upstream.

	Jeff



