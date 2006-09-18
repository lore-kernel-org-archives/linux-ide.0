From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] Fix libata resource conflict for legacy mode
Date: Tue, 19 Sep 2006 01:17:20 +0900
Message-ID: <450EC690.3000602@gmail.com>
References: <m3ac4xiacr.fsf@anduin.mandriva.com> <450EA3BA.8010100@gmail.com> <m3zmcxgqu6.fsf@anduin.mandriva.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.236]:18812 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S965282AbWIRQRn (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 18 Sep 2006 12:17:43 -0400
Received: by wr-out-0506.google.com with SMTP id i7so1320505wra
        for <linux-ide@vger.kernel.org>; Mon, 18 Sep 2006 09:17:42 -0700 (PDT)
In-Reply-To: <m3zmcxgqu6.fsf@anduin.mandriva.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arnaud Patard <apatard@mandriva.com>
Cc: linux-ide@vger.kernel.org

Hello, again.

Arnaud Patard wrote:
> -				printk(KERN_WARNING "ata: 0x1f0 IDE port busy\n");
> +				printk(KERN_WARNING "ata: 0x1f0 IDE port busy\n" \
> +						    "ata: conflict with %s\n", conflict->name);

I was thinking something like

"ata: 0x1f0 IDE port busy (conflict with %s)\n"

Other than that,

Acked-by: Tejun Heo <htejun@gmail.com>

-- 
tejun
