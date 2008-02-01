From: "saeed bishara" <saeed.bishara@gmail.com>
Subject: Re: [PATCH 2/2 v3] sata_mv: Support SoC controllers
Date: Fri, 1 Feb 2008 21:54:26 +0200
Message-ID: <c70ff3ad0802011154u329604e5y3b68cbd60e63d5e3@mail.gmail.com>
References: <1201733446499-git-send-email-saeed.bishara@gmail.com>
	 <12017334492566-git-send-email-saeed.bishara@gmail.com>
	 <47A34E8A.6020007@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.229]:3445 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755858AbYBATy3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 1 Feb 2008 14:54:29 -0500
Received: by wr-out-0506.google.com with SMTP id c48so1262359wra.23
        for <linux-ide@vger.kernel.org>; Fri, 01 Feb 2008 11:54:28 -0800 (PST)
In-Reply-To: <47A34E8A.6020007@garzik.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, saeed@marvell.com, htejun@gmail.com, liml@rtr.ca, Saeed Bishara <saeed@il.marvell.com>, Paul Mundt <lethal@linux-sh.org>

>
> Unless Paul M objects (pata_platform maintainer), I will rename
> linux/pata_platform.h to linux/ata_platform.h, and we can put your
> mv_sata_platform_data structure in there.
seems better idea.

now I have a patch for the arm subsystem that depends on this patch,
how can I make sure that the new patch will not bypass this one? is
there anything git got to do with this?

saeed
