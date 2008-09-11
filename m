From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH 1/2] ide: Add tx4939ide driver
Date: Fri, 12 Sep 2008 00:03:49 +0900 (JST)
Message-ID: <20080912.000349.18312151.anemo@mba.ocn.ne.jp>
References: <48C6B768.4010200@ru.mvista.com>
	<20080911.003222.51867360.anemo@mba.ocn.ne.jp>
	<48C7EDE4.3090400@ru.mvista.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mba.ocn.ne.jp ([122.1.235.107]:51753 "EHLO smtp.mba.ocn.ne.jp"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752521AbYIKPDs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 Sep 2008 11:03:48 -0400
In-Reply-To: <48C7EDE4.3090400@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: sshtylyov@ru.mvista.com
Cc: linux-mips@linux-mips.org, linux-ide@vger.kernel.org, bzolnier@gmail.com, ralf@linux-mips.org

On Wed, 10 Sep 2008 19:55:16 +0400, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
> > But the "Command Transfer Mode Select" bits affects access timings on
> > setting task registers for DMA command.
> 
>     So what? PIO and DMA are different protocols on IDE bus, so they shouldn't 
> affect each other. The IDE core will always tune the best PIO mode for you, so 
> the optimal command timings will be set.

Hmm, that would be a thing I had misunderstood.  I thought
set_pio_mode is not called when the drive was DMA capable.

Thank you for detailed review!

---
Atsushi Nemoto
