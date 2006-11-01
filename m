From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] sata_nv: SRST sometimes fails after hotplug, use HRST_TO_RESUME
Date: Wed, 01 Nov 2006 00:14:10 -0500
Message-ID: <45482D22.3020307@garzik.org>
References: <20060927082005.GA14569@jim.sh> <20060928051415.GG25800@htj.dyndns.org> <20060928062357.GA12266@jim.sh> <20060928080442.GJ25800@htj.dyndns.org> <20060928083430.GA18596@jim.sh> <20060928084922.GL25800@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:36315 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1946064AbWKAFOO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Nov 2006 00:14:14 -0500
In-Reply-To: <20060928084922.GL25800@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jim Paris <jim@jtan.com>, mail@philipp-wagner.com, linux-ide@vger.kernel.org, justin@jmicron.com

Tejun Heo wrote:
> NV controllers sometimes fail to perform softreset after hotplug.
> Make it use hardreset to resume link.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

applied


