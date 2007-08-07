From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: implement BROKEN_HPA horkage and apply it to
 HDS724040KLSA80
Date: Tue, 07 Aug 2007 12:52:32 -0400
Message-ID: <46B8A350.20409@garzik.org>
References: <20070807054250.GQ13674@htj.dyndns.org>	<20070807162529.1781b21c@the-village.bc.nu>	<46B89177.2040209@gmail.com>	<46B8941A.8080206@garzik.org> <20070807175759.149bdf9f@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:35801 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755714AbXHGQwh (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 7 Aug 2007 12:52:37 -0400
In-Reply-To: <20070807175759.149bdf9f@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, kelk1@comcast.net, lcapitulino@mandriva.com.br, Ben Collins <bcollins@ubuntu.com>

Alan Cox wrote:
> On Tue, 07 Aug 2007 11:47:38 -0400
> Jeff Garzik <jeff@garzik.org> wrote:
> 
>> People should check out Ben C's HPA fixes and cleanups, too. (attached)
>>
>> I was hoping one of the original libata HPA authors would review that in 
>> depth and integrate.  (it no longer applies cleanly)
> 
> Looks basically sound but we should still probably move over this bit of
> the old IDE paranoia as well:

Oh quite agreed...

	Jeff




