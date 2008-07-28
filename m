From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] pata_it821x: Driver updates and reworking
Date: Mon, 28 Jul 2008 17:11:53 +0100
Message-ID: <20080728171153.33a09b4b@lxorguk.ukuu.org.uk>
References: <20080724171606.1c2a677c@lxorguk.ukuu.org.uk>
	<200807281658.54380.bzolnier@gmail.com>
	<20080728164749.215acf35@lxorguk.ukuu.org.uk>
	<200807281812.19435.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:50129 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759392AbYG1Q3j (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 28 Jul 2008 12:29:39 -0400
In-Reply-To: <200807281812.19435.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org

On Mon, 28 Jul 2008 18:12:19 +0200
Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:

> On Monday 28 July 2008, Alan Cox wrote:
> > > > Signed-off-by: Alan Cox <alan@redhat.com>
> > > 
> > > Looks interesting, do you plan on porting it to ide/pci/it821x later?
> > 
> > SiS have already provided a patch (ugly) for the RDC for the old drivers.
> 
> I haven't seen it on the mailing list.
> 
> Did they put it on their website or was it send in private mail?

On the website. I'm not sure I bookmarked it all.

Its pretty simple - set it up as an IT8211 without UDMA > 33

Alan
