From: Frans Pop <elendil@planet.nl>
Subject: ata1.00: spurious completions during NCQ
Date: Mon, 1 Oct 2007 14:43:04 +0200
Message-ID: <200710011443.05629.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hpsmtp-eml12.kpnxchange.com ([213.75.38.112]:44450 "EHLO
	hpsmtp-eml12.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751400AbXJAM7X (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 1 Oct 2007 08:59:23 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Hi,

On 15 August 2007 Tejun Heo wrote:
> You don't need to worry too much as long as errors are properly,
> recovered. All commands are retried and you won't lose any data.
> Please report if the spurious NCQ problem happens again.  Thanks.  

I've just received a logcheck mail with another one. I have not seen any in
the time between my initial mail [1] and now, so this is the second
occurrence in 1.5 months. The message is slightly different this time.

I'm currently running 2.6.23-rc8 + CFS patchset.

kernel: ata1.00: spurious completions during NCQ issue=0x0 SAct=0x8 FIS=005040a1:00000004
kernel: ata1.00: cmd 60/58:18:b3:56:bd/00:00:01:00:00/40 tag 3 cdb 0x0 data 45056 in
kernel:          res 50/00:58:b3:56:bd/00:00:01:00:00/40 Emask 0x2 (HSM violation)
kernel: ata1: soft resetting port
kernel: ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
kernel: ata1.00: configured for UDMA/133
kernel: ata1: EH complete
kernel: sd 0:0:0:0: [sda] 321672960 512-byte hardware sectors (164697 MB)
kernel: sd 0:0:0:0: [sda] Write Protect is off
kernel: sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
kernel: sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA

Cheers,
Frans Pop

[1] http://marc.info/?l=linux-ide&m=118703097726277&w=2
