From: "saeed bishara" <saeed.bishara@gmail.com>
Subject: Re: [PATCH 2/2] sata_mv: remove iounmap in mv_platform_remove
Date: Thu, 14 Feb 2008 20:33:32 +0200
Message-ID: <c70ff3ad0802141033g712be583p3d4a0269568803c6@mail.gmail.com>
References: <12029369502995-git-send-email-saeed@marvell.com>
	 <12029369532977-git-send-email-saeed@marvell.com>
	 <47B345A6.9000605@pobox.com>
	 <c70ff3ad0802140456v50e0b0faj2c2b1f7d11c60fc5@mail.gmail.com>
	 <47B46FA4.4070606@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from qb-out-0506.google.com ([72.14.204.228]:37780 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753936AbYBNSdf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 Feb 2008 13:33:35 -0500
Received: by qb-out-0506.google.com with SMTP id o24so4790041qba.1
        for <linux-ide@vger.kernel.org>; Thu, 14 Feb 2008 10:33:34 -0800 (PST)
In-Reply-To: <47B46FA4.4070606@rtr.ca>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Mark Lord <mlord@pobox.com>, Saeed Bishara <saeed@marvell.com>, jeff@garzik.org, htejun@gmail.com, linux-ide@vger.kernel.org, nico@cam.org, byron.bbradley@gmail.com

>
>  Mmm.. sounds like a bug to me.  Possibly two bugs:
>
>  1. the ioremap() should fail if the range is already mapped, and
>  2. we should free the resources on module unload.
>
>  I suppose this would be mostly automatic if the code simply
>  were to use devm_ioremap() instead of ioremap().
my understanding for the /proc/iomem was totaly wrong..
the ioremap() actually allocated different address each time, I don't
know if should fail if the range is already mapped, but maybe the name
(remap) hints that it is shouldn't.
anyway, I replaced ioremap with devm_ioremap and it looks fine. I'll
send the new patch in different email.

saeed
