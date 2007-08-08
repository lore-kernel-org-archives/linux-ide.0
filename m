From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] ata_piix: update map 10b for ich8m
Date: Tue, 07 Aug 2007 20:57:02 -0400
Message-ID: <46B914DE.3040207@garzik.org>
References: <20070806174327.GP13674@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:60572 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1765438AbXHHA5F (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 7 Aug 2007 20:57:05 -0400
In-Reply-To: <20070806174327.GP13674@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, kristen.c.accardi@intel.com, stable@kernel.org

Tejun Heo wrote:
> Fix map entry 10b for ich8.  It's [P0 P2 IDE IDE] like ich6 / ich6m.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: <Kristen Carlson Accardi> kristen.c.accardi@intel.com
> ---
> Many users can be hit by this.  Please consider for -stable.  Thanks.
> 
>  drivers/ata/ata_piix.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

applied


