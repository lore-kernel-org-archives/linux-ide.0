From: Mark Lord <liml@rtr.ca>
Subject: Re: TASKFILE ioctl for libata?
Date: Fri, 17 Feb 2006 09:50:51 -0500
Message-ID: <43F5E2CB.6040804@rtr.ca>
References: <20060215143439.GA17850@harddisk-recovery.com> <43F37A5E.1090301@rtr.ca> <20060216005643.GA28396@harddisk-recovery.com> <43F3E17E.1090701@pobox.com> <43F4461C.1080501@gmail.com> <43F58B7E.4000401@pobox.com> <43F5951B.3020605@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:58566 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S964913AbWBQOut (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 17 Feb 2006 09:50:49 -0500
In-Reply-To: <43F5951B.3020605@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Erik Mouw <erik@harddisk-recovery.com>, linux-ide@vger.kernel.org

Tejun Heo wrote:
>
> Also, as you pointed out, it's hardware-wise impossible to do 
> register-level granuality with SATA and I'll be surprised if any more 
> need for register-level granuality arises than there currently is.

I hope we can keep in mind that libata is about much more than
plain old SATA these days -- it appears about to displace my long
lost IDE subsystem and all of the PATA, Cardbus, and PC-Card devices
that it has long been the sole interface for.

Far be it from me to favour trying to implement the crazy TASKFILE
ioctl() here, though.   We just need to nudge the Passthru mechanism
in the right directions so that it can cover everyone's needs,
including those for low-level vendor commands (for drive test etc..).

Cheers
