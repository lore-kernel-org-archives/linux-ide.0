From: Krzysztof Halasa <khc@pm.waw.pl>
Subject: Re: IDE CDROM tail read errors
Date: Sun, 02 Apr 2006 12:50:48 +0200
Message-ID: <m3lkuotfnb.fsf@defiant.localdomain>
References: <m3wtedrrpf.fsf@defiant.localdomain>
	<1143717489.29388.32.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from khc.piap.pl ([195.187.100.11]:54538 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S932313AbWDBKux (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Apr 2006 06:50:53 -0400
In-Reply-To: <1143717489.29388.32.camel@localhost.localdomain> (Alan Cox's message of "Thu, 30 Mar 2006 12:18:09 +0100")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

>> 1342256 (looks like it has been adjusted to .iso image size / 512 when
>>          the first I/O error occured)
>
> The SCSI layer does this bit for everyone. Its actually not libata or
> the PATA drivers that have done the work here. You should find ide-scsi
> does the same.

I see. I wonder if TOC track (in 2KB sectors) longer than ISO image
is a (recording) bug.

> I patched the old IDE driver a bit to try and deal with this and if you
> want the patch to hack on and tidy up further feel free. 

Thanks but... now I've converted my last machine to PATA-libata and
drivers/ide are dead for me:

- no way to hot-swap (permanent modules)
- IRQ timeouts on my EPIA-M (never seen with libata)
- now the "end of medium" problems
- code duplication and different device names
-- 
Krzysztof Halasa
