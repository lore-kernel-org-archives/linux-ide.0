From: Dave <dave.jiang@gmail.com>
Subject: Re: [PATCH] updates to Vitesse SATA driver
Date: Wed, 29 Sep 2004 15:32:34 -0700
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <8746466a0409291532471417b8@mail.gmail.com>
References: <8746466a04092114163b3c0618@mail.gmail.com>
	 <415B34FC.8060908@pobox.com>
Reply-To: Dave <dave.jiang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rproxy.gmail.com ([64.233.170.197]:60528 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S269081AbUI2Wct (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 29 Sep 2004 18:32:49 -0400
Received: by mproxy.gmail.com with SMTP id 74so135137rnk
        for <linux-ide@vger.kernel.org>; Wed, 29 Sep 2004 15:32:35 -0700 (PDT)
In-Reply-To: <415B34FC.8060908@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: jeremy.higdon@sgi.com, linux-ide@vger.kernel.org

On Wed, 29 Sep 2004 18:19:40 -0400, Jeff Garzik <jgarzik@pobox.com> wrote:
> So where did the discussion on this patch land?
> 
> 

Jeff,

I believe waiting for you to comment on whether to put in a hook for
controllers that do not support ATA_NIEN so it can mask/unmask IRQ
with a fixup.  Even though the spec for this particular SATA
controller says the bit is reserved, it seems to work just fine. From
my understanding, the registers are actually on the drives, and the
ones we write to the HBAs are just shadow registers right? I suppose
either we can use the "undocumented" reserved bit for ATA_NIEN, or
provide some sort of special hook in lib_ata core to clear the
interrupt bit....

Obviosly if it is working on IA32 or IA64, this code must be only
scanning device 0 per port and not device 1. Not sure why it is only
scanning 1 device on IA platforms, but both on XScale. Either way we
have a corner case here that should be addressed....


-- 
-= Dave =-

Software Engineer - Advanced Development Engineering Team 
Storage Component Division - Intel Corp. 
mailto://dave.jiang @ intel
----
The views expressed in this email are
mine alone and do not necessarily 
reflect the views of my employer
(Intel Corp.).
