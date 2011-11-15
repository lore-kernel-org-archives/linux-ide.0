From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata-pmp: add schedule timeout to support some PMP
 cards
Date: Tue, 15 Nov 2011 06:51:11 -0800
Message-ID: <20111115145111.GK30922@google.com>
References: <1320033440-1106-1-git-send-email-r66093@freescale.com>
 <20111103160759.GI4417@google.com>
 <8A2FC72B45BB5A4C9F801431E06AE48F11617501@039-SN1MPN1-005.039d.mgd.msft.net>
 <20111110152036.GB27258@google.com>
 <8A2FC72B45BB5A4C9F801431E06AE48F1161C24D@039-SN1MPN1-005.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:41991 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755712Ab1KOOvS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 Nov 2011 09:51:18 -0500
Received: by ywt32 with SMTP id 32so3520219ywt.19
        for <linux-ide@vger.kernel.org>; Tue, 15 Nov 2011 06:51:17 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <8A2FC72B45BB5A4C9F801431E06AE48F1161C24D@039-SN1MPN1-005.039d.mgd.msft.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Huang Changming-R66093 <r66093@freescale.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Hello,

On Tue, Nov 15, 2011 at 08:43:02AM +0000, Huang Changming-R66093 wrote:
> The PMP card we are talking about is JMB393:
> Port Multiplier 1.2, 0x197b:0x0325 r0, 15 ports, feat 0x5/0xf.
> 
> This issue is observed on Freescale's Sata controller, including p1020e and mpc837xe.

Can you please try different combinations?  ie. freescale sata + other
PMP and jmb393 + other sata controllers.  We need to know more before
adding workarounds to upstream.  Also, would you mind if I cc jmicron
ppl?

Thank you.

-- 
tejun
