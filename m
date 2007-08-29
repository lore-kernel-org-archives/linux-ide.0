From: Dave Jones <davej@redhat.com>
Subject: HSM violation spew.
Date: Wed, 29 Aug 2007 14:49:25 -0400
Message-ID: <20070829184925.GF31948@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:49836 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753301AbXH2St3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 29 Aug 2007 14:49:29 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l7TInRdW017305
	for <linux-ide@vger.kernel.org>; Wed, 29 Aug 2007 14:49:27 -0400
Received: from gelk.kernelslacker.org (vpn-248-3.boston.redhat.com [10.13.248.3])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l7TInQbd013755
	for <linux-ide@vger.kernel.org>; Wed, 29 Aug 2007 14:49:26 -0400
Received: from gelk.kernelslacker.org (localhost.localdomain [127.0.0.1])
	by gelk.kernelslacker.org (8.14.1/8.13.8) with ESMTP id l7TInQNs028417
	for <linux-ide@vger.kernel.org>; Wed, 29 Aug 2007 14:49:26 -0400
Received: (from davej@localhost)
	by gelk.kernelslacker.org (8.14.1/8.14.1/Submit) id l7TInPI4028416
	for linux-ide@vger.kernel.org; Wed, 29 Aug 2007 14:49:25 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Just noticed this in dmesg..

ata3.00: exception Emask 0x2 SAct 0x1fffd SErr 0x0 action 0x2 frozen
ata3.00: spurious completions during NCQ issue=0x0 SAct=0x1fffd FIS=004040a1:00040000
ata3.00: cmd 61/08:00:d9:f7:09/00:00:24:00:00/40 tag 0 cdb 0x0 data 4096 out
         res 40/00:84:11:f8:09/00:00:24:00:00/40 Emask 0x2 (HSM violation)
ata3.00: cmd 61/10:10:b1:f4:09/00:00:24:00:00/40 tag 2 cdb 0x0 data 8192 out
         res 40/00:84:11:f8:09/00:00:24:00:00/40 Emask 0x2 (HSM violation)
ata3.00: cmd 61/10:18:c9:f4:09/00:00:24:00:00/40 tag 3 cdb 0x0 data 8192 out
         res 40/00:84:11:f8:09/00:00:24:00:00/40 Emask 0x2 (HSM violation)
ata3.00: cmd 61/08:20:e1:f4:09/00:00:24:00:00/40 tag 4 cdb 0x0 data 4096 out
         res 40/00:84:11:f8:09/00:00:24:00:00/40 Emask 0x2 (HSM violation)
ata3.00: cmd 61/d8:28:f1:f4:09/00:00:24:00:00/40 tag 5 cdb 0x0 data 110592 out
         res 40/00:84:11:f8:09/00:00:24:00:00/40 Emask 0x2 (HSM violation)
ata3.00: cmd 61/38:30:d1:f5:09/00:00:24:00:00/40 tag 6 cdb 0x0 data 28672 out
         res 40/00:84:11:f8:09/00:00:24:00:00/40 Emask 0x2 (HSM violation)
ata3.00: cmd 61/f8:38:11:f6:09/00:00:24:00:00/40 tag 7 cdb 0x0 data 126976 out
         res 40/00:84:11:f8:09/00:00:24:00:00/40 Emask 0x2 (HSM violation)
ata3.00: cmd 61/70:40:11:f7:09/00:00:24:00:00/40 tag 8 cdb 0x0 data 57344 out
         res 40/00:84:11:f8:09/00:00:24:00:00/40 Emask 0x2 (HSM violation)
ata3.00: cmd 61/08:48:89:f7:09/00:00:24:00:00/40 tag 9 cdb 0x0 data 4096 out
         res 40/00:84:11:f8:09/00:00:24:00:00/40 Emask 0x2 (HSM violation)
ata3.00: cmd 61/08:50:99:f7:09/00:00:24:00:00/40 tag 10 cdb 0x0 data 4096 out
         res 40/00:84:11:f8:09/00:00:24:00:00/40 Emask 0x2 (HSM violation)
ata3.00: cmd 61/08:58:a9:f7:09/00:00:24:00:00/40 tag 11 cdb 0x0 data 4096 out
         res 40/00:84:11:f8:09/00:00:24:00:00/40 Emask 0x2 (HSM violation)
ata3.00: cmd 61/08:60:b9:f7:09/00:00:24:00:00/40 tag 12 cdb 0x0 data 4096 out
         res 40/00:84:11:f8:09/00:00:24:00:00/40 Emask 0x2 (HSM violation)
ata3.00: cmd 61/08:68:c9:f7:09/00:00:24:00:00/40 tag 13 cdb 0x0 data 4096 out
         res 40/00:84:11:f8:09/00:00:24:00:00/40 Emask 0x2 (HSM violation)
ata3.00: cmd 61/08:70:e9:f7:09/00:00:24:00:00/40 tag 14 cdb 0x0 data 4096 out
         res 40/00:84:11:f8:09/00:00:24:00:00/40 Emask 0x2 (HSM violation)
ata3.00: cmd 61/10:78:f9:f7:09/00:00:24:00:00/40 tag 15 cdb 0x0 data 8192 out
         res 40/00:84:11:f8:09/00:00:24:00:00/40 Emask 0x2 (HSM violation)
ata3.00: cmd 61/90:80:11:f8:09/00:00:24:00:00/40 tag 16 cdb 0x0 data 73728 out
         res 40/00:84:11:f8:09/00:00:24:00:00/40 Emask 0x2 (HSM violation)
