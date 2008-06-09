From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] Support SB700 SATA controller PMP
Date: Mon, 09 Jun 2008 14:11:58 +0900
Message-ID: <484CBB9E.8010701@gmail.com>
References: <1212659914.6639.12.camel@zm-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.182]:10881 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751978AbYFIFMG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 9 Jun 2008 01:12:06 -0400
Received: by wa-out-1112.google.com with SMTP id j37so1681513waf.23
        for <linux-ide@vger.kernel.org>; Sun, 08 Jun 2008 22:12:05 -0700 (PDT)
In-Reply-To: <1212659914.6639.12.camel@zm-desktop>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: shane.huang@amd.com
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Shane Huang wrote:
> This patch supports SB700 SATA PMP, this patch depends on
> the SB600 SATA PMP patch sent two days ago.
> 
> Signed-off-by: Shane Huang <shane.huang@amd.com>

Acked-by: Tejun Heo <htejun@gmail.com>

I think this can be rolled into the previous patch when it gets updated
tho.  Thanks.

-- 
tejun
