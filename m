From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: achi.c bug ?
Date: Mon, 25 Feb 2008 17:55:35 -0500
Message-ID: <47C34767.8090501@pobox.com>
References: <1ada88ce0802160007s632126eiccf1031616c4e53c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:48871 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761859AbYBYWzi (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 25 Feb 2008 17:55:38 -0500
In-Reply-To: <1ada88ce0802160007s632126eiccf1031616c4e53c@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: chaoyang wang <chaoyang.wang@gmail.com>
Cc: linux-ide@vger.kernel.org

chaoyang wang wrote:
> Dear Jeff,
>  
> I was looking at the kernel 2.6.21 code of the achi driver and found 
> that the sg_table_size was set to 168, while the libata set the maximum 
> sg to be 128 somewhere else. When a requester issues a request with >128 
> sgs to the ahci attached device, the system would fall to a scilent 
> error.  So, I could not count on the scsi probe 
> of scsi_device->->host->sg_tablesize that was read from achi.
>  
> Any advise on the better fix?
>  
> Thanks you very much,

Can you be more specific about "somewhere else"?

Reducing s/g table size should be quite safe.

	Jeff



