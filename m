From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH 4/5] ide: Add support for TRIM
Date: Wed, 08 Apr 2009 10:33:09 -0400
Message-ID: <49DCB5A5.7040100@rtr.ca>
References: <1238683047-13588-1-git-send-email-willy@linux.intel.com> <1238683047-13588-2-git-send-email-willy@linux.intel.com> <1238683047-13588-3-git-send-email-willy@linux.intel.com> <1238683047-13588-4-git-send-email-willy@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:51594 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752080AbZDHOdL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 8 Apr 2009 10:33:11 -0400
In-Reply-To: <1238683047-13588-4-git-send-email-willy@linux.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matthew Wilcox <willy@linux.intel.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, jgarzik@redhat.com, David Woodhouse <David.Woodhouse@intel.com>

Matthew Wilcox wrote:
> From: David Woodhouse <David.Woodhouse@intel.com>
> 
> Signed-off-by: David Woodhouse <David.Woodhouse@intel.com>
> [modified to reduce amount of special casing needed for discard]
> Signed-off-by: Matthew Wilcox <willy@linux.intel.com>
> ---
..
> +	task->tf.command = ATA_CMD_DSM;
> +	task->tf.feature = ATA_DSM_TRIM;
> +	task->tf.hob_feature = 0x00;
> +	task->tf.nsect = size / 512;
> +	task->tf.hob_nsect = (size / 512) >> 8;
..

Matthew (or others),

Could you perhaps explain what the purpose of the data portion
of this command is for?  The draft ATA spec I have here has mangled
text in the description -- like it's missing a crucial sentence there.

So it's not obvious exactly why this command even needs data to
be transfered.

Thanks
