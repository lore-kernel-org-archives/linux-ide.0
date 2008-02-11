From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH 7/8] ide: add struct ide_port_info instances to legacy
 host drivers
Date: Mon, 11 Feb 2008 21:01:28 +0900 (JST)
Message-ID: <20080211.210128.108308594.anemo@mba.ocn.ne.jp>
References: <20080211.010729.115910395.anemo@mba.ocn.ne.jp>
	<200802101804.49154.bzolnier@gmail.com>
	<200802110016.08078.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mba.ocn.ne.jp ([122.1.235.107]:57003 "EHLO smtp.mba.ocn.ne.jp"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752315AbYBKMBO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 11 Feb 2008 07:01:14 -0500
In-Reply-To: <200802110016.08078.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 11 Feb 2008 00:16:07 +0100, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> > It is too late for -git but not too late for 2.6.25-rc1. ;-)
> > 
> > Could you make a patch please?
> 
> I went ahead and made a patch (sorry, I needed it for git pull request :).
> 
> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Subject: [PATCH] ide: ide_init_port() bugfix

Thanks!  Looks sane for me :)

---
Atsushi Nemoto
