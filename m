From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2/5] ide: remove redundant BUG_ON() from [atapi_]reset_pollfunc()
Date: Wed, 6 Feb 2008 21:43:18 +0100
Message-ID: <200802062143.19121.bzolnier@gmail.com>
References: <200802020146.30385.bzolnier@gmail.com> <47A9F78D.20904@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.234]:24840 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755863AbYBFU3i (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 6 Feb 2008 15:29:38 -0500
Received: by wr-out-0506.google.com with SMTP id c48so2870315wra.23
        for <linux-ide@vger.kernel.org>; Wed, 06 Feb 2008 12:29:37 -0800 (PST)
In-Reply-To: <47A9F78D.20904@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Wednesday 06 February 2008, Sergei Shtylyov wrote:
> Bartlomiej Zolnierkiewicz wrote:
> 
> > Same BUG_ON() is present inside ide_set_handler().
> 
>     There is no BUG_ON there -- __ide_set_handler() has a check for the same 
> condition and a printk(KERN_CRIT)... myabe it should be replaced with BUG_ON()...

Yeah, you're right - care to make a patch?

> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> 
> Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> 
> MBR, Sergei
