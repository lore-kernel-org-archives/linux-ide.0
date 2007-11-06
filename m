From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 05/12] libata: xfer_mask is unsigned int not unsigned
 long
Date: Tue, 06 Nov 2007 19:59:03 +0900
Message-ID: <473048F7.2050004@gmail.com>
References: <1194327550227-git-send-email-htejun@gmail.com>	<11943275501285-git-send-email-htejun@gmail.com> <20071106105151.2e3d15b8@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.237]:45156 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755912AbXKFK7M (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Nov 2007 05:59:12 -0500
Received: by nz-out-0506.google.com with SMTP id s18so1312750nze
        for <linux-ide@vger.kernel.org>; Tue, 06 Nov 2007 02:59:11 -0800 (PST)
In-Reply-To: <20071106105151.2e3d15b8@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org

Alan Cox wrote:
> On Tue,  6 Nov 2007 14:39:03 +0900
> Tejun Heo <htejun@gmail.com> wrote:
> 
>> xfer_mask is unsigned int not unsigned long.  Change ->mode_filter to
>> take and return unsigned int.
>>
>> While at it, rename @adev of ata_pci_default_filter() to @dev for
>> consistency.
>>
>> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> The filter type was purposefully unsigned long to allow for expansion (eg
> for SWDMA) without breaking drivers. No problem with it changing but I'd
> say "unsigned int" was the worst possible choice - its now shorter (no
> room for expansion) and size dependant on arch. u32 would be shorter and
> consistent across all platforms, ulong would have more room for expansion.

I agree it should be one of u* types and am happy to convert.  This
patch is primarily for consistency as in libata-core, xfer_mask is
unsigned int.  My first proposal was u32 too but Jeff vetoed it.  IIRC,
Jeff has affection for machine-independent integral types.  :-)

Anyways, I think ulong is worse than uint because ulong differs in size
between 32 and 64 archs.  What's the good of extra 32bits in flags space
if it's not there on 32bit archs?  Also, we currently only use 20bits of
xfermask, 12 extra bits seem enough for the time, especially as
everything is moving over to SATA where xfermode doesn't really matter, no?

Jeff, are you okay with u32 or 64?

-- 
tejun