ata3: soft resetting port
ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata3.00: configured for UDMA/133
ata3: EH complete
sd 2:0:0:0: [sdc] 625142448 512-byte hardware sectors (320073 MB)
sd 2:0:0:0: [sdc] Write Protect is off
sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 2:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
ata3.00: exception Emask 0x2 SAct 0xff3 SErr 0x0 action 0x2 frozen
ata3.00: spurious completions during NCQ issue=0x0 SAct=0xff3 FIS=004040a1:00000008
ata3.00: cmd 61/98:00:e9:30:60/00:00:21:00:00/40 tag 0 cdb 0x0 data 77824 out
         res 40/00:0c:81:ee:6c/00:00:21:00:00/40 Emask 0x2 (HSM violation)
ata3.00: cmd 61/80:08:81:ee:6c/00:00:21:00:00/40 tag 1 cdb 0x0 data 65536 out
         res 40/00:0c:81:ee:6c/00:00:21:00:00/40 Emask 0x2 (HSM violation)
ata3.00: cmd 61/80:20:81:31:60/00:00:21:00:00/40 tag 4 cdb 0x0 data 65536 out
         res 40/00:0c:81:ee:6c/00:00:21:00:00/40 Emask 0x2 (HSM violation)
ata3.00: cmd 61/08:28:e1:30:60/00:00:21:00:00/40 tag 5 cdb 0x0 data 4096 out
         res 40/00:0c:81:ee:6c/00:00:21:00:00/40 Emask 0x2 (HSM violation)
ata3.00: cmd 61/80:30:81:d9:0e/00:00:24:00:00/40 tag 6 cdb 0x0 data 65536 out
         res 40/00:0c:81:ee:6c/00:00:21:00:00/40 Emask 0x2 (HSM violation)
ata3.00: cmd 61/00:38:01:6f:68/01:00:21:00:00/40 tag 7 cdb 0x0 data 131072 out
         res 40/00:0c:81:ee:6c/00:00:21:00:00/40 Emask 0x2 (HSM violation)
ata3.00: cmd 61/98:40:01:70:68/00:00:21:00:00/40 tag 8 cdb 0x0 data 77824 out
         res 40/00:0c:81:ee:6c/00:00:21:00:00/40 Emask 0x2 (HSM violation)
ata3.00: cmd 61/28:48:a1:70:68/00:00:21:00:00/40 tag 9 cdb 0x0 data 20480 out
         res 40/00:0c:81:ee:6c/00:00:21:00:00/40 Emask 0x2 (HSM violation)
ata3.00: cmd 61/10:50:d1:70:68/00:00:21:00:00/40 tag 10 cdb 0x0 data 8192 out
         res 40/00:0c:81:ee:6c/00:00:21:00:00/40 Emask 0x2 (HSM violation)
ata3.00: cmd 61/18:58:e9:70:68/00:00:21:00:00/40 tag 11 cdb 0x0 data 12288 out
         res 40/00:0c:81:ee:6c/00:00:21:00:00/40 Emask 0x2 (HSM violation)
ata3: soft resetting port
ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata3.00: configured for UDMA/133
ata3: EH complete
sd 2:0:0:0: [sdc] 625142448 512-byte hardware sectors (320073 MB)
sd 2:0:0:0: [sdc] Write Protect is off
sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 2:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
ata3.00: exception Emask 0x2 SAct 0x66 SErr 0x0 action 0x2 frozen
ata3.00: spurious completions during NCQ issue=0x0 SAct=0x66 FIS=004040a1:00000001
ata3.00: cmd 61/50:08:29:29:ea/00:00:23:00:00/40 tag 1 cdb 0x0 data 40960 out
         res 40/00:14:79:29:ea/00:00:23:00:00/40 Emask 0x2 (HSM violation)
ata3.00: cmd 61/08:10:79:29:ea/00:00:23:00:00/40 tag 2 cdb 0x0 data 4096 out
         res 40/00:14:79:29:ea/00:00:23:00:00/40 Emask 0x2 (HSM violation)
ata3.00: cmd 61/18:28:01:29:ea/00:00:23:00:00/40 tag 5 cdb 0x0 data 12288 out
         res 40/00:14:79:29:ea/00:00:23:00:00/40 Emask 0x2 (HSM violation)
ata3.00: cmd 61/08:30:21:29:ea/00:00:23:00:00/40 tag 6 cdb 0x0 data 4096 out
         res 40/00:14:79:29:ea/00:00:23:00:00/40 Emask 0x2 (HSM violation)
ata3: soft resetting port
ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata3.00: configured for UDMA/133
ata3: EH complete
sd 2:0:0:0: [sdc] 625142448 512-byte hardware sectors (320073 MB)
sd 2:0:0:0: [sdc] Write Protect is off
sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 2:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA



sdc is this..

scsi 2:0:0:0: Direct-Access     ATA      WDC WD3200AAJS-0 12.0 PQ: 0 ANSI: 5
sd 2:0:0:0: [sdc] 625142448 512-byte hardware sectors (320073 MB)
sd 2:0:0:0: [sdc] Write Protect is off
sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 2:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 2:0:0:0: [sdc] 625142448 512-byte hardware sectors (320073 MB)
sd 2:0:0:0: [sdc] Write Protect is off
sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 2:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdc: sdc1 sdc2

controller is ...
00:1f.2 SATA controller: Intel Corporation 82801GR/GH (ICH7 Family) SATA AHCI Controller (rev 01)

kernel is 2.6.23rc3
Does this disk need adding to a 'dont do NCQ' blacklist perhaps?

	Dave

-- 
http://www.codemonkey.org.uk
