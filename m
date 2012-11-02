From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 00/14] ahci/libata: clean up platform device removal
Date: Fri, 2 Nov 2012 12:04:39 -0700
Message-ID: <20121102190439.GC27843@mtj.dyndns.org>
References: <1351842388-27210-1-git-send-email-computersforpeace@gmail.com>
 <20121102170142.GA27320@mtj.dyndns.org>
 <CAN8TOE_dP4J02hm7m-e8PQpnpNaCiaeU6vq=0oQdzvn4jsEEgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:57344 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932260Ab2KBTEo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Nov 2012 15:04:44 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so2641131pbb.19
        for <linux-ide@vger.kernel.org>; Fri, 02 Nov 2012 12:04:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAN8TOE_dP4J02hm7m-e8PQpnpNaCiaeU6vq=0oQdzvn4jsEEgg@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, Kevin Cernekee <cernekee@gmail.com>

Hello,

On Fri, Nov 02, 2012 at 12:03:02PM -0700, Brian Norris wrote:
> > That's because detaching the driver is handled basically as controller
> > hot unplug.  By the time SCSI is noticing the SCSI devices are going
> > away, the corresponding ATA devices are already away.  It's kinda
> > natural to implement that way.  Is this an actual problem?
> 
> Yes. The HDD doesn't spin down. I'm removing the device because I want
> some power savings, so I would expect to spin down the disk.

Detach the hdds first then.  You're essentially yanking out the
controller.  The high level driver naturally loses control of the
device before it can do anything about it.

Thanks.

-- 
tejun
