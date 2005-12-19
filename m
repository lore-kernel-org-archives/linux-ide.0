From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 14/14] ahci: add softreset
Date: Mon, 19 Dec 2005 00:36:07 -0500
Message-ID: <43A646C7.3050503@pobox.com>
References: <20051218133305.GA31571@htj.dyndns.org> <20051218135149.GO31571@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:20613 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030281AbVLSFgL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Dec 2005 00:36:11 -0500
In-Reply-To: <20051218135149.GO31571@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: albertcc@tw.ibm.com, liml@rtr.ca, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Now that libata is smart enought to handle both soft and hard resets,
> add softreset method.

I'm a bit skeptical that polling is what should be done here.  SATA is 
inherently event-driven...

	Jeff



