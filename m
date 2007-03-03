From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: warn if speed limited due to 40-wire cable (v2)
Date: Fri, 02 Mar 2007 19:14:09 -0500
Message-ID: <45E8BDD1.5000804@garzik.org>
References: <45DA44B4.6000209@shaw.ca>	<45E8B42E.7010900@garzik.org> <20070303005433.714d75ad@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:55038 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992784AbXCCAOM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 2 Mar 2007 19:14:12 -0500
In-Reply-To: <20070303005433.714d75ad@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Robert Hancock <hancockr@shaw.ca>, linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Andrew Morton <akpm@osdl.org>

Alan Cox wrote:
>> it seems broken to manipulate xfer_mask after returning from the 
>> driver's ->mode_filter hook.
>>
>> this patch is more than just a speed-limited warning printk, afaics
> 
> I actually suggested that order because the only way the printk can be
> done correctly is for it to be the very last test made. Since the mode
> filter is not told what mode will be used but just subtracts modes that
> are not allowed this should be safe.

OK


