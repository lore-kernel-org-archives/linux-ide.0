From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] pata_ali: Lots of problems still showing up with small
 ATAPI DMA
Date: Wed, 28 Nov 2007 20:26:47 +0900
Message-ID: <474D5077.3090203@gmail.com>
References: <20071119143758.3c6b85ee@the-village.bc.nu>	<474CC60F.9040807@gmail.com> <20071128092518.5f2ca7df@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ro-out-1112.google.com ([72.14.202.178]:46663 "EHLO
	ro-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757617AbXK1L0z (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 28 Nov 2007 06:26:55 -0500
Received: by ro-out-1112.google.com with SMTP id p4so2416501roc
        for <linux-ide@vger.kernel.org>; Wed, 28 Nov 2007 03:26:54 -0800 (PST)
In-Reply-To: <20071128092518.5f2ca7df@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jeff@garzik.org, akpm@osdl.org, linux-ide@vger.kernel.org

Alan Cox wrote:
> On Wed, 28 Nov 2007 10:36:15 +0900
> Tejun Heo <htejun@gmail.com> wrote:
> 
>> Alan Cox wrote:
>>> Hopefully there is a better long term solution but for now lets favour
>>> reliability.
>> I'm getting a lot of reports on pata_ali w/ misc ATAPI commands too.  Do
>> you know whether it's a controller problem or drive one?  All the
>> reports I got are laptops and I can't really ask them to disassemble
>> their laptops.  :-)
> 
> ALi is one that most definitely appears to be controller related. Thats
> why I sent Jeff a patch to use DMA for 2K+ transfers only. Some ALi also
> required the patch to set the xfer lengths.
> 
> Its only some revs/combinations annoyingly - a lot of them (including the
> ones I have direct access too) just work.

Does READ_CD work fine via DMA?  2K+ filtering filters most if not all
misc commands so usually only sector (2K) aligned READ and WRITEs are
done via DMA.  Interesting exceptions are READ_CD[_MSF] and
READ/WRITE_BUFFER which usually exceed 2K but aren't aligned to 2K.  I
guess it's about time to write a test case program which issues a bunch
of problematic commands and see which works.

Thanks.

-- 
tejun
