From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: inic162x
Date: Mon, 5 Jan 2015 15:16:17 +0000
Message-ID: <20150105151617.0a5a68d9@lxorguk.ukuu.org.uk>
References: <2171761.W9v3jf2zpF@c21>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 251.110.2.81.in-addr.arpa ([81.2.110.251]:60513 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753516AbbAEPQ1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Jan 2015 10:16:27 -0500
In-Reply-To: <2171761.W9v3jf2zpF@c21>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: mtths@nurfuerspam.de
Cc: linux-ide@vger.kernel.org

On Sat, 03 Jan 2015 21:25:28 +0100
mtths@nurfuerspam.de wrote:

> Hi,
> 
> a simple question about the module sata_inic162x: Is there a chance that the 
> driver will reach a stable state?
> 
> A card with such a controller was used mainly for video recording - and, yes, 
> there were errors ... After a short test it seemed that copying big files or 
> many small files resulted in corrupted copies; only writing infrequently small 
> files was okay. This applies to both channels / ports.
> 
> The card is an equip 111817 (S/N: 11072600052): 1 internal + 1 external port
> Initio INIC-1622TA2
> RAID-BIOS: version 1.11
> lspci: 1101:1622
> 
> If you want additional information or tests, let me know.
> (On the other hand: Mark it as broken - there are inexpensive alternatives 
> ...)

There are people it works very well for, and a few it doesn't. It's hard
to know if its the drive, the card, the software ore some combination of
all three.

Whether anyone ever fixes those cases depends upon whether anyone who
hits it wants to spend some considerable time trying to debug it all and
submit patches.

Alan
