From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 5/5] falconide/q40ide: add ->atapi_*put_bytes and
 ->ata_*put_data methods
Date: Mon, 31 Mar 2008 10:37:13 +0100
Message-ID: <20080331103713.47d715f7@core>
References: <200803301714.04527.bzolnier@gmail.com>
	<Pine.LNX.4.64.0803302012560.16372@anakin>
	<200803302134.42569.bzolnier@gmail.com>
	<Pine.LNX.4.64.0803310750230.6871@anakin>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [81.2.110.250] ([81.2.110.250]:48328 "EHLO lxorguk.ukuu.org.uk"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751713AbYCaJ4o (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 31 Mar 2008 05:56:44 -0400
In-Reply-To: <Pine.LNX.4.64.0803310750230.6871@anakin>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, Linux Kernel Development <linux-kernel@vger.kernel.org>, Linux/m68k <linux-m68k@vger.kernel.org>, Michael Schmitz <schmitz@debian.org>

> Yes, the data on the disk is stored byte-swapped.
> So it's only the drive ID and packet commands that should be swapped.

If you are storing the data on disk byte swapped then reverse the logic
in the driver so you don't need hacks for un-swapping commands and write
a bytesewap device mapper layer in the right place. Then you can even
move disks around.

It's ugly because the solution is currently in the wrong place (for good
historical reasons this is true)

Alan
