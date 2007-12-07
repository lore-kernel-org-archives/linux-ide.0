From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes] ahci: don't attach if ICH6 is in combined
 mode
Date: Fri, 07 Dec 2007 15:30:00 -0500
Message-ID: <4759AD48.5060701@garzik.org>
References: <47579227.3070007@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:34075 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754811AbXLGUaC (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 7 Dec 2007 15:30:02 -0500
In-Reply-To: <47579227.3070007@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, notting@redhat.com

Tejun Heo wrote:
> ICH6 R/Ms share PCI ID between piix and ahci modes and we've been
> allowing ahci to attach regardless of how BIOS configured it.
> However, enabling AHCI mode when the controller is in combined mode
> can result in unexpected behavior.  Don't attach if the controller is
> in combined mode.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Bill Nottingham <notting@redhat.com>
> ---
>  drivers/ata/ahci.c |   18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)

applied both ahci fixes


