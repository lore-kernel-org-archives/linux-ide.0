From: Paul Ionescu <i_p_a_u_l@yahoo.com>
Subject: Re: Linux SATA RAID FAQ
Date: Thu, 12 Aug 2004 14:17:13 +0300
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <pan.2004.08.12.11.17.12.443916@yahoo.com>
References: <411B0F45.8070500@pobox.com> <20040812.7181062@knigge.local.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.224.249]:48362 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S268524AbUHLMU2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 12 Aug 2004 08:20:28 -0400
Received: from root by main.gmane.org with local (Exim 3.35 #1 (Debian))
	id 1BvEZH-0001wv-00
	for <linux-ide@vger.kernel.org>; Thu, 12 Aug 2004 14:20:27 +0200
Received: from home-33027.b.astral.ro ([81.89.4.83])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Thu, 12 Aug 2004 14:20:27 +0200
Received: from i_p_a_u_l by home-33027.b.astral.ro with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Thu, 12 Aug 2004 14:20:27 +0200
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

On Thu, 12 Aug 2004 07:18:10 +0000, Michael Knigge wrote:
> I don't care about RAID, but could you tell which S-ATA 
> Controller/Chipset is the best for Hot-Swap?

Hi Michael,

I think 3ware is the most stable right now, and has his own separate
driver. It is even seen as a SCSI controller by linux, but has SATA or
PATA disks.
Maybe there are some others, but I heard this is stable right now, and
hot-swapping is working on it.

