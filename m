From: Mark Lord <liml@rtr.ca>
Subject: Re: Libata and Drive Write Cache Disable
Date: Tue, 07 Nov 2006 12:11:48 -0500
Message-ID: <4550BE54.7060508@rtr.ca>
References: <632b79000611060948v267bd33ahf1ff585cf4de9fcc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:46342 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S965541AbWKGRLt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 7 Nov 2006 12:11:49 -0500
In-Reply-To: <632b79000611060948v267bd33ahf1ff585cf4de9fcc@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Don Dupuis <dondster@gmail.com>
Cc: linux-ide@vger.kernel.org

Don Dupuis wrote:
> When will this be supported in libata. I have drives attached to a
> AHCI controller and want to turn drive write cache OFF. Sdparm will
> not allow me to do so. Any work-arounds or patches would be greatly
> appreciated. I am also using kernel 2.6.18.

hdparm -W0 /dev/sda

It works just fine.

Cheers
