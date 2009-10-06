From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 2/2] Revert "Revert "ide: try to use PIO Mode 0 during
 probe if possible""
Date: Tue, 06 Oct 2009 15:41:20 -0700 (PDT)
Message-ID: <20091006.154120.153174904.davem@davemloft.net>
References: <200910070027.45678.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:37485
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932887AbZJFWlZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Oct 2009 18:41:25 -0400
In-Reply-To: <200910070027.45678.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: torvalds@linux-foundation.org, joao.ramos@inov.pt, david@fries.net, d.stussy@yahoo.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Date: Wed, 7 Oct 2009 00:27:45 +0200

> The root cause of reported system hangs was (now fixed) sis5513 bug
> and not "ide: try to use PIO Mode 0 during probe if possible" change
> (commit 6029336426a2b43e4bc6f4a84be8789a047d139e) so the revert was
> incorrect (it simply replaced one regression with the other one).

What is this older "regression" fixed by the PIO-0 change?

You're not explaining it and neither does the commit message for the
PIO-0 change.

Please, fill us in :-)
