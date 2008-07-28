From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] pata_it821x: Driver updates and reworking
Date: Mon, 28 Jul 2008 16:47:49 +0100
Message-ID: <20080728164749.215acf35@lxorguk.ukuu.org.uk>
References: <20080724171606.1c2a677c@lxorguk.ukuu.org.uk>
	<200807281658.54380.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:57131 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752610AbYG1QHK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 28 Jul 2008 12:07:10 -0400
In-Reply-To: <200807281658.54380.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org

> > Signed-off-by: Alan Cox <alan@redhat.com>
> 
> Looks interesting, do you plan on porting it to ide/pci/it821x later?

SiS have already provided a patch (ugly) for the RDC for the old drivers.

> PS a bit of shame that this is not splitted on patches with smaller
> granularity (would make review/merging work far more effective)

Its all pretty trivial stuff.

Alan
