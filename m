From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2/5] ide: remove redundant BUG_ON() from [atapi_]reset_pollfunc()
Date: Thu, 07 Feb 2008 15:55:59 +0300
Message-ID: <47AAFFDF.7010809@ru.mvista.com>
References: <200802020146.30385.bzolnier@gmail.com> <47A9F78D.20904@ru.mvista.com> <200802062143.19121.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:38750 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753142AbYBGMzH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 7 Feb 2008 07:55:07 -0500
In-Reply-To: <200802062143.19121.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

>>>Same BUG_ON() is present inside ide_set_handler().

>>    There is no BUG_ON there -- __ide_set_handler() has a check for the same 
>>condition and a printk(KERN_CRIT)... myabe it should be replaced with BUG_ON()...

> Yeah, you're right - care to make a patch?

    Replacing printk() with BUG_ON() and also removing BUG_ON() from 
ide_execute_command()? OK, will do...

>>>Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

>>Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
