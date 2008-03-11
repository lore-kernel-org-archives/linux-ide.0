From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] pata_ixp4xx_cf: support single chip-select operation
Date: Mon, 10 Mar 2008 20:51:55 -0400
Message-ID: <47D5D7AB.6060508@garzik.org>
References: <20080306051915.GA18841@cloud.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:50866 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755211AbYCKAv5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 10 Mar 2008 20:51:57 -0400
In-Reply-To: <20080306051915.GA18841@cloud.net.au>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Hamish Moffatt <hamish@cloud.net.au>, linux-ide@vger.kernel.org

Hamish Moffatt wrote:
> Compact flash cards require two chip selects, and pata_ixp4xx_cf
> currently maps these to two IXP4XX chip selects. On our board we use a
> single IXP4XX CS line and decode an address line to split it into two.
> 
> This patch allows this by allowing you to specify the second CS region
> as an offset from the first.
> 
> Signed-off-by: Hamish Moffatt <hamish@cloud.net.au>

applied


