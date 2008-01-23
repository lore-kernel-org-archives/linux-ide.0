From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] ppc: fix #ifdef-s in mediabay driver
Date: Wed, 23 Jan 2008 15:17:12 +1100
Message-ID: <1201061832.6807.64.camel@pasglop>
References: <200801230012.38516.bzolnier@gmail.com>
	 <1201046394.6807.49.camel@pasglop>  <200801230158.42017.bzolnier@gmail.com>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:45418 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752100AbYAWERh (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 22 Jan 2008 23:17:37 -0500
In-Reply-To: <200801230158.42017.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org


On Wed, 2008-01-23 at 01:58 +0100, Bartlomiej Zolnierkiewicz wrote:
> I'm more worried about breaking automatic build checking (make randconfig)
> than a few extra bytes so if you remove all #ifdefs you'll have to either
> make BLK_DEV_IDE_PMAC select PMAC_MEDIABAY or make PMAC_MEDIABAY depend
> on BLK_DEV_IDE_PMAC (otherwise BLK_DEV_IDE=n && PMAC_MEDIABAY=y will fail
> since mediabay.c is referencing IDE code).

I was thinking about having the pmac arch code provide an exported
function pointer to put the hook in to avoid that problem.

Ben.


