From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] IDE: ide-floppy, remove unnecessary NULL check
Date: Mon, 22 Nov 2010 11:39:47 -0800 (PST)
Message-ID: <20101122.113947.48491153.davem@davemloft.net>
References: <1289034412-24278-1-git-send-email-jslaby@suse.cz>
	<1289034412-24278-3-git-send-email-jslaby@suse.cz>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:38370
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757186Ab0KVTjV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 Nov 2010 14:39:21 -0500
In-Reply-To: <1289034412-24278-3-git-send-email-jslaby@suse.cz>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jslaby@suse.cz
Cc: jirislaby@gmail.com, linux-kernel@vger.kernel.org, hch@lst.de, linux-ide@vger.kernel.org

From: Jiri Slaby <jslaby@suse.cz>
Date: Sat,  6 Nov 2010 10:06:51 +0100

> Stanse founf that rq in ide_floppy_callback cannot be NULL, because it
> is dereferenced all around. So remove the superfluous check.
> 
> This appeared after blk_* macors removal.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>

Applied with commit message typos fixed.

Thanks.
