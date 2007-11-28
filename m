From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] pata_ali: Lots of problems still showing up with small
 ATAPI DMA
Date: Wed, 28 Nov 2007 10:36:15 +0900
Message-ID: <474CC60F.9040807@gmail.com>
References: <20071119143758.3c6b85ee@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.185]:5148 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752404AbXK1BgX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Nov 2007 20:36:23 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1068962rvb
        for <linux-ide@vger.kernel.org>; Tue, 27 Nov 2007 17:36:22 -0800 (PST)
In-Reply-To: <20071119143758.3c6b85ee@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jeff@garzik.org, akpm@osdl.org, linux-ide@vger.kernel.org

Alan Cox wrote:
> Hopefully there is a better long term solution but for now lets favour
> reliability.

I'm getting a lot of reports on pata_ali w/ misc ATAPI commands too.  Do
you know whether it's a controller problem or drive one?  All the
reports I got are laptops and I can't really ask them to disassemble
their laptops.  :-)

Thanks.

-- 
tejun
