From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: fix hw_sata_spd_limit initialization
Date: Sat, 09 Jun 2007 22:42:26 -0400
Message-ID: <466B6512.1060309@garzik.org>
References: <20070606073555.GA29122@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:35849 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754974AbXFJCm2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 9 Jun 2007 22:42:28 -0400
In-Reply-To: <20070606073555.GA29122@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> hw_sata_spd_limit used to be incorrectly initialized to zero instead
> of UINT_MAX if SPD is zero in SControl register.  This breaks PHY
> speed down.  Fix it.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
>  drivers/ata/libata-core.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

applied


