From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes] libata-pmp: 4726 hates SRST
Date: Thu, 10 Jan 2008 16:55:39 -0500
Message-ID: <4786945B.1000202@garzik.org>
References: <4785A156.30302@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:33715 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753978AbYAJVzk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 10 Jan 2008 16:55:40 -0500
In-Reply-To: <4785A156.30302@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> 4726 hates SRST even on non-config ports.  Don't use it.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
>  drivers/ata/libata-pmp.c |   12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)

applied this and propagate timeout patch


