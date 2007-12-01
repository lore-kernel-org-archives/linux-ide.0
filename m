From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: report protocol and full CDB on error
Date: Sat, 01 Dec 2007 17:37:29 -0500
Message-ID: <4751E229.4060004@garzik.org>
References: <474D7829.5040303@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:41933 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752038AbXLAWhb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 1 Dec 2007 17:37:31 -0500
In-Reply-To: <474D7829.5040303@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> Protocol and CDB allocation size field are important in determining
> what went wrong with ATAPI commands.  Report them on failure.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
> This one is for #upstream-fixes.  Thanks.

nod, applied


