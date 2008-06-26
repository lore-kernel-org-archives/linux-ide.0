From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/4] ide-pmac: media-bay support fixes
Date: Thu, 26 Jun 2008 19:01:08 +1000
Message-ID: <1214470868.8011.455.camel@pasglop>
References: <200806162124.43005.bzolnier@gmail.com>
	 <200806242055.12042.bzolnier@gmail.com> <1214456094.8011.438.camel@pasglop>
	 <200806261051.34733.bzolnier@gmail.com>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:38941 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750866AbYFZJBQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 26 Jun 2008 05:01:16 -0400
In-Reply-To: <200806261051.34733.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 2008-06-26 at 10:51 +0200, Bartlomiej Zolnierkiewicz wrote:
> 
> The latest patches in one place:
> 
> http://www.kernel.org/pub/linux/kernel/people/bart/pata-2.6/
> 
> pmac-media-bay-support-fixes-take-3.patch
> pmac-store-pmif-instead-of-hwif-in-driver_data-take-2.patch
> pmac-add-init_dev-method-take-3.patch
> pmac-move-ide_find_port-call-to-pmac_ide_setup_device-take-2.patch
> 
> IMO they are quite small and straightforward so setting git tree would
> be overdoing it but if there are still problems I will set one.

That's ok, just tell me a tree and an SHA1 ID of a commit on top of
which they apply, that will make my life easier :-)

I'll test them tomorrow morning.

Cheers,
Ben.


