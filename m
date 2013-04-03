From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: fix DMA to stack in reading devslp_timing parameters
Date: Wed, 03 Apr 2013 19:46:23 -0400
Message-ID: <515CBF4F.8020705@pobox.com>
References: <1364558095.14860.59.camel@i7.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f42.google.com ([209.85.216.42]:33804 "EHLO
	mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762037Ab3DCXq0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 3 Apr 2013 19:46:26 -0400
Received: by mail-qa0-f42.google.com with SMTP id bv4so2358093qab.1
        for <linux-ide@vger.kernel.org>; Wed, 03 Apr 2013 16:46:25 -0700 (PDT)
In-Reply-To: <1364558095.14860.59.camel@i7.infradead.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>
Cc: Shane Huang <shane.huang@amd.com>, Jeff Garzik <jgarzik@redhat.com>, linux-ide@vger.kernel.org

On 03/29/2013 07:54 AM, David Woodhouse wrote:
> Commit 803739d25c2343da6d2f95eebdcbc08bf67097d4 ("[libata] replace
> sata_settings with devslp_timing"), which was also Cc: stable, used a
> stack buffer to receive data from ata_read_log_page(), which triggers
> the following warning:
>   ahci 0000:00:1f.2: DMA-API: device driver maps memory fromstack [addr=ffff880140469948]
>
> Fix this by using ap->sector_buf instead of a stack buffer.
>
> Signed-off-by: David Woodhouse <David.Woodhouse@intel.com>
> Cc: stable@kernel.org

applied


> I'm somewhat ignorant, but it looks like this is kind of thing is what
> ap->sector_buf is *for*, right? And in ata_dev_configure() nobody else
> is likely to be using it?

yep



