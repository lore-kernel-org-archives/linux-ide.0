From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/2] [ide] mmio ide support
Date: Sat, 7 Jul 2007 14:19:52 +0200
Message-ID: <200707071419.52650.arnd@arndb.de>
References: <20070707094852.9473.21013.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.174]:49933 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753037AbXGGMWO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 7 Jul 2007 08:22:14 -0400
In-Reply-To: <20070707094852.9473.21013.stgit@localhost.localdomain>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linuxppc-dev@ozlabs.org
Cc: Vitaly Bordug <vitb@kernel.crashing.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Saturday 07 July 2007, Vitaly Bordug wrote:
>=20
> This adds support for MMIO IDE device like CompactFlash=20
> in TrueIDE mode.
> =A0
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>=20
> Signed-off-by: Vitaly Bordug <vitb@kernel.crashing.org>

Hmm, are we still adding new IDE drivers? Do you also have a
driver for the new libata layer? I think it would even be
simpler to do.

You could also make it an of_platform_driver at the same time
instead of adding more cruft to fsl_soc.c. Since we're already
about to add the electra_ide.c driver in 2.6.23, I guess there
should really be _one_ driver that is able to handle all
of_device based ATA hosts.

	Arnd <><
