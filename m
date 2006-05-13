From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [ANNOUNCE] libata EH/NCQ/hotplug/PM git tree
Date: Sat, 13 May 2006 00:09:59 -0400
Message-ID: <44655C17.6000601@pobox.com>
References: <44614592.7080301@gmail.com> <446536C5.80503@pobox.com> <44653807.3030101@gmail.com> <44655496.9030402@pobox.com> <44655986.3060007@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:20450 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932322AbWEMEKP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 13 May 2006 00:10:15 -0400
In-Reply-To: <44655986.3060007@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Albert Lee <albertcc@tw.ibm.com>, Jens Axboe <axboe@suse.de>, Edward Falk <efalk@google.com>, Carlos Pardo <Carlos.Pardo@siliconimage.com>, Raymond Liu <Raymond.Liu@siliconimage.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> That cmd-switching PM support is what AHCI SPM bit indicates.  As of 
> v1.1, AHCI doesn't define FIS-switching PM support yet.

Right you are; see, told you my brain was frazzled.


> Which is understandable considering AHCI doesn't construct FISes itself. 
>  I don't think PM requires more hardware support than being capable for 
> setting PMP in the FISes, which AHCI certainly can (standing down on 
> collision for SDB notify aside).  I can give it a shot but it clearly 
> violates the spec, and even if it works, we would need to print big fat 
> warning message while attaching PM.

Setting the PMP field during FIS construction would work, I should 
think, for outgoing FIS's.  Not sure how incoming FISs would behave.

	Jeff


