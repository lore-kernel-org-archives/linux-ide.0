From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 3/3] Make ide dma blacklist handling a bit saner.
Date: Mon, 28 May 2007 21:41:42 +0200
Message-ID: <200705282141.42507.bzolnier@gmail.com>
References: <20070521145042.GA6957@redhat.com> <7v3b1pbgeo.fsf_-_@assigned-by-dhcp.cox.net> <7vps4ta1iy.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:65097 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751314AbXE1VFp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 28 May 2007 17:05:45 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1705528ugf
        for <linux-ide@vger.kernel.org>; Mon, 28 May 2007 14:05:44 -0700 (PDT)
In-Reply-To: <7vps4ta1iy.fsf_-_@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux Kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Dave Jones <davej@redhat.com>


Hi,

On Tuesday 22 May 2007, Junio C Hamano wrote:
> Earlier, the matching of (model,rev) in ide-dma black/white list
> handling was to consider "ALL" in the table to match any
> revision.  This changes the wildcard to NULL.  This way, the
> DMA_BLACK_LIST macro used in the previous patch does not have to
> use a slightly funky compile time constant expression to convert
> NULL to "ALL".
> 
> Signed-off-by: Junio C Hamano <junkio@cox.net>

The change itself looks good but IMO it is worth doing it before patch #2/3
(it would also make it possible for me to merge this patch immediately).

When it comes to patch #2 - Alan's comment may be a bit harsh but he seems
to be right - there should be a common library-like file (ata-blacklist.c
or ata-quirks.c or whatever name you like) containing ata_device_blacklist[].

This would require slight modification of ide_in_drive_list() to teach
it about ATA_HORKAGE_DMA but as I see from this patch this shouldn't be
a problem for you. ;)  Please also note that <linux/ata.h> is used by both
IDE and libata so it should be a good place to put struct ata_blacklist_entry
and ATA_HORKAGE_* macros.

Care to respin both patches?

>  * I do not really know what I am doing in the mips area, but
>    that architecture specific table seems to be used by the same
>    ide_in_drive_list() function, so the entries are matched to
>    the updated code.

Yep, thanks for not breaking AMD Alchemy IDE suppport.

It looks like au1xxx_ide.h should really be in drivers/ide/mips because
it is only included from drivers/ide/mips/au1xxx_ide.c - could somebody
verify this and send me a patch?

Thanks,
Bart
