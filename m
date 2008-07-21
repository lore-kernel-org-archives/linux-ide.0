From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 3/4] ide: <asm-sparc64/ide.h>: use __raw_{read,write}w()
Date: Mon, 21 Jul 2008 16:51:53 -0700 (PDT)
Message-ID: <20080721.165153.42509005.davem@davemloft.net>
References: <20080714153825.9085.98433.sendpatchset@localhost.localdomain>
	<20080714153839.9085.92881.sendpatchset@localhost.localdomain>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <sparclinux-owner@vger.kernel.org>
In-Reply-To: <20080714153839.9085.92881.sendpatchset@localhost.localdomain>
Sender: sparclinux-owner@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, sparclinux@vger.kernel.org, wli@holomorphy.com
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Date: Mon, 14 Jul 2008 17:38:39 +0200

> Use __raw_{read,write}w() in __ide_{in,out}sw()
> and remove no longer needed {in,out}w_be().
> 
> Cc: David S. Miller <davem@davemloft.net>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Applied, thanks Bart.
