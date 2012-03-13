From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 4/4] pata_cmd64x: implement sff_irq_check() method
Date: Tue, 13 Mar 2012 16:45:02 -0400
Message-ID: <4F5FB1CE.8090903@pobox.com>
References: <201203112228.18896.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:47095 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750841Ab2CMUpE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 13 Mar 2012 16:45:04 -0400
Received: by yenl12 with SMTP id l12so1017120yen.19
        for <linux-ide@vger.kernel.org>; Tue, 13 Mar 2012 13:45:04 -0700 (PDT)
In-Reply-To: <201203112228.18896.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On 03/11/2012 03:28 PM, Sergei Shtylyov wrote:
> Implement sff_irq_check() method for both old and new chips.
>
> Signed-off-by: Sergei Shtylyov<sshtylyov@ru.mvista.com>
>
> ---
>   drivers/ata/pata_cmd64x.c |   43 ++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 42 insertions(+), 1 deletion(-)

applied 1-4



