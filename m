From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 3/9] libata: implement per-dev xfermask
Date: Sun, 06 Aug 2006 16:56:44 +0100
Message-ID: <1154879804.22906.8.camel@localhost.localdomain>
References: <11547252932391-git-send-email-htejun@gmail.com>
	 <1154785137.10971.20.camel@localhost.localdomain>
	 <44D5FF90.7000602@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:58770 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750745AbWHFPiF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 6 Aug 2006 11:38:05 -0400
In-Reply-To: <44D5FF90.7000602@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jgarzik@pobox.com, davej@redhat.com, linux-ide@vger.kernel.org, Mark Lord <mlord@pobox.com>

Ar Sul, 2006-08-06 am 23:41 +0900, ysgrifennodd Tejun Heo:
> I see.  I have a question though.  ATM, there are a few drives in the 
> current #upstream which deal with PATA devices (ata_piix, pdc_adma and 
> sata_promise).  Will they all act correctly without the above logic?  If 
> so, I'll drop the above part and regenerate the tree.  If not, it can 
> stay till those drivers are patched.

I went through them checking earlier. The majority of chipsets snoop the
drive select bit and will generate appropriate cycles by device
according to that bit.  Not everything does but I have been through and
made sure the ones that don't correctly merge timings. At least I hope I
have them all anyway.


