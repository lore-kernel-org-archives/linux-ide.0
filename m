From: Tejun Heo <htejun@gmail.com>
Subject: Re: [2.6.18,19] SATA boot problems (ICH6/ICH6W)
Date: Wed, 31 Jan 2007 19:44:43 +0900
Message-ID: <45C0731B.2030608@gmail.com>
References: <200612111003.39928.kovid@theory.caltech.edu> <4588877D.1000400@gmail.com> <20061220032941.GA8903@us.ibm.com> <4588B3D5.4030406@gmail.com> <20061221171035.GC6171@us.ibm.com> <20070130015507.GA30069@us.ibm.com> <45BEF492.9000000@gmail.com> <20070130233735.GA7483@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.237]:58175 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932981AbXAaKov (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 31 Jan 2007 05:44:51 -0500
Received: by nz-out-0506.google.com with SMTP id s1so153449nze
        for <linux-ide@vger.kernel.org>; Wed, 31 Jan 2007 02:44:50 -0800 (PST)
In-Reply-To: <20070130233735.GA7483@us.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gary Hade <garyhade@us.ibm.com>
Cc: Kovid Goyal <kovid@theory.caltech.edu>, linux-ide@vger.kernel.org, lcm@us.ibm.com, Jeff Garzik <jgarzik@pobox.com>, konradr@us.ibm.com

Gary Hade wrote:
> Some of my random thoughts:
> There does appear to be this invalid assumption that 0xFF status 
> always implies device-not-present.  The status register access 
> restrictions in ATA/ATAPI-7 V1 5.14.2 include the statement "The 
> contents of this register, except for BSY, shall be ignored when 
> BSY is set to one." which the code does not honor.  There is apparently 
> past experience that 0xFF status implies device-not-present for some
> controllers (the odd clowns :) but I have no idea how common these are.

The 0xff is the value we get when there is no device present and the
motherboard manufacturer forgot to pull down the ATA bus.  It's not very
uncommon in cheap PATA world and, following the weird tradition, some
SATA controllers choose to emulate 0xff if there is no device attached
(link not established).  Not sure how many of them does it but intel's
SATA chipset is one of them, so we're pretty much stuck with it.

ie. In many P/SATA setups, your patch would add 2 extra secs of waiting
for empty ports.

> We obviously can't get rid of the check but since we cannot clear
> the read-only status register and there appears to be no specification 
> dictated upper limit on how long it should take for a software reset to 
> complete it just seems like we need to wait long enough to support the 
> slowest known device which may be the GoVault.

Agreed but still hesitant to ack the patch.  :-)

I'm gonna work on parallel probing for libata.  I think we can easily
hide extra 2 secs of waiting with parallel probing.  It will take some
time but that seems to be the 'right' thing to do especially considering
the fact that 150ms sleep has been enough for gazillions of ATA devices
during last decade except for this GoVault drive.

I'll leave this thread in my to-do folder and apply your patch after
parallel probing is in place (optimistic ETA 1 month).  How does that sound?

Thanks.

-- 
tejun
