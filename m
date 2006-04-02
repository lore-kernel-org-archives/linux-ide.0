From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: print SControl in SATA link status info message
Date: Sun, 02 Apr 2006 11:38:54 -0400
Message-ID: <442FF00E.8090400@pobox.com>
References: <20060402150941.GL13172@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:23427 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750855AbWDBPi5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Apr 2006 11:38:57 -0400
In-Reply-To: <20060402150941.GL13172@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> Now that libata mangles with SControl, it's helpful to print out
> SControl in link status message.  Add it.

Applied, please don't forget signed-off-by.

	Jeff



