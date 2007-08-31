From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 1/2 #upstream] libata: udpate ata_dev_try_classify() arguments
Date: Fri, 31 Aug 2007 05:18:29 -0400
Message-ID: <46D7DCE5.8090700@garzik.org>
References: <20070808053739.GS13674@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:38483 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756501AbXHaJSb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 31 Aug 2007 05:18:31 -0400
In-Reply-To: <20070808053739.GS13674@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, amsden_linux@earthlink.net

Tejun Heo wrote:
> Make ata_dev_try_classify() take a pointer to ata_device instead of
> ata_port/port_number combination for consistency and add @present
> argument.  @present indicates whether the device seems present during
> reset.  It's the result of TF access during softreset and link
> onlineness during hardreset.  @present will be used to improve
> diagnostic failure handling.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
>  drivers/ata/libata-core.c |   31 +++++++++++++++++--------------
>  drivers/ata/pata_scc.c    |    6 ++++--
>  drivers/ata/sata_mv.c     |    2 +-
>  include/linux/libata.h    |    3 ++-
>  4 files changed, 24 insertions(+), 18 deletions(-)

ACK patches 1-2

request rediff+resend


