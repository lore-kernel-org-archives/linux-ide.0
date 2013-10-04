From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 2/2] ahci_platform: use dev_info() instead of printk()
Date: Fri, 04 Oct 2013 22:19:41 +0200
Message-ID: <524F22DD.4040001@cogentembedded.com>
References: <000601cec0c1$58186d20$08494760$%han@samsung.com> <000701cec0c1$7138ebe0$53aac3a0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ea0-f177.google.com ([209.85.215.177]:64813 "EHLO
	mail-ea0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751602Ab3JDTTo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 4 Oct 2013 15:19:44 -0400
Received: by mail-ea0-f177.google.com with SMTP id f15so1948829eak.8
        for <linux-ide@vger.kernel.org>; Fri, 04 Oct 2013 12:19:43 -0700 (PDT)
In-Reply-To: <000701cec0c1$7138ebe0$53aac3a0$%han@samsung.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Tejun Heo' <tj@kernel.org>, linux-ide@vger.kernel.org

On 04-10-2013 7:20, Jingoo Han wrote:

> Use the printk(KERN_INFO,...) call to to dev_info() instead,
> to tie into the dynamic debugging infrastructure.

> Also change "raw" printk() call to dev_info() to provide a better
> error message to userspace so it can properly identify the device
> and not just have to guess.

> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

    Same comments to this patch.

WBR, Sergei

