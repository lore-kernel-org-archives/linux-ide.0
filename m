From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2.6.15-rc2-mm1] scsi: fix compiler-warning for sata_vsc.c
Date: Sat, 26 Nov 2005 19:55:31 -0500
Message-ID: <20051127005531.GB2246@havoc.gtf.org>
References: <4388F170.9050703@student.ltu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.61.125.42]:3801 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1750802AbVK0Azc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 26 Nov 2005 19:55:32 -0500
Content-Disposition: inline
In-Reply-To: <4388F170.9050703@student.ltu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Richard Knutsson <ricknu-0@student.ltu.se>
Cc: linux-ide@vger.kernel.org

On Sun, Nov 27, 2005 at 12:36:16AM +0100, Richard Knutsson wrote:
> From: Richard Knutsson <ricknu-0@student.ltu.se>
> 
> Fix compiler-warning "... makes pointer from integer without a cast".
> 
> Signed-off-by: Richard Knutsson <ricknu-0@student.ltu.se>
> ---
> Jeremy Higdon, sorry but I couldn't find your mail-address.

NAK, check the archives and fix the real problem.

	Jeff



