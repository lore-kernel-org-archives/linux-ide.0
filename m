From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: libata PATA support - work items?
Date: Thu, 06 Jan 2005 21:29:42 +0000
Message-ID: <1105044491.24187.268.camel@localhost.localdomain>
References: <006301c4ee5c$49e6a230$95714109@tw.ibm.com>
	 <41DB2781.7000203@pobox.com>  <005701c4f3ce$37d56140$fb7f4109@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from clock-tower.bc.nu ([81.2.110.250]:39100 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S263157AbVAFWeP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 6 Jan 2005 17:34:15 -0500
In-Reply-To: <005701c4f3ce$37d56140$fb7f4109@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Albert Lee <albertcc@tw.ibm.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, "\"Bartlomiej Zolnierkiewicz\"" <bzolnier@gmail.com>, "\"IDE Linux\"" <linux-ide@vger.kernel.org>, "\"Doug Maxey\"" <dwm@maxeymade.com>

On Iau, 2005-01-06 at 08:51, Albert Lee wrote:
> For the 1st item,
> - add PATA device errata/blacklist info
> Is there any detail or draft design idea available?

There is a fair bit of code in drivers/ide. Most of it is handling drive
problems that occurred with early DMA drives and it uses the
model/firmware info in the ident string to match drives that claim to do
DMA but do not and drives that claim not to but can.

The logic is fairly simple and the database is easily transported or
shared. It is fairly important because some of these old drives
corrupted data if used DMA. (see drivers/ide/ide-dma.c)

For PIO problem drives where there is a need to keep PIO modes chosen
carefully then ide-lib has a list (ide_pio_blacklist) and the ide-io
code knows about pio modes and older style EIDE cycle timing reports
(ide_get_best_pio_mode)

IDE CD has some DMA blacklists for ATAPI but they should be viewed with
caution as many entries were due to a bug in our atapi implementation
that was fixed long ago.

> For
> - C/H/S addressing.
>  I've an old Segate drive which support CHS-only at hand.
> Maybe I can work on it first.

That seems the logical start - many of the worst drive errata only apply
to old CHS drives anyway.


