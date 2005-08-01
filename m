From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 3/3] libata handle the case when device returns/needs
 extra data
Date: Mon, 01 Aug 2005 14:37:30 -0400
Message-ID: <42EE6BEA.9050203@pobox.com>
References: <42EE37AB.2000006@tw.ibm.com> <42EE39B6.5030702@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:60385 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261162AbVHAShd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 1 Aug 2005 14:37:33 -0400
In-Reply-To: <42EE39B6.5030702@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Albert Lee <albertcc@tw.ibm.com>
Cc: IDE Linux <linux-ide@vger.kernel.org>

Albert Lee wrote:
> Jeff,
> 
> PATCH 3/3:
> 
> Sometimes the device returns/needs extra data than expected.
> 
> Changes:
>   - Modify __atapi_pio_bytes() to handle the case when device 
> returns/needs extra data.
>     - for read case, discard trailing data from the device
>     - for write case, padding zero data to the device

This patch looks pretty OK to me.

I'll await your responses, to my responses, on the other two patches.

	Jeff



