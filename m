From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.6.22-rc1-mm1: IDE compile error
Date: Fri, 25 May 2007 01:14:03 +0100
Message-ID: <20070525011403.20e77ee7@the-village.bc.nu>
References: <20070515201914.16944e04.akpm@linux-foundation.org>
	<20070516185552.GA4086@stusta.de>
	<200705240145.38055.bzolnier@gmail.com>
	<20070524115549.01c0e1ca@the-village.bc.nu>
	<4656284D.7080709@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:49264 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750933AbXEYALM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 May 2007 20:11:12 -0400
In-Reply-To: <4656284D.7080709@zytor.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

> > It thus needs fixing not removing.
> > 
> 
> Opinions, anyone (especially Alan):
> 
> http://git.kernel.org/?p=linux/kernel/git/hpa/linux-2.6-newsetup.git;a=commitdiff;h=369f16fdd423d79640c4390915e6ab71189cb497

I believe the technical description for the comment is "bullshit" 8)

Almost all MFM controllers and RLL controllers will only run at the
standard primary and secondary ATA address.

Given the intended use of the driver today I don't see a big problem in
requiring "hd=" although you have to question the point of this boot code
rewrite when it seems primarily to be removing features 

Alan
