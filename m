From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: libata broken on Pegasos PPC platform (was: Re: IDE broken on
 Pegasos PPC platform)
Date: Mon, 24 Sep 2007 22:10:41 +0100
Message-ID: <20070924221041.309b08e9@the-village.bc.nu>
References: <46F80BB1.7050902@redhat.com>
	<200709242258.28497.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:37253 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750858AbXIXVEW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 24 Sep 2007 17:04:22 -0400
In-Reply-To: <200709242258.28497.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Chuck Ebbert <cebbert@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Olaf Hering <olaf@aepfle.de>

On Mon, 24 Sep 2007 22:58:28 +0200
Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:

> On Monday 24 September 2007, Chuck Ebbert wrote:
> > Without this patch, taken from a Suse 2.6.22 kernel, the Pegasos
> > PPC machines can't use their IDE interface. Is this the right fix?
> 
> This or use IDE via82cxxx driver.

Which contains a similar hack in the IDE driver where it doesn't belong 8)

> IIRC the patch comes from Olaf Hering (added to cc:) and is the way to go
> 
> Acked-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Alan Cox <alan@redhat.com>

hopefully that means the hack in the old VIA driver can also be killed
off.
