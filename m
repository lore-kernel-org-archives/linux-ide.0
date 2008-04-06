From: Adrian Bunk <bunk@kernel.org>
Subject: Re: [PATCH] drivers/ata/sata_via.c - Eliminate "may be used
	uninitialized" warning
Date: Mon, 7 Apr 2008 00:50:54 +0300
Message-ID: <20080406215054.GI30987@cs181133002.pp.htv.fi>
References: <1207518320.1803.52.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp6.pp.htv.fi ([213.243.153.40]:38022 "EHLO smtp6.pp.htv.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753640AbYDFVv1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 6 Apr 2008 17:51:27 -0400
Content-Disposition: inline
In-Reply-To: <1207518320.1803.52.camel@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide <linux-ide@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Sun, Apr 06, 2008 at 02:45:20PM -0700, Joe Perches wrote:
> Called by svia_init_one with a temporary,
> so there's no effective code change.
>...

I'm not getting any warning here.

Are you using an older gcc?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

