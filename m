From: Mark Lord <kernel@teksavvy.com>
Subject: ahci: hotplug failure on 2.6.37
Date: Wed, 02 Feb 2011 22:40:20 -0500
Message-ID: <4D4A23A4.30508@teksavvy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.181]:46045 "EHLO
	ironport2-out.pppoe.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752184Ab1BCDkX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 Feb 2011 22:40:23 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: IDE/ATA development list <linux-ide@vger.kernel.org>

Done this a zillion times before without issues,
but today ahci refused to enumerate a hotplugged drive:

[13928.970823] ata9: exception Emask 0x10 SAct 0x0 SErr 0x4000000 action 0xe frozen
[13928.979011] ata9: irq_stat 0x00000040, connection status changed
[13928.985803] ata9: SError: { DevExch }
[13928.991019] ata9: hard resetting link
[13929.998011] ata9: failed to resume link (SControl 59)
[13935.553012] ata9: failed to reset engine (errno=-5)
[13939.493012] ata9: softreset failed (1st FIS failed)
[13939.499422] ata9: hard resetting link
[13941.006012] ata9: failed to resume link (SControl 59)
[13941.512012] ata9: failed to reset engine (errno=-5)
[13950.000013] ata9: softreset failed (1st FIS failed)
[13950.005105] ata9: hard resetting link
[13951.514010] ata9: failed to resume link (SControl 59)
[13952.019013] ata9: failed to reset engine (errno=-5)
[13985.506012] ata9: softreset failed (1st FIS failed)
[13985.510892] ata9: limiting SATA link speed to 1.5 Gbps
[13985.510897] ata9: hard resetting link
[13987.017010] ata9: failed to resume link (SControl 59)
[13991.042012] ata9: failed to reset engine (errno=-5)
[13991.195049] ata9: SATA link up 1.5 Gbps (SStatus 113 SControl 59)
[13991.195076] ata9.00: link online but device misclassifed
[13991.195090] ata9: link online but 1 devices misclassified, device detection
might fail
[13991.707016] ata9: exception Emask 0x10 SAct 0x0 SErr 0x5850000 action 0xe
frozen t4
[13991.714682] ata9: irq_stat 0x00400040, connection status changed
[13991.720687] ata9: SError: { PHYRdyChg CommWake LinkSeq TrStaTrns DevExch }
[13991.727682] ata9: hard resetting link
[13993.235011] ata9: failed to resume link (SControl 41)
[13993.240085] ata9: SATA link down (SStatus 0 SControl 41)
[13993.752016] ata9: exception Emask 0x10 SAct 0x0 SErr 0x5850000 action 0xe
frozen t3
[13993.759881] ata9: irq_stat 0x00400040, connection status changed
[13993.765924] ata9: SError: { PHYRdyChg CommWake LinkSeq TrStaTrns DevExch }
[13993.774233] ata9: hard resetting link
[13995.282011] ata9: failed to resume link (SControl 59)
[14000.836013] ata9: failed to reset engine (errno=-5)
[14004.274013] ata9: softreset failed (1st FIS failed)
[14004.279101] ata9: hard resetting link
[14005.786012] ata9: failed to resume link (SControl 59)
[14011.340012] ata9: failed to reset engine (errno=-5)
[14014.780012] ata9: softreset failed (1st FIS failed)
[14014.784894] ata9: hard resetting link
[14016.291010] ata9: failed to resume link (SControl 59)
[14016.797013] ata9: failed to reset engine (errno=-5)
[14050.284014] ata9: softreset failed (1st FIS failed)
[14050.288949] ata9: limiting SATA link speed to 1.5 Gbps
[14050.288953] ata9: hard resetting link
[14051.797010] ata9: failed to resume link (SControl 59)
[14055.822012] ata9: failed to reset engine (errno=-5)
...

I had to plug it into a different ahci port to get it recognized
(it was either that, or reboot).  Worked fine on the other port,
and worked fine on the failed port after a reboot.

Some state isn't getting cleared somewhere, but dunno what.
Probably not unique to 2.6.37.

Cheers
