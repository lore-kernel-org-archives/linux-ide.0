From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 2.6.21-rc1 2/2] sata_vsc: clean up vsc_sata_interrupt
Date: Fri, 23 Feb 2007 13:11:38 +0900
Message-ID: <45DE697A.50707@gmail.com>
References: <20070221175354.21231.15372.stgit@dwillia2-linux.ch.intel.com> <20070221175652.21231.18391.stgit@dwillia2-linux.ch.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.177]:22825 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750844AbXBWELk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 Feb 2007 23:11:40 -0500
Received: by py-out-1112.google.com with SMTP id a29so187069pyi
        for <linux-ide@vger.kernel.org>; Thu, 22 Feb 2007 20:11:40 -0800 (PST)
In-Reply-To: <20070221175652.21231.18391.stgit@dwillia2-linux.ch.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, jeremy@sgi.com

Hello,

Just one nit.

Dan Williams wrote:
> +	if (unlikely(status == 0xffffffff || status == 0)) {
> +		status && printk(KERN_ERR DRV_NAME ": IRQ status == 0xffffffff, "
> +			"PCI fault or device removal?\n");

People usually don't like using logical operator short circuit for
branching.  Just put another if () and you can also use dev_printk() there.

Other than that, everything looks good.  Thanks for doing this.

-- 
tejun
