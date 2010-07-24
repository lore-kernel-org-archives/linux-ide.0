From: Greg Freemyer <greg.freemyer@gmail.com>
Subject: Re: support for drives larger than 2TiB
Date: Sat, 24 Jul 2010 17:38:49 -0400
Message-ID: <AANLkTi=-0Hdp2dfK_RB=w-W8Qm8O42dDM0ybEcRtEMdn@mail.gmail.com>
References: <4C4AB952.9030705@kernel.org>
	<SNT125-W4469FAC3FE110BB4882949C3A40@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:39802 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750898Ab0GXViu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 24 Jul 2010 17:38:50 -0400
In-Reply-To: <SNT125-W4469FAC3FE110BB4882949C3A40@phx.gbl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Yuhong Bao <yuhongbao_386@hotmail.com>
Cc: tj@kernel.org, jeff@garzik.org, ben.collins@ubuntu.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, hmh@debian.org

On Sat, Jul 24, 2010 at 2:40 PM, Yuhong Bao <yuhongbao_386@hotmail.com> wrote:
>
>> However, 2TiB limit is
>> inherent in the BIOS programming interface and currently the only way
>> to overcome it is using a completely different BIOS interface (EFI,
>> that is).
> Nope, look at the Int13 extensions, it already support 64-bit LBA.
>
> Yuhong Bao

64-bit LBA?  I assume you meant 48-bit LBA from ATA-7.  It will
address up to PBs I believe.  (KB, MB, GB, TB, PB, ....)

But I've seen lots of "48-bit LBA" supporting controllers that hit
limits at 500GB, 1TB, etc. and needed new firmware updates.

Secondly, if you look at the table on the right of
http://en.wikipedia.org/wiki/Master_boot_record#Disk_partitioning you
see that the starting sector of a partition is defined with a 32-bit
value.

ie. 2TB with 512 byte sectors.

The normal solution is to move to a GPT which requires EFI if you want
to boot from it.

Greg
