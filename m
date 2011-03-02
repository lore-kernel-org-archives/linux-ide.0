From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: libata: ATA exception error messages in pata_sch module
 (CONFIG_PATA_SCH)
Date: Wed, 2 Mar 2011 11:12:51 +0000
Message-ID: <20110302111251.09d0f1ca@lxorguk.ukuu.org.uk>
References: <AANLkTikD3NOA7=zOLRaft8TL=sTgPSCHNNKgTP3AfYWD@mail.gmail.com>
	<4D6D9684.505@gmail.com>
	<AANLkTikpg2d47rAO=FatTe-53Ju4u+YBXt8VKmani8TN@mail.gmail.com>
	<AANLkTimyVVZA3-pKyKUTyqTENRi1w2DXHcmAyg-J_8ok@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:45432 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750831Ab1CBLM5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 Mar 2011 06:12:57 -0500
In-Reply-To: <AANLkTimyVVZA3-pKyKUTyqTENRi1w2DXHcmAyg-J_8ok@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: Kushal Koolwal <kushalkoolwal@gmail.com>, "David S. Miller" <davem@davemloft.net>, Borislav Petkov <petkovbb@gmail.com>, linux-ide@vger.kernel.org

> Reading through the SCH datasheet
> (http://download.intel.com/design/chipsets/embedded/datashts/319537.pdf)
> I don't see any mention of a mechanism which can be used to detect the
> cable. In some cases device-side cable detection can be done but I
> don't know that all devices support it. So there might not actually be
> a way to do it on this controller.

SCH is going to be on the motherboard so for systems where the detect
fails it's probably easiest to take the PIIX approach and spot them by
svid/sdid on the PCI device.

All modern devices should support cable detect fine *but* it's perfectly
valid to have a 40 wire cable providing it is very short, or indeed for a
CF and SCH to both be on the board. In that case you'd hope they'd wire
in a trick 80 wire detect but many don't.

Alan
