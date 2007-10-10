From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] ahci: kill leftover from enabling NCQ over PMP
Date: Tue, 09 Oct 2007 21:41:15 -0400
Message-ID: <470C2DBB.5070407@garzik.org>
References: <20071009055950.GI12186@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:41741 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754116AbXJJBlQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 9 Oct 2007 21:41:16 -0400
In-Reply-To: <20071009055950.GI12186@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> ahci had problems with NCQ over PMP and NCQ used to be disabled while
> PMP was attached.  After fixing the problem, the temporary NCQ
> disabling code wasn't removed completely.  Kill the remaining piece.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
>  drivers/ata/ahci.c |    8 --------
>  1 files changed, 0 insertions(+), 8 deletions(-)

applied both


