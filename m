From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide: remove CONFIG_BLK_DEV_IDE config option
Date: Thu, 14 Aug 2008 00:05:03 +0200
Message-ID: <200808140005.03603.bzolnier@gmail.com>
References: <200808132323.02369.bzolnier@gmail.com> <20080813213149.GC7071@cs181140183.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:28958 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753011AbYHMWHO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 13 Aug 2008 18:07:14 -0400
Received: by ug-out-1314.google.com with SMTP id h2so184021ugf.16
        for <linux-ide@vger.kernel.org>; Wed, 13 Aug 2008 15:07:13 -0700 (PDT)
In-Reply-To: <20080813213149.GC7071@cs181140183.pp.htv.fi>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Adrian Bunk <bunk@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Wednesday 13 August 2008, Adrian Bunk wrote:
> On Wed, Aug 13, 2008 at 11:23:02PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > Because hd.c was moved to drivers/block/ this config option
> > is superfluous now and may be removed.
> > 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > ---
> >  drivers/ide/Kconfig |   38 ++------------------------------------
> >  1 file changed, 2 insertions(+), 36 deletions(-)
> >...
> 
> /me wonders why your patch doesn't touch drivers/ide/Makefile

This is a very good question...

v2 interdiff:
