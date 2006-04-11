From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 1/3] libata: disable failed devices only once in ata_bus_probe()
Date: Tue, 11 Apr 2006 13:22:33 -0400
Message-ID: <443BE5D9.609@pobox.com>
References: <1144761989789-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:17797 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751035AbWDKRWk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Apr 2006 13:22:40 -0400
In-Reply-To: <1144761989789-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Devices which consumed all their changes used to be disabled every
> iteration.  This causes unnecessary noise in the console output.
> Disable once and leave alone.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

applied 1-2 out of 3


