From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 7/8] libata: Fix a potential race condition in ata_scsi_park_show()
Date: Tue, 04 Nov 2008 01:10:54 -0500
Message-ID: <490FE76E.1050007@garzik.org>
References: <1225706469-27870-1-git-send-email-tj@kernel.org> <1225706469-27870-8-git-send-email-tj@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:45544 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754479AbYKDGK6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 Nov 2008 01:10:58 -0500
In-Reply-To: <1225706469-27870-8-git-send-email-tj@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, Elias Oltmanns <eo@nebensachen.de>

Tejun Heo wrote:
> From: Elias Oltmanns <eo@nebensachen.de>
> 
> Peter Moulder has pointed out that there is a slight chance that a
> negative value might be passed to jiffies_to_msecs() in
> ata_scsi_park_show(). This is fixed by saving the value of jiffies in a
> local variable, thus also reducing code since the volatile variable
> jiffies is accessed only once.
> 
> Signed-off-by: Elias Oltmanns <eo@nebensachen.de>
> Signed-off-by: Tejun Heo <tj.kernel.org>
> ---
>  drivers/ata/libata-scsi.c |    7 ++++---
>  1 files changed, 4 insertions(+), 3 deletions(-)

applied


