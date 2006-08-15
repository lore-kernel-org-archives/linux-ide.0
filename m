From: Tejun Heo <htejun@gmail.com>
Subject: Re: Merging libata PATA support into the base kernel
Date: Tue, 15 Aug 2006 22:35:42 +0900
Message-ID: <44E1CDAE.7000203@gmail.com>
References: <1155144599.5729.226.camel@localhost.localdomain>	<44DA4288.6020806@rtr.ca> <44DACE9F.3090909@garzik.org>	<44DCA67B.5070400@rtr.ca> <ebsibq$qgb$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.182]:30905 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1030284AbWHONfr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 15 Aug 2006 09:35:47 -0400
Received: by py-out-1112.google.com with SMTP id z74so6300682pyg
        for <linux-ide@vger.kernel.org>; Tue, 15 Aug 2006 06:35:47 -0700 (PDT)
In-Reply-To: <ebsibq$qgb$1@sea.gmane.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matthieu CASTET <castet.matthieu@free.fr>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Matthieu CASTET wrote:
> Hi,
> 
> On Fri, 11 Aug 2006 11:47:07 -0400, Mark Lord wrote:
> 
>> And libata already has sufficient ioctl compatibility for nearly all
>> purposes with the old drivers/ide stuff.  Yes, there are some more
>> esoteric ioctls that I once implemented in drivers/ide that do not
>> exist for libata, and nobody will miss them.
> IRRC, there nothing for ATAPI ioctl compatibility, there only things for
> ATA.

What do you mean by ATAPI ioctl - TASK or TASKFILE ioctl or something else?

-- 
tejun
