From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 05/12] libata: xfer_mask is unsigned int not unsigned
 long
Date: Tue, 06 Nov 2007 12:53:14 -0500
Message-ID: <4730AA0A.4090904@garzik.org>
References: <1194327550227-git-send-email-htejun@gmail.com>	<11943275501285-git-send-email-htejun@gmail.com> <20071106105151.2e3d15b8@the-village.bc.nu> <473048F7.2050004@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:43056 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754503AbXKFRxU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Nov 2007 12:53:20 -0500
In-Reply-To: <473048F7.2050004@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Alan Cox wrote:
>> On Tue,  6 Nov 2007 14:39:03 +0900
>> Tejun Heo <htejun@gmail.com> wrote:
>>
>>> xfer_mask is unsigned int not unsigned long.  Change ->mode_filter to
>>> take and return unsigned int.
>>>
>>> While at it, rename @adev of ata_pci_default_filter() to @dev for
>>> consistency.
>>>
>>> Signed-off-by: Tejun Heo <htejun@gmail.com>
>> The filter type was purposefully unsigned long to allow for expansion (eg
>> for SWDMA) without breaking drivers. No problem with it changing but I'd
>> say "unsigned int" was the worst possible choice - its now shorter (no
>> room for expansion) and size dependant on arch. u32 would be shorter and
>> consistent across all platforms, ulong would have more room for expansion.
> 
> I agree it should be one of u* types and am happy to convert.  This
> patch is primarily for consistency as in libata-core, xfer_mask is
> unsigned int.  My first proposal was u32 too but Jeff vetoed it.  IIRC,
> Jeff has affection for machine-independent integral types.  :-)
> 
> Anyways, I think ulong is worse than uint because ulong differs in size
> between 32 and 64 archs.  What's the good of extra 32bits in flags space
> if it's not there on 32bit archs?  Also, we currently only use 20bits of
> xfermask, 12 extra bits seem enough for the time, especially as
> everything is moving over to SATA where xfermode doesn't really matter, no?
> 
> Jeff, are you okay with u32 or 64?

unsigned long is IMO the best choice for bitmaps.

* it is a machine int on all(?) architectures

* it is 32-bit on 32-bit architectures

* it is consistent with test_bit(), set_bit() and lib/bitmap.c interfaces

* conversion to test_bit() and lib/bitmap.c interfaces as a future step 
is trivial

* your structs inflate on 64-bit due to pointers anyway, so I see little 
real consequence to using the lower 32 bits of an unsigned long as a 
portable meme.

	Jeff


