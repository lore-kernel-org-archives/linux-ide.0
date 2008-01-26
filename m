From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 11/12] sata_mv Introduce per-tag SG tables
Date: Fri, 25 Jan 2008 23:26:21 -0500
Message-ID: <479AB66D.5020106@pobox.com>
References: <4798FB68.70400@rtr.ca> <4798FD03.8070206@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:57353 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752730AbYAZE0X (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 25 Jan 2008 23:26:23 -0500
In-Reply-To: <4798FD03.8070206@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> sata_mv Introduce per-tag SG tables.
> 
> In preparation for supporting NCQ, we must allocate separate SG tables
> for each command tag, rather than just a single table per port as before.
> 
> Gen-I hardware cannot do NCQ, though, so we still allocate just a single
> table for that, but populate it in all 32 slots to avoid special-cases
> elsewhere in hotter paths of the code.
> 
> Signed-off-by: Mark Lord <mlord@pobox.com>

ACK (though it obviously must be revised per comments on patch #10)


