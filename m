From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH -next] ahci: convert ata_link_printk() to ata_link_warn()
Date: Fri, 14 Dec 2012 09:39:21 -0500
Message-ID: <50CB3A19.5040409@pobox.com>
References: <CAPgLHd-4yiFx+t2sgohyYgouvzRzGJkgG3kBFOuOM3MgvzpYJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:35458 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755097Ab2LNOjZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 14 Dec 2012 09:39:25 -0500
Received: by mail-vc0-f174.google.com with SMTP id d16so4024805vcd.19
        for <linux-ide@vger.kernel.org>; Fri, 14 Dec 2012 06:39:24 -0800 (PST)
In-Reply-To: <CAPgLHd-4yiFx+t2sgohyYgouvzRzGJkgG3kBFOuOM3MgvzpYJA@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: yongjun_wei@trendmicro.com.cn, linux-ide@vger.kernel.org

On 12/03/2012 11:39 PM, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>
> Using ata_link_warn() instead of ata_link_printk().
>
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> ---
>   drivers/ata/libahci.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

applied all three



