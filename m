From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: fix ata_xfer_tbl termination
Date: Fri, 31 Mar 2006 10:16:38 -0500
Message-ID: <442D47D6.70109@pobox.com>
References: <20060331134852.GF13172@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:45242 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751318AbWCaPQj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 31 Mar 2006 10:16:39 -0500
In-Reply-To: <20060331134852.GF13172@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> ata_xfer_tbl is terminated by entry with -1 as ->shift.  However,
> ->shift was unsigned int making the termination condition bogus.  This
> patch converts ->shift and ->bits to int.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

applied


