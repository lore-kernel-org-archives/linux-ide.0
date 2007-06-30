From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 13/15] ide: add ata_set{_max}_pio()
Date: Sat, 30 Jun 2007 22:46:01 +0200
Message-ID: <200706302246.01762.bzolnier@gmail.com>
References: <200706302111.29322.bzolnier@gmail.com> <200706302231.10032.bzolnier@gmail.com> <4686BB31.7040205@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.189]:27962 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751911AbXF3U3m (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 30 Jun 2007 16:29:42 -0400
Received: by nf-out-0910.google.com with SMTP id g13so44307nfb
        for <linux-ide@vger.kernel.org>; Sat, 30 Jun 2007 13:29:41 -0700 (PDT)
In-Reply-To: <4686BB31.7040205@garzik.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org

On Saturday 30 June 2007, Jeff Garzik wrote:
> Bartlomiej Zolnierkiewicz wrote:
> > This has been changing recently since "ide_" prefix seems to have
> > negative emotional connotations. :-)
> > 
> > New patches for drivers/ide should use exclusively the "ata_" prefix.
> 
> So this choice to be inconsistent was made based entirely on fashion?
> 
> This is the same as using a different coding style in one area of the 
> IDE driver, when the rest of the IDE driver uses another coding style.
> 
> It violates the Principle of Least Surprise.
> 
> I cannot see any harm in continuing to use the prefix the IDE driver has 
> been using for over a decade, while I can see how inconsistency

This allowed easy distinguishment between old / new code.

> >> particularly when libata uses the "ata_" prefix almost exclusively.
> > 
> > I don't see *any* problem with this since libata exists in the separate
> > directory and the amount of code shared between libata and drivers/ide
> > equals *zero* (not counting <linux/ata.h> containing defines etc).
> 
> There are many opportunities for confusion:  global grep.  oops traces. 
>   General reviewer expectations ("oooh, I grepped for ide_xxx because 
> thats what all the functions use, except for this ONE function that's 
> different")
> 
> You are living in a global namespace.  Directories are irrelevant.

OK, I got your point and will fix the offending patches.

Thanks,
Bart
