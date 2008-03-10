From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] ATA: logical-bitwise and confusion in ahci_save_initial_config()
Date: Mon, 10 Mar 2008 20:42:18 +0900
Message-ID: <47D51E9A.1070301@gmail.com>
References: <47D44BC0.2090906@tiscali.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.179]:64087 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750940AbYCJLm1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 10 Mar 2008 07:42:27 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2234868wah.23
        for <linux-ide@vger.kernel.org>; Mon, 10 Mar 2008 04:42:27 -0700 (PDT)
In-Reply-To: <47D44BC0.2090906@tiscali.nl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Roel Kluin <12o3l@tiscali.nl>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>

Roel Kluin wrote:
> logical-bitwise & confusion
> 
> Signed-off-by: Roel Kluin <12o3l@tiscali.nl>

Acked-by: Tejun Heo <htejun@gmail.com>

Thanks for spotting this.

-- 
tejun
