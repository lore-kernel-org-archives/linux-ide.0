From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] libata: shelved ioctl-get-identity patch
Date: Mon, 06 Jun 2005 11:58:36 -0400
Message-ID: <42A472AC.8040307@rtr.ca>
References: <42A12E80.8090203@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:60689 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S261509AbVFFP6j
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 6 Jun 2005 11:58:39 -0400
In-Reply-To: <42A12E80.8090203@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>

Jeff Garzik wrote:
> 
> I am removing the attached patch from libata-dev.git, as it does not 
> justify the maintenance burden at the present time.  The reasons it sat 
> in libata-dev rather than go upstream are discussed at the top of the 
> patch.
> 
> If anyone feels strongly about this ioctl, take it upon yourself to 
> research the patch fully, address the concerns, and present an updated 
> solution.

That interface is so obsolete it really doesn't matter much now.
Most people seem to use the more modern "hdparm -I" instead
of this ("hdparm -i") one.

For now, "hdparm -I" works just fine using HDIO_DRIVE_CMD,
but if somebody could show me how to use ATA PASSTHRU,
then I'll port it over to that.

Cheers

