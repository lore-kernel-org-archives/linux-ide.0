From: Brad Campbell <brad@wasp.net.au>
Subject: Re: libata and md issues with 2.6.9-rc1
Date: Tue, 24 Aug 2004 22:41:52 +0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <412B8BF0.3000705@wasp.net.au>
References: <412B79DF.2000705@wasp.net.au> <412B7D8C.5070403@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wasp.net.au ([203.190.192.17]:18338 "EHLO wasp.net.au")
	by vger.kernel.org with ESMTP id S268182AbUHXSlS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 24 Aug 2004 14:41:18 -0400
In-Reply-To: <412B7D8C.5070403@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, RAID Linux <linux-raid@vger.kernel.org>

Jeff Garzik wrote:
> Is there a difference between 2.6.8.1 and 2.6.9-rc1?
> 
> Any chance we could narrow it down to a specific change?

2.6.6 -> 2.6.7-rc1 is the problem.
Going in search of finer grained change sets now.
