From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [patch] pata_winbond: fix module init
Date: Mon, 16 Aug 2010 21:23:03 +0200
Message-ID: <201008162123.03208.bzolnier@gmail.com>
References: <20100803152549.GQ26313@bicker>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:41725 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752691Ab0HPTXe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Aug 2010 15:23:34 -0400
In-Reply-To: <20100803152549.GQ26313@bicker>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dan Carpenter <error27@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, alan@lxorguk.ukuu.org.uk


Hi Dan,

On Tuesday 03 August 2010 05:27:47 pm Dan Carpenter wrote:
> winbond_init_one() returns 0 on success and an error code on failure.
> In the original code, we always just released the regions and return
> -ENODEV.  This was introduce in 2006 by 7e45b0e5f6f6 "[PATCH] libata:
> Winbond support".

You might like to pick up

	http://patchwork.ozlabs.org/patch/39358/

instead..

Thanks.
--
Bartlomiej Zolnierkiewicz
