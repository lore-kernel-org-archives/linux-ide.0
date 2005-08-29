From: Tejun Heo <htejun@gmail.com>
Subject: Re: [RFC] libata new EH document
Date: Mon, 29 Aug 2005 15:13:14 +0900
Message-ID: <20050829061314.GB2725@htj.dyndns.org>
References: <20050829061124.GA2725@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.193]:19757 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750999AbVH2GNT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 Aug 2005 02:13:19 -0400
Received: by wproxy.gmail.com with SMTP id i1so379704wra
        for <linux-ide@vger.kernel.org>; Sun, 28 Aug 2005 23:13:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20050829061124.GA2725@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, albertcc@tw.ibm.com
Cc: linux-ide@vger.kernel.org

 Oops, typos.

 Gotta take a nap.

On Mon, Aug 29, 2005 at 03:11:24PM +0900, Tejun Heo wrote:
>  Hello, Jeff, Albert & ATA developers.
> 
>  This is the final one of recent document series for libata EH - SCSI
> EH, ATA exceptions, libata EH and, this one - libata new EH.
> 
>  This document tries to discuss how to implement new advanced EH.  It
> also describes some proposed mechanisms in detail.  I'm aware that
> things are vague without actual code, but I still think this document
> alone can at least help discussion if nothing else.  As long as some

                                                       As soon as

> consensus is reached regarding general desing, I'll follow up with

                                         design/direction

> patches.
> 
>  Jeff, a lot are from my previous new EH/NCQ patchset but also quite
> a bit has changed (for better, I hope).

 Sorry. :-)

-- 
tejun
