From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [RFT] major libata update
Date: Mon, 15 May 2006 23:51:43 -0400
Message-ID: <44694C4F.3000008@garzik.org>
References: <20060515170006.GA29555@havoc.gtf.org>	 <3aa654a40605151630j53822ba1nbb1a2e3847a78025@mail.gmail.com>	 <446914C7.1030702@garzik.org> <3aa654a40605152036h40fa1cd0x8edd81431c1bd22d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:61402 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751239AbWEPDvr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 15 May 2006 23:51:47 -0400
In-Reply-To: <3aa654a40605152036h40fa1cd0x8edd81431c1bd22d@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Avuton Olrich <avuton@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org

Avuton Olrich wrote:
> On 5/15/06, Jeff Garzik <jeff@garzik.org> wrote:
>> Avuton Olrich wrote:
>> > On 5/15/06, Jeff Garzik <jeff@garzik.org> wrote:
>> >> * sata_sil and ata_piix also need healthy re-testing of all basic
>> >> functionality.
>> >
>> > I'm testing it right now, but with 2.6.17-rc4-git2 I was getting:
>>
>> Testing what?  sata_sil?  Please provide full dmesg, there's a lot of
>> missing information.
> 
> More followup, it did finally error out on me:
> 
> Not sure if it helps any, but this is a sata2 disk with a sata
> interface. This is rc4-git2 with the libata patch from the beginning
> of this thread, using sata_sil.

Can you configure your interrupts so that ethernet and SATA are not on 
the same irq?

Also, please provide _full_ dmesg and _full_ lspci, not just the 
SATA-related stuff.  This looks motherboard- or hardware-related.

	Jeff



