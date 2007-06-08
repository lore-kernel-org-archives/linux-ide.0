From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: claim ctl port for legacy SFF ports
Date: Fri, 08 Jun 2007 21:01:47 +0900
Message-ID: <4669452B.4030101@gmail.com>
References: <20070604235157.GD31462@havoc.gtf.org>	<20070608114119.GE29122@htj.dyndns.org> <20070608125128.59288dc3@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.182]:41729 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765666AbXFHMBw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 8 Jun 2007 08:01:52 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1033839wah
        for <linux-ide@vger.kernel.org>; Fri, 08 Jun 2007 05:01:52 -0700 (PDT)
In-Reply-To: <20070608125128.59288dc3@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Alan Cox wrote:
> On Fri, 8 Jun 2007 20:41:19 +0900
> Tejun Heo <htejun@gmail.com> wrote:
> 
>> libata used to claim only cmd ports for legacy SFF ports.  Claim ctl
>> ports too.
> 
> Just use pci resource functions. The quirk handlers do the rest for you
> already.

It was that way to allow legacy SFF code to be used in non-PCI
environment.  Is it gonna?

BTW, the original patch is broken and I tested the wrong kernel.
Brewing fixed one now.

-- 
tejun
