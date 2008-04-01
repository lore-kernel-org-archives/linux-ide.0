From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 5/5] falconide/q40ide: add ->atapi_*put_bytes and
 ->ata_*put_data methods
Date: Tue, 1 Apr 2008 09:12:40 +0100
Message-ID: <20080401091240.420b3aeb@core>
References: <20080331224318.4768c050@core>
	<Pine.LNX.4.44.0804010512010.22211-100000@smaragd.biophys.uni-duesseldorf.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:59142 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752437AbYDAIOB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 1 Apr 2008 04:14:01 -0400
In-Reply-To: <Pine.LNX.4.44.0804010512010.22211-100000@smaragd.biophys.uni-duesseldorf.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Michael Schmitz <schmitz@smaragd.biophys.uni-duesseldorf.de>
Cc: Roman Zippel <zippel@linux-m68k.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, Linux Kernel Development <linux-kernel@vger.kernel.org>, Linux/m68k <linux-m68k@vger.kernel.org>, Michael Schmitz <schmitz@debian.org>

> Sorry for the mess in core code - ist there any other way for only driveid
> and packet data getting swapped? And can we actually use the device mapper
> to byte-swap the root partition?

Device Mapper can certainly support that if needed - I don't think it has
a swab target currently but byteswapped is just a very bad crypto
algorithm so you can use dm crypt target as a reference. Might not be a
bad idea just to make the media shareable.

The only other way I can see to do it would be to split the ATA transfer
functions into two sets one for media data and one for other stuff - but
then how do you handle iso9660 cd ?

Alan
