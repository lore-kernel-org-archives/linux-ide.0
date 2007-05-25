From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.6.22-rc1-mm1: IDE compile error
Date: Fri, 25 May 2007 15:19:09 +0100
Message-ID: <20070525151909.34284a24@the-village.bc.nu>
References: <20070515201914.16944e04.akpm@linux-foundation.org>
	<20070516185552.GA4086@stusta.de>
	<200705240145.38055.bzolnier@gmail.com>
	<20070524115549.01c0e1ca@the-village.bc.nu>
	<4656284D.7080709@zytor.com>
	<20070525011403.20e77ee7@the-village.bc.nu>
	<46562B5A.2070008@zytor.com>
	<20070525013817.26061764@the-village.bc.nu>
	<4656332C.7080909@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:45845 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751719AbXEYOQY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 25 May 2007 10:16:24 -0400
In-Reply-To: <4656332C.7080909@zytor.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

> > To set it up the user will have to know the parameters and have typed
> > them into the BIOS (if it even has an option for it). I see no problem
> 
> Sorry, see no problem which way?  

Forcing the user to provide the geometry. Historically that driver dealt
with the main disks the user had. Today its only use is specialist
recovery work. Anyone recovering a disk has to get the geometry data into
the BIOS (if the BIOS even allows it - many now don't) and will therefore
know it for hd= arguments as well

Alan
