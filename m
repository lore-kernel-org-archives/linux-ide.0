From: Dave <dave.jiang@gmail.com>
Subject: Re: [PATCH] updates to Vitesse SATA driver
Date: Thu, 30 Sep 2004 09:51:05 -0700
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <8746466a04093009511b72292b@mail.gmail.com>
References: <8746466a04092114163b3c0618@mail.gmail.com>
	 <415B34FC.8060908@pobox.com>
	 <8746466a0409291532471417b8@mail.gmail.com>
	 <20040930023428.GA200873@sgi.com> <415B7D53.9020101@pobox.com>
	 <8746466a040930091743eddb@mail.gmail.com>
Reply-To: Dave <dave.jiang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rproxy.gmail.com ([64.233.170.204]:29997 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S269344AbUI3QvG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 30 Sep 2004 12:51:06 -0400
Received: by mproxy.gmail.com with SMTP id 74so212127rnk
        for <linux-ide@vger.kernel.org>; Thu, 30 Sep 2004 09:51:05 -0700 (PDT)
In-Reply-To: <8746466a040930091743eddb@mail.gmail.com>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Jeremy Higdon <jeremy@sgi.com>, linux-ide@vger.kernel.org

On Thu, 30 Sep 2004 09:17:09 -0700, Dave <dave.jiang@gmail.com> wrote:
> On Wed, 29 Sep 2004 23:28:19 -0400, Jeff Garzik <jgarzik@pobox.com > wrote:
> 
> > Technically speaking, one sets the ATA_FLAG_SLAVE_POSS flag to tell the
> > libata core to scan for device 1.
> >
> 
> For some odd reason we are scanning device 1 on XScale IOP platform
> with the exact same driver code. I'll have to investigate some more
> and see why it's doing that.
> 

Okay, I must be not seeing something obvious. The ATA_FLAG_SLAVE_POSS
flag is not set. But I only see it being checked during reset. When
ata_bus_probe is called, it probes for ATA_MAX_DEVICES, which is both
dev 0 and dev 1. Thus dev 1 fails of course, and the core changes the
ctl without the sata driver knowing and causes interrupt mask to
remain set.....

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
