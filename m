From: Tejun Heo <htejun@gmail.com>
Subject: Re: faulty disk testing
Date: Tue, 05 Sep 2006 13:57:30 +0200
Message-ID: <44FD662A.6060404@gmail.com>
References: <44FCD328.3020800@emc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.181]:32086 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751489AbWIEL5p (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 5 Sep 2006 07:57:45 -0400
Received: by py-out-1112.google.com with SMTP id n25so3111570pyg
        for <linux-ide@vger.kernel.org>; Tue, 05 Sep 2006 04:57:45 -0700 (PDT)
In-Reply-To: <44FCD328.3020800@emc.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ric Wheeler <ric@emc.com>
Cc: Linux-ide <linux-ide@vger.kernel.org>, Mark Lord <mlord@pobox.com>, Jeff Garzik <jgarzik@pobox.com>

Hello, Ric.

[cc'ing Jeff]

Ric Wheeler wrote:
> Hi Tejun,
> 
> We have been trying to inject some errors on some drives & validate that 
> the new error handling kicks out drives.
> 
> Using 2.6.18rc3 on a box with 4 drives - 3 good & one with an 
> artificially created ecc error in the 4-way MD RAID1 partition.
> 
> The error handling worked through the various transitions, but did not 
> give up on the drive well enough to let the boot continue using the 
> other 3.

I suppose the introduced errors are transient and some sectors complete 
IO successfully between errors, right?  As long as the drive responds to 
recovery action (provide signature on reset, ID data on IDENTIFY and 
responds to SETFEATURES), libata assumes the error condition is 
transient and let the drive continue operating.

So, no, libata won't drop a drive unless it fails to respond to recovery 
sequence.  libata just doesn't have enough information about how devices 
are used to determine whether a device is failing too often to be 
useful.  e.g. there is a very big difference between a harddrive serving 
rootfs by itself and a drive which is in md array w/ several spares.

> I plan to look at the state of the drive with an analyzer tomorrow to 
> make sure that the drive is not holding the bus or something & try your 
> latest "new init" git tree code.

New init stuff won't change anything regarding this.

> What it looks like is a soft hang - maybe the box is stuck in 
> ata_port_wait_eh() which never seems to timeout on a bus that does not 
> recover?

It seems like we need a separate mechanism here to implement policy for 
longer-term handling for frequently-failing devices.  Probably providing 
some monitoring sysfs nodes should do it - some error history w/ 
recovery time record and stuff such that user management process can 
decide to pull the plug if seems appropriate.

Thanks.

-- 
tejun
