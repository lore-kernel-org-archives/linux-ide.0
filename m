From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2/2] Revert "Revert "ide: try to use PIO Mode 0 during probe if possible""
Date: Wed, 7 Oct 2009 00:52:37 +0200
Message-ID: <200910070052.37964.bzolnier@gmail.com>
References: <200910070027.45678.bzolnier@gmail.com> <20091006.154120.153174904.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f210.google.com ([209.85.218.210]:54109 "EHLO
	mail-bw0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933417AbZJFWyE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Oct 2009 18:54:04 -0400
In-Reply-To: <20091006.154120.153174904.davem@davemloft.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: torvalds@linux-foundation.org, joao.ramos@inov.pt, david@fries.net, d.stussy@yahoo.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Wednesday 07 October 2009 00:41:20 David Miller wrote:
> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Date: Wed, 7 Oct 2009 00:27:45 +0200
> 
> > The root cause of reported system hangs was (now fixed) sis5513 bug
> > and not "ide: try to use PIO Mode 0 during probe if possible" change
> > (commit 6029336426a2b43e4bc6f4a84be8789a047d139e) so the revert was
> > incorrect (it simply replaced one regression with the other one).
> 
> What is this older "regression" fixed by the PIO-0 change?
> 
> You're not explaining it and neither does the commit message for the
> PIO-0 change.

It does:

| Subject: [PATCH] sis5513: fix PIO setup for ATAPI devices
| 
| Clear prefetch setting before potentially (re-)enabling it in
| config_drive_art_rwp() so the transition of the device type on
| the port from ATA to ATAPI (i.e. during warm-plug operation)
| is handled correctly.

and the empty port defaults to ATA-like behavior for the initial PIO setup.

> Please, fill us in :-)

Just connect the dots.. :)
