From: Peter Favrholdt <linux-ide@how.dk>
Subject: Re: FYI: BUG in SATA Promise 300 TX4 (2.6.24 - 2.6.27-3) w/Linux
Date: Thu, 20 Nov 2008 11:22:37 +0100
Message-ID: <49253A6D.1040202@how.dk>
References: <491C9A4F.1020801@tlinx.org>	<491FB7E2.2030105@kernel.org> <18719.65298.689618.835202@harpo.it.uu.se> <492059B1.4030708@how.dk> <49205AD7.3080009@how.dk> <4920D093.2030508@kernel.org> <492159E0.1050804@how.dk> <4922165E.9070203@kernel.org> <49230361.2010001@how.dk> <492371F4.7020400@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pfepa.post.tele.dk ([195.41.46.235]:38597 "EHLO
	pfepa.post.tele.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753206AbYKTKYq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 20 Nov 2008 05:24:46 -0500
In-Reply-To: <492371F4.7020400@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>

Hi Tejun and list,

Tejun Heo wrote:
> COMRESETs are failing with EBUSY while ata_sff_check_ready() is
> returning ENODEV.  Hmmm... Does the attached patch change anything?

patching file drivers/ata/sata_promise.c
Hunk #1 succeeded at 707 (offset -2 lines).

Yes, it actually helped. Tested it twice and both times the following 
happened:

1. started the dd's from all four drives

2. /dev/sda fails after a while as usual

3. two hardresets happen on sda - the second limits the link to 1.5Gbps

4. dd continues without hickups (and when completed normally I started 
yet another dd test which ran to completion without any errors).

So at first error the hardreset kicks in and saves the day (and 
downgrades to 1.5Gbps which prevents the problem from happening in my 
setup).

Thanks a lot!

Best regards,

Peter Favrholdt

Here is the dmesg:

[  648.683865] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x180000 
action 0x6
[  648.683872] ata1.00: port_status 0x20280000
[  648.683876] ata1: SError: { 10B8B Dispar }
[  648.683884] ata1.00: cmd c8/00:00:00:0e:e6/00:00:00:00:00/e1 tag 0 
dma 131072 in
[  648.683886]          res 51/84:00:00:0e:e6/00:00:00:00:00/e1 Emask 
0x12 (ATA bus error)
[  648.683889] ata1.00: status: { DRDY ERR }
[  648.683891] ata1.00: error: { ICRC ABRT }
[  648.683942] ata1: hard resetting link
[  649.190217] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  649.334082] ata1.00: configured for UDMA/133
[  649.334354] ata1: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x9 t4
[  649.334357] ata1: hotplug_status 0x80
[  649.492347] ata1.00: configured for UDMA/133
[  649.492363] ata1: EH complete
[  649.537356] sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors 
(500108 MB)
[  649.540275] sd 0:0:0:0: [sda] Write Protect is off
[  649.540284] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[  649.547891] sd 0:0:0:0: [sda] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[  649.555009] sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors 
(500108 MB)
[  649.557709] sd 0:0:0:0: [sda] Write Protect is off
[  649.557719] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[  649.991649] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x180000 
action 0x6
[  649.991657] ata1.00: port_status 0x20280000
[  649.991662] ata1: SError: { 10B8B Dispar }
[  649.991669] ata1.00: cmd c8/00:00:00:17:e6/00:00:00:00:00/e1 tag 0 
dma 131072 in
[  649.991671]          res 51/84:00:00:17:e6/00:00:00:00:00/e1 Emask 
0x12 (ATA bus error)
[  649.991674] ata1.00: status: { DRDY ERR }
[  649.991676] ata1.00: error: { ICRC ABRT }
[  649.991712] ata1: hard resetting link
[  650.500230] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  650.641824] ata1.00: configured for UDMA/133
[  650.642194] ata1: limiting SATA link speed to 1.5 Gbps
[  650.642200] ata1: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xf t4
[  650.642202] ata1: hotplug_status 0x80
[  650.642252] ata1: hard resetting link
[  651.550344] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  651.700416] ata1.00: configured for UDMA/133
[  651.700678] ata1: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x9 t3
[  651.700681] ata1: hotplug_status 0x80
[  651.882957] ata1.00: configured for UDMA/133
[  651.882973] ata1: EH complete
[  651.931329] sd 0:0:0:0: [sda] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[  651.939665] sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors 
(500108 MB)
[  651.943942] sd 0:0:0:0: [sda] Write Protect is off
[  651.943952] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[  651.952162] sd 0:0:0:0: [sda] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
