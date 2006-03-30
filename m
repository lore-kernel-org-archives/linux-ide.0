From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 1/1] libata: ata_dev_init_params() fixes
Date: Wed, 29 Mar 2006 19:30:49 -0500
Message-ID: <442B26B9.7050006@pobox.com>
References: <4427A4B6.4090504@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:39661 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751297AbWC3Aax (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 29 Mar 2006 19:30:53 -0500
In-Reply-To: <4427A4B6.4090504@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: IDE Linux <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>, Tejun Heo <htejun@gmail.com>

Albert Lee wrote:
> ata_dev_init_params() fixes:
> - Get the "heads" and "sectors" parameters from caller instead of implicitly from dev->id[].
> - Return AC_ERR_INVALID instead of 0 if an invalid parameter is found
> 
> Signed-off-by: Albert Lee <albertcc@tw.ibm.com>

applied


