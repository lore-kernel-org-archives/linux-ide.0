From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 8/8] libata: implement ATA_HORKAGE_ATAPI_MOD16_DMA and
 apply it
Date: Tue, 04 Nov 2008 01:11:03 -0500
Message-ID: <490FE777.1060207@garzik.org>
References: <1225706469-27870-1-git-send-email-tj@kernel.org> <1225706469-27870-9-git-send-email-tj@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:45549 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753919AbYKDGLH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 Nov 2008 01:11:07 -0500
In-Reply-To: <1225706469-27870-9-git-send-email-tj@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, John Clark <clarkjc@runbox.com>

Tejun Heo wrote:
> libata always uses PIO for ATAPI commands when the number of bytes to
> transfer isn't multiple of 16 but quantum DAT72 chokes on odd bytes
> PIO transfers.  Implement a horkage to skip the mod16 check and apply
> it to the quantum device.
> 
> This is reported by John Clark in the following thread.
> 
>   http://thread.gmane.org/gmane.linux.ide/34748
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: John Clark <clarkjc@runbox.com>
> ---
>  drivers/ata/libata-core.c |    4 +++-
>  include/linux/libata.h    |    2 ++
>  2 files changed, 5 insertions(+), 1 deletions(-)

applied


