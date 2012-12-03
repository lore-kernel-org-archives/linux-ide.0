From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH v3 1/4] sata_highbank: utilize common ata_platform_remove_one()
Date: Mon, 03 Dec 2012 13:55:02 -0500
Message-ID: <50BCF586.1090006@pobox.com>
References: <1354559682-30965-1-git-send-email-computersforpeace@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:36861 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751182Ab2LCSzG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Dec 2012 13:55:06 -0500
Received: by mail-qc0-f174.google.com with SMTP id o22so1669050qcr.19
        for <linux-ide@vger.kernel.org>; Mon, 03 Dec 2012 10:55:05 -0800 (PST)
In-Reply-To: <1354559682-30965-1-git-send-email-computersforpeace@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>
Cc: linux-ide@vger.kernel.org, Tejun Heo <tj@kernel.org>

On 12/03/2012 01:34 PM, Brian Norris wrote:
> Signed-off-by: Brian Norris <computersforpeace@gmail.com>
> Acked-by: Tejun Heo <tj@kernel.org>
> ---
> v2: fix whitespace
> v3: Resend to fix a trivial conflict
>
> (Note: This patch is on its 3rd version, where others are v2.)
>
>   drivers/ata/sata_highbank.c | 12 +-----------
>   1 file changed, 1 insertion(+), 11 deletions(-)

applied 1-4



