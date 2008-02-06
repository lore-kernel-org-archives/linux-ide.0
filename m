From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2/5] ide: remove redundant BUG_ON() from [atapi_]reset_pollfunc()
Date: Wed, 06 Feb 2008 21:08:13 +0300
Message-ID: <47A9F78D.20904@ru.mvista.com>
References: <200802020146.30385.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:27094 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751230AbYBFSHV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 6 Feb 2008 13:07:21 -0500
In-Reply-To: <200802020146.30385.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> Same BUG_ON() is present inside ide_set_handler().

    There is no BUG_ON there -- __ide_set_handler() has a check for the same 
condition and a printk(KERN_CRIT)... myabe it should be replaced with BUG_ON()...

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
