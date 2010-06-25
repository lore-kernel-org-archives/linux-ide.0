From: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: Re: [PATCHv2] ahci_platform: Provide for vendor specific init
Date: Fri, 25 Jun 2010 13:34:57 +0400
Message-ID: <20100625093457.GA16436@oksana.dev.rtsoft.ru>
References: <1277457679-14171-1-git-send-email-jassisinghbrar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:53380 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754254Ab0FYJfD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 25 Jun 2010 05:35:03 -0400
Received: by bwz7 with SMTP id 7so603699bwz.19
        for <linux-ide@vger.kernel.org>; Fri, 25 Jun 2010 02:35:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1277457679-14171-1-git-send-email-jassisinghbrar@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com, Jassi Brar <jassi.brar@samsung.com>

On Fri, Jun 25, 2010 at 06:21:19PM +0900, Jassi Brar wrote:
> From: Jassi Brar <jassi.brar@samsung.com>
> 
> Some AHCI implementations may use Vendor Specific HBA[A0h, FFh]
> and/or Port[70h, 7Fh] registers to 'prepare' for initialization.
> For that, the platform needs memory mapped address of AHCI registers.
> 
> This patch adds the 'mmio' argument and reorders the call to
> platform init function.
> 
> Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
> ---

Looks perfect, thanks!

Acked-by: Anton Vorontsov <cbouatmailru@gmail.com>

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
