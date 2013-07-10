From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v2] ide: Fix IDE PIO size calculation
Date: Wed, 10 Jul 2013 12:09:27 -0700 (PDT)
Message-ID: <20130710.120927.638384220782145226.davem@davemloft.net>
References: <1371742237-9929-1-git-send-email-Steven.Hill@imgtec.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:44260 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753537Ab3GJTJ2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 10 Jul 2013 15:09:28 -0400
In-Reply-To: <1371742237-9929-1-git-send-email-Steven.Hill@imgtec.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Steven.Hill@imgtec.com
Cc: sjhill@mips.com, linux-ide@vger.kernel.org, Leonid.Yegoshin@imgtec.com

From: "Steven J. Hill" <Steven.Hill@imgtec.com>
Date: Thu, 20 Jun 2013 10:30:37 -0500

> From: Steven J. Hill <sjhill@mips.com>
> 
> IDE PIO calculates the size wrong when passing the parameter
> "ide-core.nodma=0.0" to the kernel.
> 
> Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
> Acked-by: Steven J. Hill <Steven.Hill@imgtec.com>
> 
> Signed-off-by: Steven J. Hill <sjhill@mips.com>

Applied.
