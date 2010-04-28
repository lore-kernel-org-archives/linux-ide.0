From: Maxime Bizon <mbizon@freebox.fr>
Subject: Re: [RFC] add port information for ATA devices in sysfs
Date: Wed, 28 Apr 2010 16:57:20 +0200
Message-ID: <1272466640.12455.253.camel@sakura.staff.proxad.net>
References: <201004261829.04687.nschichan@freebox.fr>
	 <20100427034210.GB4759@kroah.com> <201004271518.13611.nschichan@freebox.fr>
	 <20100428055013.GA14913@kroah.com>
Reply-To: mbizon@freebox.fr
Mime-Version: 1.0
Content-Type: text/plain; charset="ANSI_X3.4-1968"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtpfb1-g21.free.fr ([212.27.42.9]:58321 "EHLO
	smtpfb1-g21.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753820Ab0D1O61 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 28 Apr 2010 10:58:27 -0400
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
	by smtpfb1-g21.free.fr (Postfix) with ESMTP id 8CEE977CF71
	for <linux-ide@vger.kernel.org>; Wed, 28 Apr 2010 16:58:22 +0200 (CEST)
In-Reply-To: <20100428055013.GA14913@kroah.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Nicolas Schichan <nschichan@freebox.fr>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org


On Tue, 2010-04-27 at 22:50 -0700, Greg KH wrote:

Hi Greg,

> As for the whole idea of the extra device (which it doesn't look like
> you ever initialize anywhere), it's not good to have one sitting in the
> middle of the device chain that isn't owned by a bus somehow.  That just
> looks wierd and can cause problems with udev rules.
> 
> why is this really needed at all?  Can't you just export the port number
> in the device as an attribute instead?

You're right, please disregard this. We got fooled by the incrementing
scsi host id in the device path.

The misleading part (for me) is that even if a device sysfs devpath
*seems* to represent its topology, some parts of the path are not
"persistent" (across simple rmmod/modprobe)

I just read udev path_id source code and saw the trick for the scsi host
number (which would have been broken with this patch). Since the ata
code always creates scsi hosts in ata port order, we can assume that
lowest scsi host number is the first ata port, so the patch is not
needed.

-- 
Maxime


