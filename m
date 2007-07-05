From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 2.6.22-rc7 3/3] libata: pata_via CX700 quirks
Date: Thu, 05 Jul 2007 21:39:10 +0900
Message-ID: <468CE66E.1070901@gmail.com>
References: <20070705043127.GX29122@htj.dyndns.org>	<20070705043501.GY29122@htj.dyndns.org>	<20070705043949.GZ29122@htj.dyndns.org> <20070705133407.21977a92@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.231]:25755 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758519AbXGEMjR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 5 Jul 2007 08:39:17 -0400
Received: by nz-out-0506.google.com with SMTP id s18so1836789nze
        for <linux-ide@vger.kernel.org>; Thu, 05 Jul 2007 05:39:16 -0700 (PDT)
In-Reply-To: <20070705133407.21977a92@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Alan Cox wrote:
> This makes no sense. If the SETXFER failed how did the device get into
> the mode it is in ? How will change down work ? Why does the old IDE
> driver work ?

IDE ignores SETXFER failure and for SATA devices SETXFER doesn't really
mean anything (unless it's bridged).  In this case, IDE didn't seem to
be seeing SETXFER failures but the chip being quite weird (SETXFER
failure is associated with the specific device slot not the device
itself.  it's probably a bridge problem.) and from the vendor it's from,
I thought whatever works is okay.

> I think this needs a lot more explanation

Feel free to re-open bug 8563.  I'd be happy to help. :-)

Thanks.

-- 
tejun
