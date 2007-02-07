From: "Eric D. Mudama" <edmudama@gmail.com>
Subject: Re: [PATCH 1/1] libata: rearrange dmesg info to add full ATA revision
Date: Tue, 6 Feb 2007 19:31:17 -0700
Message-ID: <311601c90702061831r2d7d80bcj1805d50b9e8937b4@mail.gmail.com>
References: <20070131021051.GA3403@bounceswoosh.org>
	 <20070131060040.GA3361@bounceswoosh.org> <45C9206C.10202@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:41505 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965223AbXBGCbV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Feb 2007 21:31:21 -0500
Received: by ug-out-1314.google.com with SMTP id 44so65264uga
        for <linux-ide@vger.kernel.org>; Tue, 06 Feb 2007 18:31:19 -0800 (PST)
In-Reply-To: <45C9206C.10202@garzik.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org

On 2/6/07, Jeff Garzik <jeff@garzik.org> wrote:
> >       ATA_SERNO_LEN           = 20,
> > +     ATA_ID_PROD_LEN         = 40,
> > +     ATA_ID_FW_REV_LEN       = 16,
> >       ATA_UDMA0               = (1 << 0),
> >       ATA_UDMA1               = ATA_UDMA0 | (1 << 1),
> >       ATA_UDMA2               = ATA_UDMA1 | (1 << 2),
>
> applied to netdev#upstream, sans the above part.  I'm not sure where you
> got 16 there?  It's 8 ASCII chars in the spec.

Yea, I'm not sure either.  I got the model length right, but brain
farted on the FW rev for some reason (which was the whole point)

Thx
--eric
