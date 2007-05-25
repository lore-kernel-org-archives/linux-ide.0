From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: 2.6.22-rc1-mm1: IDE compile error
Date: Thu, 24 May 2007 17:05:33 -0700
Message-ID: <4656284D.7080709@zytor.com>
References: <20070515201914.16944e04.akpm@linux-foundation.org>	<20070516185552.GA4086@stusta.de>	<200705240145.38055.bzolnier@gmail.com> <20070524115549.01c0e1ca@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from terminus.zytor.com ([192.83.249.54]:60327 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750805AbXEYAHq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 May 2007 20:07:46 -0400
In-Reply-To: <20070524115549.01c0e1ca@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Alan Cox wrote:
> 
> hd.c can drive MFM and RLL disks and drivers/ide cannot. Although it
> really wants burying further down the config tree the ability to read MFM
> and RLL disks when recovering ancient data is useful and people do
> actually use this driver now and then rescuing stuff like twenty year old
> datasets.
> 
> It thus needs fixing not removing.
> 

Opinions, anyone (especially Alan):

http://git.kernel.org/?p=linux/kernel/git/hpa/linux-2.6-newsetup.git;a=commitdiff;h=369f16fdd423d79640c4390915e6ab71189cb497

	-hpa
