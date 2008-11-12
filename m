From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] fix pata-rb532-cf
Date: Wed, 12 Nov 2008 21:57:15 +0100
Message-ID: <200811122157.15791.bzolnier@gmail.com>
References: <1225403251-15705-1-git-send-email-n0-1@freewrt.org> <1226448783-10047-1-git-send-email-n0-1@freewrt.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.186]:18390 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752070AbYKLVcq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 12 Nov 2008 16:32:46 -0500
Received: by ti-out-0910.google.com with SMTP id b6so351755tic.23
        for <linux-ide@vger.kernel.org>; Wed, 12 Nov 2008 13:32:44 -0800 (PST)
In-Reply-To: <1226448783-10047-1-git-send-email-n0-1@freewrt.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Phil Sutter <n0-1@freewrt.org>
Cc: linux-ide@vger.kernel.org, Florian Fainelli <florian@openwrt.org>, Jeff Garzik <jeff@garzik.org>


On Wednesday 12 November 2008, Phil Sutter wrote:
> The following patch series is a complete updated set of changes I did to
> the pata-rb532-cf driver. In ordered detail: fix functionality, restore
> the behaviour of the original driver when doing transfers and eliminate
> compiler warnings.

Looks good to me and you may add

	Acked-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

from me but libata patches should go via Jeff (added to cc:).

Thanks,
Bart
