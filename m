From: Tejun Heo <htejun@gmail.com>
Subject: Re: ata1.00: spurious completions during NCQ
Date: Thu, 04 Oct 2007 11:17:26 +0900
Message-ID: <47044D36.4090708@gmail.com>
References: <200710011443.05629.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.183]:16020 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753243AbXJDCRe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 3 Oct 2007 22:17:34 -0400
Received: by wa-out-1112.google.com with SMTP id v27so26454wah
        for <linux-ide@vger.kernel.org>; Wed, 03 Oct 2007 19:17:34 -0700 (PDT)
In-Reply-To: <200710011443.05629.elendil@planet.nl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Frans Pop <elendil@planet.nl>
Cc: linux-ide@vger.kernel.org

Frans Pop wrote:
> Hi,
> 
> On 15 August 2007 Tejun Heo wrote:
>> You don't need to worry too much as long as errors are properly,
>> recovered. All commands are retried and you won't lose any data.
>> Please report if the spurious NCQ problem happens again.  Thanks.  
> 
> I've just received a logcheck mail with another one. I have not seen any in
> the time between my initial mail [1] and now, so this is the second
> occurrence in 1.5 months. The message is slightly different this time.
> 
> I'm currently running 2.6.23-rc8 + CFS patchset.
> 
> kernel: ata1.00: spurious completions during NCQ issue=0x0 SAct=0x8 FIS=005040a1:00000004
> kernel: ata1.00: cmd 60/58:18:b3:56:bd/00:00:01:00:00/40 tag 3 cdb 0x0 data 45056 in
> kernel:          res 50/00:58:b3:56:bd/00:00:01:00:00/40 Emask 0x2 (HSM violation)
> kernel: ata1: soft resetting port
> kernel: ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> kernel: ata1.00: configured for UDMA/133
> kernel: ata1: EH complete
> kernel: sd 0:0:0:0: [sda] 321672960 512-byte hardware sectors (164697 MB)
> kernel: sd 0:0:0:0: [sda] Write Protect is off
> kernel: sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
> kernel: sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA

Please post the result of "hdparm -I /dev/sda".  Thanks.

-- 
tejun
