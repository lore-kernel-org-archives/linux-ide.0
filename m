From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: add support for READ/WRITE LONG
Date: Tue, 13 Mar 2007 00:08:13 +0000
Message-ID: <20070313000813.183a1364@lxorguk.ukuu.org.uk>
References: <3aac340703102322p362998b9labedc13503702d2b@mail.gmail.com>
	<45F56800.3040104@rtr.ca>
	<3aac340703121003l43685599t8dbffe6247879a91@mail.gmail.com>
	<45F5A523.1080500@rtr.ca>
	<20070312221351.6c3db1fa@lxorguk.ukuu.org.uk>
	<45F5D2DA.20407@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:41644 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751861AbXCLXEz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Mar 2007 19:04:55 -0400
In-Reply-To: <45F5D2DA.20407@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, Vitaliyi <imgrey@gmail.com>, Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

On Mon, 12 Mar 2007 18:23:22 -0400
Mark Lord <liml@rtr.ca> wrote:

> Alan Cox wrote:
> > On Mon, 12 Mar 2007 15:08:19 -0400
> > Mark Lord <liml@rtr.ca> wrote:
> > 
> >> The READ/WRITE LONG commands are theoretically obsolete,
> >> but the majority of drives in existance still implement them.
> >>
> >> The WRITE_LONG and WRITE_LONG_ONCE commands are of particular
> >> interest for fault injection testing -- eg. creating "media errors"
> >> at specific locations on a disk.
> > 
> > Do you still get hangs with ata_piix if you use R/W LONG and these
> > changes ?
> 
> Err.. I *never* got hangs with ata_piix and these patches.
> Either that, or the Alzheimer's is getting worse.  ;)

Umm... someone reported originally getting problems with R/W LONG and PIIX
but not AHCI and we discussed whether we might need to turn the
prefetch/postwrite off for it. Would have been about October last year.

If it works ok then I'll just cross it off the list

Alan

