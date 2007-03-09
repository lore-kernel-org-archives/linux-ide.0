From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] iomap: implement pcim_iounmap_regions()
Date: Fri, 09 Mar 2007 09:07:56 -0500
Message-ID: <45F16A3C.3020201@garzik.org>
References: <20070309104558.GE32687@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:56461 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1767299AbXCIOH6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 9 Mar 2007 09:07:58 -0500
In-Reply-To: <20070309104558.GE32687@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, gregkh@suse.de, linux-kernel@vger.kernel.org

Tejun Heo wrote:
> Implement pcim_iounmap_regions() - the opposite of
> pcim_iomap_regions().
> 
> Signed-off-by: Tejun heo <htejun@gmail.com>
> ---
> This one is used by libata's new init model and generally useful for
> driver midlayers.  Please push it through libata-dev#upstream.
> 
> Thanks.
> 
>  include/linux/pci.h |    1 +
>  lib/devres.c        |   26 ++++++++++++++++++++++++++
>  2 files changed, 27 insertions(+), 0 deletions(-)

applied


