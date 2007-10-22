From: Tejun Heo <htejun@gmail.com>
Subject: Re: AHCI with ATA/IDE Drives
Date: Mon, 22 Oct 2007 18:34:57 +0900
Message-ID: <471C6EC1.6000703@gmail.com>
References: <a14fb1800710200440hbcb0438sf2b0ee627e6e8209@mail.gmail.com> <471A09B8.2040708@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.178]:6996 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750880AbXJVJfF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 Oct 2007 05:35:05 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1238741wah
        for <linux-ide@vger.kernel.org>; Mon, 22 Oct 2007 02:35:04 -0700 (PDT)
In-Reply-To: <471A09B8.2040708@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Girish Shirasat <girish.shirasat@googlemail.com>, linux-ide@vger.kernel.org, Alan Cox <alan@redhat.com>, Jeff Garzik <jgarzik@pobox.com>

Mark Lord wrote:
> Alan / Tejun,
> 
> Another case of MDMA2 not working through a SATA->PATA bridge.
> Do we have an easy way yet, for Girish to force non-MDMA2 modes?

libata.dma=1 should do the trick for 2.6.24-rcX.  For 2.6.23, there
isn't any.  :-(

-- 
tejun
