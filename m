From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: [PATCH #upstream-fixes] sata_nv: ck804 has borked hardreset too
Date: Sun, 01 Feb 2009 14:49:39 -0600
Message-ID: <49860AE3.2040108@gmail.com>
References: <4985014F.7070607@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from qb-out-0506.google.com ([72.14.204.230]:64659 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754526AbZBAUtl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 1 Feb 2009 15:49:41 -0500
Received: by qb-out-0506.google.com with SMTP id f11so461646qba.17
        for <linux-ide@vger.kernel.org>; Sun, 01 Feb 2009 12:49:40 -0800 (PST)
In-Reply-To: <4985014F.7070607@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> While playing with nvraid, I found out that rmmoding and insmoding
> often trigger hardreset failure on the first port (the second one was
> always okay).  Seriously, how diverse can you get with hardreset
> behaviors?  Anyways, make ck804 use noclassify variant too.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
> Robert, ISTR that a user was reporting probing problem on ck804, I
> think the user could have been seeing this.  The behavior on my
> motherboard is very curious.  The problem is always with the first
> port.  If booted from cdrom, it always fails.  If booted from
> harddrive, the initial probing works fine but from the second time on,
> it fails.  Argh...

Yeah, it's amazing how their controllers can be messed up with hardreset 
in so many varying and creative ways. One only hopes their newer AHCI 
based controllers have fewer bugs..

I saw another problem recently on CK804, where an error occurs on a DVD 
drive (due to a scratched disc or something).  This was in Windows, 
using the default Microsoft IDE driver. It would either blue-screen the 
machine with a machine check exception or just cause a hard lockup. 
People have reported this in Linux as well, it seems like the controller 
fails to respond to register accesses and triggers a northbridge 
transaction timeout MCE. Obviously not a driver problem, then.. Ended up 
switching the optical drives to the Silicon Image controller on this 
board because the CK804 controller just wasn't reliable with them.
