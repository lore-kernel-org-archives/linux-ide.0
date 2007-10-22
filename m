From: Tejun Heo <htejun@gmail.com>
Subject: Re: ATA tape drive STT3401A needs DRQ HSM workaround too
Date: Mon, 22 Oct 2007 18:30:46 +0900
Message-ID: <471C6DC6.7010109@gmail.com>
References: <471C6C44.2030607@gmail.com> <20071022103157.5ec97ad6@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.239]:1940 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750869AbXJVJa4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 Oct 2007 05:30:56 -0400
Received: by nz-out-0506.google.com with SMTP id s18so367376nze
        for <linux-ide@vger.kernel.org>; Mon, 22 Oct 2007 02:30:55 -0700 (PDT)
In-Reply-To: <20071022103157.5ec97ad6@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, Mark Lord <liml@rtr.ca>, Jeff Garzik <jeff@garzik.org>, Albert Lee <albertcc@tw.ibm.com>

Alan Cox wrote:
> On Mon, 22 Oct 2007 18:24:20 +0900
> Tejun Heo <htejun@gmail.com> wrote:
> 
>> Hello, all.
>>
>> There was a bug report involving ATA tape drive STT3401A and the drive
>> also sets DRQ with device error and works correctly if the check is
>> ignored.  I saw patch implementing needed horkage.  What's the plan
>> here?  Blacklist all tape drives or individual ones as they come up?
> 
> After discussion with Jeff the horkage patch is going back into the
> bitbucket and the state machine will be changed to consider the DRQ|ERR
> case simply a device error. I sent a patch for that to Andrew just before
> I left on holiday

Alright, thanks.

-- 
tejun
