From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 1/4] ide-pmac: media-bay support fixes
Date: Thu, 26 Jun 2008 10:51:34 +0200
Message-ID: <200806261051.34733.bzolnier@gmail.com>
References: <200806162124.43005.bzolnier@gmail.com> <200806242055.12042.bzolnier@gmail.com> <1214456094.8011.438.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.29]:41855 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754498AbYFZIuS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Jun 2008 04:50:18 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1273714ywe.1
        for <linux-ide@vger.kernel.org>; Thu, 26 Jun 2008 01:50:17 -0700 (PDT)
In-Reply-To: <1214456094.8011.438.camel@pasglop>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: benh@kernel.crashing.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Thursday 26 June 2008, Benjamin Herrenschmidt wrote:
> BTW (usual problem), I'm having a very hard time applying your patches..
> 
> It looks like the 2 replacement ones you sent are no longer against
> whatever merge point I found in linux-next history for your tree, so
> I applied against linux-next 20080620, where 1/4 applies, 2/4 applies
> with offsets and 3 fails...

I see:

http://lkml.org/lkml/2008/6/24/369

it should say patch #3/4 not #2/4

I've just checked and everything still applies fine to 20080625.

> For some reason, every time you send me new patches, I need more time
> figuring out what they are supposed to apply to than actually testing
> them :-)

The latest patches in one place:

http://www.kernel.org/pub/linux/kernel/people/bart/pata-2.6/

pmac-media-bay-support-fixes-take-3.patch
pmac-store-pmif-instead-of-hwif-in-driver_data-take-2.patch
pmac-add-init_dev-method-take-3.patch
pmac-move-ide_find_port-call-to-pmac_ide_setup_device-take-2.patch

IMO they are quite small and straightforward so setting git tree would
be overdoing it but if there are still problems I will set one.

Thanks,
Bart
