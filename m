From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 2/2] Revert "Revert "ide: try to use PIO Mode 0 during
 probe if possible""
Date: Tue, 06 Oct 2009 16:34:05 -0700 (PDT)
Message-ID: <20091006.163405.63274351.davem@davemloft.net>
References: <200910070052.37964.bzolnier@gmail.com>
	<20091006.155705.26059456.davem@davemloft.net>
	<200910070113.05996.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933580AbZJFXeM@vger.kernel.org>
In-Reply-To: <200910070113.05996.bzolnier@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: bzolnier@gmail.com
Cc: torvalds@linux-foundation.org, joao.ramos@inov.pt, david@fries.net, d.stussy@yahoo.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Date: Wed, 7 Oct 2009 01:13:05 +0200

> Many embedded controllers/platforms will have junk PIO timings set initially.

Thanks, that helps a lot.

When David reports back on testing I'll push this stuff around
and queue up patch #1 for -stable.
