From: Dave <dave.jiang@gmail.com>
Subject: Re: [PATCH] updates to Vitesse SATA driver
Date: Thu, 30 Sep 2004 09:17:09 -0700
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <8746466a040930091743eddb@mail.gmail.com>
References: <8746466a04092114163b3c0618@mail.gmail.com>
	 <415B34FC.8060908@pobox.com>
	 <8746466a0409291532471417b8@mail.gmail.com>
	 <20040930023428.GA200873@sgi.com> <415B7D53.9020101@pobox.com>
Reply-To: Dave <dave.jiang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rproxy.gmail.com ([64.233.170.199]:34529 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S269328AbUI3QRK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 30 Sep 2004 12:17:10 -0400
Received: by mproxy.gmail.com with SMTP id 73so3100315rnk
        for <linux-ide@vger.kernel.org>; Thu, 30 Sep 2004 09:17:09 -0700 (PDT)
In-Reply-To: <415B7D53.9020101@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Jeremy Higdon <jeremy@sgi.com>, linux-ide@vger.kernel.org

On Wed, 29 Sep 2004 23:28:19 -0400, Jeff Garzik <jgarzik@pobox.com> wrote:

> By default it only scans device 0, since SATA is a point-to-point
> connection where there is no possibility for more than one device :)
> 
> However, some hardware chooses to emulate master/slave mode.  Use of
> this, particularly on Vitesse/Intel, is highly discouraged in favor of
> DPA mode.  I would prefer to not support master/slave mode at all.

I am using the DPA mode. There is no way to even have the controller
work in legacy mode with the sata driver. Although the generic IDE
driver can be tweaked to use that. And yes I agree, no point to
support the master/slave mode. It was done for backward compatibility
for whatever reason....
 
> Technically speaking, one sets the ATA_FLAG_SLAVE_POSS flag to tell the
> libata core to scan for device 1.
> 

For some odd reason we are scanning device 1 on XScale IOP platform
with the exact same driver code. I'll have to investigate some more
and see why it's doing that.

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
