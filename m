From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 1/4] ide-pmac: media-bay support fixes
Date: Thu, 26 Jun 2008 11:40:39 +0200
Message-ID: <200806261140.39531.bzolnier@gmail.com>
References: <200806162124.43005.bzolnier@gmail.com> <200806261051.34733.bzolnier@gmail.com> <1214470868.8011.455.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.184]:59308 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754156AbYFZJjT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Jun 2008 05:39:19 -0400
Received: by mu-out-0910.google.com with SMTP id w8so1219000mue.1
        for <linux-ide@vger.kernel.org>; Thu, 26 Jun 2008 02:39:17 -0700 (PDT)
In-Reply-To: <1214470868.8011.455.camel@pasglop>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: benh@kernel.crashing.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Thursday 26 June 2008, Benjamin Herrenschmidt wrote:
> On Thu, 2008-06-26 at 10:51 +0200, Bartlomiej Zolnierkiewicz wrote:
> > 
> > The latest patches in one place:
> > 
> > http://www.kernel.org/pub/linux/kernel/people/bart/pata-2.6/
> > 
> > pmac-media-bay-support-fixes-take-3.patch
> > pmac-store-pmif-instead-of-hwif-in-driver_data-take-2.patch
> > pmac-add-init_dev-method-take-3.patch
> > pmac-move-ide_find_port-call-to-pmac_ide_setup_device-take-2.patch
> > 
> > IMO they are quite small and straightforward so setting git tree would
> > be overdoing it but if there are still problems I will set one.
> 
> That's ok, just tell me a tree and an SHA1 ID of a commit on top of
> which they apply, that will make my life easier :-)

They are still for *linux-next* (since they depend on other IDE changes)
and apply fine on top of -20080625.

SHA1 ID is: 9ab50ba2f4958b593802ce91395d07148b611b71 but I don't know
whether it is useful in linux-next context.

> I'll test them tomorrow morning.

Thanks.

Bart
