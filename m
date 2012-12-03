From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH v2 12/14] sata_highbank: utilize common ata_platform_remove_one()
Date: Mon, 03 Dec 2012 05:17:06 -0500
Message-ID: <50BC7C22.2010608@pobox.com>
References: <1351842388-27210-13-git-send-email-computersforpeace@gmail.com> <1351883526-32412-1-git-send-email-computersforpeace@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:34589 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753528Ab2LCKRJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Dec 2012 05:17:09 -0500
Received: by mail-qa0-f53.google.com with SMTP id a19so1090678qad.19
        for <linux-ide@vger.kernel.org>; Mon, 03 Dec 2012 02:17:09 -0800 (PST)
In-Reply-To: <1351883526-32412-1-git-send-email-computersforpeace@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>
Cc: linux-ide@vger.kernel.org, Tejun Heo <tj@kernel.org>, Sergei Shtylyov <sshtylyov@mvista.com>

On 11/02/2012 03:12 PM, Brian Norris wrote:
> Signed-off-by: Brian Norris <computersforpeace@gmail.com>
> ---
> v2: fix whitespace
>
>   drivers/ata/sata_highbank.c | 12 +-----------
>   1 file changed, 1 insertion(+), 11 deletions(-)

applied patches 1-11

patch #12 failed to apply (even manually), so I stopped there



