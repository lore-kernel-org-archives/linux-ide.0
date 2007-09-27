From: Tejun Heo <htejun@gmail.com>
Subject: Re: T61 SATA error in log
Date: Thu, 27 Sep 2007 13:35:06 -0700
Message-ID: <46FC13FA.3090400@gmail.com>
References: <1190877668.30275.3.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.191]:51053 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759492AbXI0XZW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 27 Sep 2007 19:25:22 -0400
Received: by rv-out-0910.google.com with SMTP id k20so2444981rvb
        for <linux-ide@vger.kernel.org>; Thu, 27 Sep 2007 16:25:21 -0700 (PDT)
In-Reply-To: <1190877668.30275.3.camel@pasglop>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: benh@kernel.crashing.org
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>

Benjamin Herrenschmidt wrote:
> Saw that popping up in my log today on a brand new T61 thinkpad:
> 
> [  427.712000] ata1.00: exception Emask 0x2 SAct 0x18 SErr 0x0 action 0x2 frozen
> [  427.712000] ata1.00: (spurious completions during NCQ issue=0x0 SAct=0x18 FIS=004040a1:00000024)
> [  427.712000] ata1.00: cmd 61/08:18:f4:74:54/00:00:04:00:00/40 tag 3 cdb 0x0 data 4096 out
> [  427.712000]          res 40/00:28:64:e4:51/00:00:04:00:00/40 Emask 0x2 (HSM violation)
> [  427.712000] ata1.00: cmd 61/08:20:84:10:81/00:00:04:00:00/40 tag 4 cdb 0x0 data 4096 out
> [  427.712000]          res 40/00:28:64:e4:51/00:00:04:00:00/40 Emask 0x2 (HSM violation)
> [  428.024000] ata1: soft resetting port
> [  428.196000] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> [  428.204000] ata1.00: configured for UDMA/100
> [  428.204000] ata1: EH complete
> [  428.204000] sd 0:0:0:0: [sda] 234441648 512-byte hardware sectors (120034 MB)
> [  428.204000] sd 0:0:0:0: [sda] Write Protect is off
> [  428.204000] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
> [  428.204000] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> 
> Kernel recovered just fine and things seem smooth so far. Is that something I need
> to worry about ?

Please post the result of 'hdparm -I /dev/sda' and you don't need to
worry about it too much.

-- 
tejun

