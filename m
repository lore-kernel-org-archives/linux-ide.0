From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 1/2 v4] ahci add "em_buffer" attribute for AHCI hosts
Date: Thu, 22 Apr 2010 17:34:33 +0200
Message-ID: <4BD06C89.7060102@kernel.org>
References: <1271931333.3745.7.camel@zm-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:45094 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754831Ab0DVPfD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 22 Apr 2010 11:35:03 -0400
In-Reply-To: <1271931333.3745.7.camel@zm-desktop>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Harry Zhang <harry.zhang@amd.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, hane.Huang@amd.com

Hello, Harry.

On 04/22/2010 12:15 PM, Harry Zhang wrote:
> +	/* Since EM buffer is in ABAR, commonly, the buffer size should be
> +	 * less than a page. Check buffer size against PAGE_SIZE in case of
> +	 * some rare instance. Only transfer the first page in this case.
> +	 */

Oh, the PAGE_SIZE limit comes from the way sysfs attributes are
implemented.  The kernel buffer sysfs uses is PAGE_SIZE so
reads/writes can't be larger than that.  If you write past PAGE_SIZE
from show, you'll corrupt someone else's memory.

> +	if (count > PAGE_SIZE) {
> +		dev_printk(KERN_WARNING, dev, 
> +			   "EM read buffer size %u is larger than %lu",
> +			   hpriv->em_buf_sz, PAGE_SIZE);
> +		count = PAGE_SIZE;
> +	}

It probably would be better to use ata_port_printk() and
printk_ratelimit() the message.

Thanks.

-- 
tejun
