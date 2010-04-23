From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 1/2 v4] ahci add "em_buffer" attribute for AHCI hosts
Date: Fri, 23 Apr 2010 08:27:23 +0200
Message-ID: <4BD13DCB.2090902@kernel.org>
References: <1271931333.3745.7.camel@zm-desktop>	 <4BD06C89.7060102@kernel.org> <1271990828.3821.16.camel@zm-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:51915 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753629Ab0DWG2Y (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 23 Apr 2010 02:28:24 -0400
In-Reply-To: <1271990828.3821.16.camel@zm-desktop>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Harry Zhang <harry.zhang@amd.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, shane.Huang@amd.com

Hello,

On 04/23/2010 04:47 AM, Harry Zhang wrote:
>> Oh, the PAGE_SIZE limit comes from the way sysfs attributes are
>> implemented.  The kernel buffer sysfs uses is PAGE_SIZE so
>> reads/writes can't be larger than that.  If you write past PAGE_SIZE
>> from show, you'll corrupt someone else's memory.
> Yes, I know that. I just think the EM read buffer size should not larger
> than the PAGE_SIZE in common, and thus, should not break the sysfs
> attributes r/w buffer limitation. Anyway, I will shorten the comment.

Oh I see.

>> It probably would be better to use ata_port_printk() and
>> printk_ratelimit() the message.
>
> OK. I could not determine which is better. I think the EM buffer is
> belong to the host rather than a port, so I chose the "dev_printk".
> BTW, should this be a warning or an error?

The buffer is per ATA port, so I think it would be better to use
ata_port_printk().  Hmmm... as the read will succeed anyway with
truncated message body, maybe warning is better?

Thanks.

-- 
tejun
