From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [PATCH] libata_acpi: A different strategy for using ACPI
 information
Date: Tue, 03 Jul 2007 17:53:58 -0600
Message-ID: <468AE196.9070202@shaw.ca>
References: <fa.rEwk8NvbygVfpOfb23QZ97ZMeXs@ifi.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:63223 "EHLO
	pd3mo1so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751529AbXGCXyh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Jul 2007 19:54:37 -0400
In-reply-to: <fa.rEwk8NvbygVfpOfb23QZ97ZMeXs@ifi.uio.no>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, jeff@garzik.org

Alan Cox wrote:
> Lots of BIOSen simply return the BIOS set modes via the ACPI methods and
> pass back the values you give it across suspend/resume. Thus instead of
> trying to do clever stuff with this data we instead use it as a way to
> take a sneak peak at cable type information when viable. This should help
> us catch more of the laptops that do weird stuff, the VIA SATA bridges
> and the totally horked Nvidia cable handling.
> 
> For now its only used by the VIA and AMD/NV driver until we get a better
> idea of whether this is a sensible idea or not.
> 
> Opinions ?
> 
> Signed-off-by: Alan Cox <alan@redhat.com>

Looks fairly reasonable to me. However, I suspect any use of _GTM is 
somewhat dangerous (at least after the resume) unless we use the _STM 
and _GTF methods in the proper sequence when resuming. (Is that in the 
-mm tree now?)

Keep in mind that in the pata_acpi case where we don't do anything to 
program the hardware directly, we can still use _STM to program a lower 
speed than the BIOS chose if we decide to do this. Windows does indeed 
do this (you can force PIO mode in the control panel, and it will also 
reduce UDMA speeds or drop to PIO if there are too many CRC errors or 
timeouts), so this should be safe. We just had better be sure that the 
speed we give it is valid, since there is no sane way for the function 
to indicate failure. (Thus the problem with the "cram in all possible 
values to see what it supports" strategy for determining mode limits..)

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

