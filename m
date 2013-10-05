From: Jingoo Han <jg1.han@samsung.com>
Subject: Re: [PATCH 1/2] ahci: use dev_info() instead of printk()
Date: Sat, 05 Oct 2013 09:04:53 +0900
Message-ID: <001401cec15e$84a9f320$8dfdd960$%han@samsung.com>
References: <000601cec0c1$58186d20$08494760$%han@samsung.com>
 <524F2291.2060501@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:54724 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751685Ab3JEAEz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 4 Oct 2013 20:04:55 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MU6000V45K5LT10@mailout1.samsung.com> for
 linux-ide@vger.kernel.org; Sat, 05 Oct 2013 09:04:53 +0900 (KST)
In-reply-to: <524F2291.2060501@cogentembedded.com>
Content-language: ko
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: 'Sergei Shtylyov' <sergei.shtylyov@cogentembedded.com>
Cc: 'Tejun Heo' <tj@kernel.org>, linux-ide@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>

On Saturday, October 05, 2013 5:18 AM, Sergei Shtylyov wrote:
> On 04-10-2013 7:19, Jingoo Han wrote:
> 
> > Use the printk(KERN_INFO,...) call to to dev_info() instead,
> > to tie into the dynamic debugging infrastructure.
> 
>     I can't even parse this sentence, not to mention dev_info() has no
> relation to dynamic debugging.

Hi Sergei Shtylyov,

Right, dev_info() is not related to the dynamic debugging.
I will remove this comment from commit message.
Thank you for your comment. :-)

Best regards,
Jingoo Han

