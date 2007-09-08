From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: Add a drivers/ide style  DMA disable
Date: Sat, 08 Sep 2007 15:01:00 +0900
Message-ID: <46E23A9C.2090003@gmail.com>
References: <20070822233710.415faaf0@the-village.bc.nu> <46E0CC76.70101@gmail.com> <46E1D4FB.8030409@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.179]:39567 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753541AbXIHRGp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 8 Sep 2007 13:06:45 -0400
Received: by wa-out-1112.google.com with SMTP id v27so939981wah
        for <linux-ide@vger.kernel.org>; Sat, 08 Sep 2007 10:06:44 -0700 (PDT)
In-Reply-To: <46E1D4FB.8030409@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, akpm@osdl.org, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> FWIW -- as I noted to Alan personally at KS, I would rather drop the
> "pata_" and have it apply to all, PATA or SATA.

Having the distinction between sata and pata is also nice tho
considering many modern machines mix the two and use the P part for
ATAPI, CF kind of stuff.  It's all just masks anyway, we can easily do both.

> As an aside, it would be nice to get the EH in shape where it can pause
> all ports, so we can finally allow userspace to submit SET FEATURES -
> XFER MODE and have it handled cleanly and properly.

Aye aye sir, bumping up in the to-do list.  BTW, I'm currently on
airplane and won't be back home in about ten days.  PMP patchset is
regenerated but it has some problem integrating with the AN support and
I need my gears to iron it out, so PMP patches will have to wait a bit
more.  FWIW, openSUSE 10.3 defaults to libata drivers and contains the
PMP patches.  It already received quite a bit of testing going through
two betas, so I don't think the PMP patches would introduce too many
serious regressions for non-PMP users.

Thanks.

-- 
tejun

