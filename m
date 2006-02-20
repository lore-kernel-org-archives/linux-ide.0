From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: increase LBA48 max sectors to 65535
Date: Mon, 20 Feb 2006 16:59:03 -0500
Message-ID: <43FA3BA7.3030707@pobox.com>
References: <1139754779159-git-send-email-htejun@gmail.com> <43EF8E61.5040409@pobox.com> <43EFD73D.4070207@gmail.com> <43F011DF.6020203@pobox.com> <20060215072449.GA31691@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:10732 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932626AbWBTV7I (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 20 Feb 2006 16:59:08 -0500
In-Reply-To: <20060215072449.GA31691@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: albertcc@tw.ibm.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> max_hw_sectors/max_sectors separation patch made into the tree,
> increase max_sectors to its hardware limit.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

applied to libata-dev.git#max-sect, and pulled into #ALL.

I want this to get a bit of testing past 2.6.16 release.

	Jeff



