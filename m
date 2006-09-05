From: Tejun Heo <htejun@gmail.com>
Subject: Re: faulty disk testing
Date: Tue, 05 Sep 2006 16:45:41 +0200
Message-ID: <44FD8D95.4020801@gmail.com>
References: <44FCD328.3020800@emc.com> <44FD662A.6060404@gmail.com> <44FD803B.3040000@pobox.com> <44FD84E8.8000705@gmail.com> <44FD8682.1070305@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.201]:48231 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S965018AbWIEOqD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 5 Sep 2006 10:46:03 -0400
Received: by nz-out-0102.google.com with SMTP id n1so1056251nzf
        for <linux-ide@vger.kernel.org>; Tue, 05 Sep 2006 07:46:03 -0700 (PDT)
In-Reply-To: <44FD8682.1070305@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <mlord@pobox.com>
Cc: Ric Wheeler <ric@emc.com>, Linux-ide <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>

Mark Lord wrote:
> ata_port_wait_eh
> 
> Tejun Heo wrote:
>> ..
>> For Ric's case, I'm waiting for more info.  If EH is looping forever 
>> without reporting to upper layer, it definitely needs fixing, but I 
>> don't think that's the case.
> 
> What happens with the loop in ata_port_wait_eh() for a drive
> which never succeeds in the reset/reinit phase?

Reset/reinit phases don't repeat endlessly.  It's limited by 
ATA_EH_RESET_TRIES and ATA_EH_DEV_TRIES.  When a device uses up all its 
chances, it gets ata_dev_disable()'d and offlined.

-- 
tejun
