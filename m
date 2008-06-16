From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [patch 2/2] BAST: Remove old IDE driver
Date: Mon, 16 Jun 2008 21:30:43 +0200
Message-ID: <200806162130.43166.bzolnier@gmail.com>
References: <20080616111625.145158959@fluff.org.uk> <20080616112453.008960070@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.30]:8483 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752684AbYFPT3o (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Jun 2008 15:29:44 -0400
Received: by yx-out-2324.google.com with SMTP id 31so500347yxl.1
        for <linux-ide@vger.kernel.org>; Mon, 16 Jun 2008 12:29:43 -0700 (PDT)
In-Reply-To: <20080616112453.008960070@fluff.org.uk>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ben Dooks <ben-linux@fluff.org>
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com

On Monday 16 June 2008, Ben Dooks wrote:
> Remove the old BAST IDE driver, as we are now using the platform-pata
> support.
> 
> Signed-off-by: Ben Dooks <ben-linux@fluff.org>

ide_platform a.k.a. CONFIG_BLK_DEV_PLATFORM doesn't have "depends on"
limitation so I wonder if it is possible to use it "out-of-the-box" on
ANUBIS now?

[ so I could apply this patch without waiting for patch #1/2 ]

Thanks,
Bart
