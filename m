From: Jeff Garzik <jeff@garzik.org>
Subject: Re: AHCI: using bios after linux
Date: Fri, 12 Oct 2007 17:02:37 -0400
Message-ID: <470FE0ED.4050302@garzik.org>
References: <20071012182726.37EFB4702DA@web2mail.com> <20071012215734.4b5b4bce@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:49688 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757332AbXJLVCm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 12 Oct 2007 17:02:42 -0400
In-Reply-To: <20071012215734.4b5b4bce@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: msundius@u1.netgate.com, msundius@sundius.com, xuxiang_ins@yahoo.com, linux-ide@vger.kernel.org

Alan Cox wrote:
>> 3) related to #1 above, we want to be invisable. so we're not looking to
>> switch from AHCI (to legacy), we are looking to continue in whatever mode
>> the BIOS started in. Thus we just want BIOS to be able to handle int13 calls
>> after the Linux AHCI driver has run (this works when BIOS is setup in 
>> legacy mode initially).
> 
> So load the ata_piix driver and not the AHCI one and I think it'll work
> out ?

Sane advice under the circumstances, I suppose.

Overall, its a repeat of a fundamental problem...  we might be resetting 
the HBA, restarting the port, or any number of things that the BIOS 
doesn't know about.

I tend to think making such calls will largely rely on luck, without 
some sort of in-kernel synchronization.  Smart controllers do this sort 
of stuff, but that's a different case from the one here.  Here we have 
competing pieces of software, each unaware of the other.

	Jeff



