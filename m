From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] sata_sis: fix SCR read breakage
Date: Fri, 19 Oct 2007 22:57:23 -0400
Message-ID: <47196E93.8090901@garzik.org>
References: <20071018025339.GB18322@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:58419 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757289AbXJTC5Z (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 19 Oct 2007 22:57:25 -0400
In-Reply-To: <20071018025339.GB18322@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> SCR read for controllers which uses PCI configuration space for SCR
> access got broken while adding @val argument to SCR accessors.  Fix
> it.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
>  drivers/ata/sata_sis.c |   13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)

applied


