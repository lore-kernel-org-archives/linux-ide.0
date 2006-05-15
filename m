From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Promise TX4 + SiI 3726 : only one disk visible
Date: Mon, 15 May 2006 19:58:35 -0400
Message-ID: <446915AB.8000205@garzik.org>
References: <6EB652BF05BEE44FA2A29B23F3A71528045B3857@UBIMAIL1.ubisoft.org> <44690D90.2030208@gmail.com> <44691172.8040402@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:13524 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750835AbWEOX6h (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 15 May 2006 19:58:37 -0400
In-Reply-To: <44691172.8040402@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jerome Vuarand <jerome.vuarand@ubisoft.com>, linux-ide@vger.kernel.org, jerome.vuarand@gmail.com

Jeff Garzik wrote:
> I just looked in the docs, for Port Multiplier stuff.  There is a single 
> vendor-proprietary 4-bit "PM port" MMIO register for each channel (aka 
> each SATA port).

I take that back.  PDC205xx also has a 'PM Port' field in its 
per-command S/G DMA packets.

	Jeff


