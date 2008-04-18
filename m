From: David Milburn <dmilburn@redhat.com>
Subject: Re: [PATCH] libata-core: set debug logging via module param
Date: Fri, 18 Apr 2008 10:32:09 -0500
Message-ID: <20080418153209.GA7402@dhcp-210.hsv.redhat.com>
References: <20080417230406.GA6266@dhcp-210.hsv.redhat.com> <48089179.40503@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:51474 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752225AbYDRPjG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 18 Apr 2008 11:39:06 -0400
Content-Disposition: inline
In-Reply-To: <48089179.40503@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org

On Fri, Apr 18, 2008 at 04:18:01PM +0400, Sergei Shtylyov wrote:
> Hello.
> 
> 
>    This sets the default mask to show no log messages instead of 
>    ATA_MSG_DRV | ATA_MSG_ERR | ATA_MSG_WARN as it was before the patch.
> 
> WBR, Sergei

Thanks Sergei, I will repost.

David
