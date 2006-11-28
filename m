From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: don't request sense if the port is frozen
Date: Tue, 28 Nov 2006 04:05:43 -0500
Message-ID: <456BFBE7.8080305@pobox.com>
References: <20061121014051.GQ2184@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:10883 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S935734AbWK1JFp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 28 Nov 2006 04:05:45 -0500
In-Reply-To: <20061121014051.GQ2184@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> If EH command is issued to a frozen port, it fails with AC_ERR_SYSTEM.
> libata used to request sense even when the port is frozen needlessly
> adding AC_ERR_SYSTEM to err_mask.  Don't do it.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

ACK


