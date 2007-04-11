From: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: [KJ][PATCH] SPIN_LOCK_UNLOCKED cleanup in drivers/ata/pata_winbond.c
Date: Wed, 11 Apr 2007 17:44:40 +0200 (MEST)
Message-ID: <Pine.LNX.4.61.0704111744080.32056@yvahk01.tjqt.qr>
References: <20070411152846.GA11449@arun.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from tmailer.gwdg.de ([134.76.10.23]:43350 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753119AbXDKPsd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 11 Apr 2007 11:48:33 -0400
In-Reply-To: <20070411152846.GA11449@arun.site>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Milind Arun Choudhary <milindchoudhary@gmail.com>
Cc: kernel-janitors@lists.osdl.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, alan@redhat.com


On Apr 11 2007 20:58, Milind Arun Choudhary wrote:
>
>remove SPIN_LOCK_UNLOCKED, use DEFINE_SPINLOCK instead

Don't we have some more places where spinlocks could be janitorified?
Otherwise, ok!


Jan
-- 
