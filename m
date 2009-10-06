From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2/2] Revert "Revert "ide: try to use PIO Mode 0 during probe if possible""
Date: Wed, 7 Oct 2009 01:13:05 +0200
Message-ID: <200910070113.05996.bzolnier@gmail.com>
References: <200910070027.45678.bzolnier@gmail.com> <200910070052.37964.bzolnier@gmail.com> <20091006.155705.26059456.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f227.google.com ([209.85.220.227]:64467 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753261AbZJFXPI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Oct 2009 19:15:08 -0400
In-Reply-To: <20091006.155705.26059456.davem@davemloft.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: torvalds@linux-foundation.org, joao.ramos@inov.pt, david@fries.net, d.stussy@yahoo.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Wednesday 07 October 2009 00:57:05 David Miller wrote:
> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Date: Wed, 7 Oct 2009 00:52:37 +0200
> 
> > On Wednesday 07 October 2009 00:41:20 David Miller wrote:
> >> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> >> Date: Wed, 7 Oct 2009 00:27:45 +0200
> >> 
> >> > The root cause of reported system hangs was (now fixed) sis5513 bug
> >> > and not "ide: try to use PIO Mode 0 during probe if possible" change
> >> > (commit 6029336426a2b43e4bc6f4a84be8789a047d139e) so the revert was
> >> > incorrect (it simply replaced one regression with the other one).
> >> 
> >> What is this older "regression" fixed by the PIO-0 change?
> >> 
> >> You're not explaining it and neither does the commit message for the
> >> PIO-0 change.
> > 
> > It does:
> > 
> > | Subject: [PATCH] sis5513: fix PIO setup for ATAPI devices
> 
> Sorry, I wasn't clear.
> 
> I'm talking about commit 6029336426a2b43e4bc6f4a84be8789a047d139e, it
> doesn't say why we want to try PIO 0 mode during probe.

For the same reason that libata wants it.

Many embedded controllers/platforms will have junk PIO timings set initially.

Now that your manager's ambition is satisfied could you please go help
some other subsystem for the moment so we can fix ide in the meantime? :)
