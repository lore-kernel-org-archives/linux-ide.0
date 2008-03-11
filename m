From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes] libata: don't allow sysfs read access
 to force param
Date: Mon, 10 Mar 2008 20:52:02 -0400
Message-ID: <47D5D7B2.9060105@garzik.org>
References: <47D3C851.8030401@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:50870 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751425AbYCKAwE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 10 Mar 2008 20:52:04 -0400
In-Reply-To: <47D3C851.8030401@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Eric Sesterhenn <snakebyte@gmx.de>

Tejun Heo wrote:
> Buffer for force param is deallocated after initialization, so trying
> to read it via sysfs results in oops.  Don't allow read access to the
> param node.
> 
> Spotted by Eric Sesterhenn.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Eric Sesterhenn <snakebyte@gmx.de>
> ---
>  drivers/ata/libata-core.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

applied


