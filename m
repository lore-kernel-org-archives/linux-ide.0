From: Willy Tarreau <w@1wt.eu>
Subject: Re: [PATCH 1/6] ide: fix setting nIEN on idle devices
Date: Sun, 14 Dec 2008 08:06:21 +0100
Message-ID: <20081214070620.GB31552@1wt.eu>
References: <20081213233925.4653.58008.sendpatchset@localhost.localdomain> <20081213233932.4653.97088.sendpatchset@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 1wt.eu ([62.212.114.60]:1677 "EHLO 1wt.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750879AbYLNHGZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 14 Dec 2008 02:06:25 -0500
Content-Disposition: inline
In-Reply-To: <20081213233932.4653.97088.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Bart,

On Sun, Dec 14, 2008 at 12:39:32AM +0100, Bartlomiej Zolnierkiewicz wrote:
> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Subject: [PATCH] ide: fix setting nIEN on idle devices
> 
> Fix do_ide_request() to operate on previous device / port instead of
> the current one.  The original code was wrong since at least Feb 2002
> (2.4.0 timeframe).

What could be the impact of this bug ? Should I backport your fix to 2.4 ?

Thanks,
Willy

