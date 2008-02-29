From: Jeff Garzik <jeff@garzik.org>
Subject: Re: devres and requesting resources
Date: Fri, 29 Feb 2008 07:11:16 -0500
Message-ID: <47C7F664.5040102@garzik.org>
References: <47C75392.3020606@garzik.org> <20080229112651.5b2a7f6f@core>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:39937 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752366AbYB2MLT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 29 Feb 2008 07:11:19 -0500
In-Reply-To: <20080229112651.5b2a7f6f@core>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Tejun Heo <htejun@gmail.com>, Linux IDE mailing list <linux-ide@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

Alan Cox wrote:
>> In converting to pcim_iomap_regions(), we no longer reserve /all/ 
>> regions, only the ones requested.
>>
>> This is actually a bug:  it was intentional to call 
>> pci_request_regions(), because that ensures that no other software will 
>> use our resources -- even if we are not actively using the resource in 
>> question.
> 
> That would be a bug. We should only reserve the regions we are using. It
> is possible that the other regions can be used correctly by another driver
> (consider the CS5520 or the MPIIX where the IDE is only part of one
> function of the PCI device).

Only rare PCI devices are shareable among multiple drivers.

sata_* at least intentionally used pci_request_regions() because it is 
obvious from the hardware spec that multiple regions accessed by 
multiple drivers is highly unlikely, without the driver being 
specifically coded to support such sharing.  Such sharing code is far 
beyond simple resource reservation, to avoid stepping on toes when there 
is a single MMIO region and set of interrupt clearing registers.

So reading your email it sounds like there are valid cases for both 
configurations.

Its a design choice either way, not a bug either way.

	Jeff


