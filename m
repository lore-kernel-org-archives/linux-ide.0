From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 32852] New: Random timeouts and unsuccessful resets on JMicron
 JMB393 PMP
Date: Thu, 7 Apr 2011 00:13:18 GMT
Message-ID: <bug-32852-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter1.kernel.org ([140.211.167.39]:55761 "EHLO
	demeter1.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753914Ab1DGANU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 6 Apr 2011 20:13:20 -0400
Received: from demeter1.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter1.kernel.org (8.14.4/8.14.3) with ESMTP id p370DI64031639
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Thu, 7 Apr 2011 00:13:18 GMT
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=32852

           Summary: Random timeouts and unsuccessful resets on JMicron
                    JMB393 PMP
           Product: IO/Storage
           Version: 2.5
    Kernel Version: 2.6.36.1
          Platform: All
        OS/Version: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: IDE
        AssignedTo: io_ide@kernel-bugs.osdl.org
        ReportedBy: nemesis@icequake.net
        Regression: No


Created an attachment (id=53752)
 --> (https://bugzilla.kernel.org/attachment.cgi?id=53752)
lspci

About once a month I am greeted with a log entry like the below which
completely kicks the JMB393 RAID offline.  (This time it is followed by btrfs
blowing up, but that's a different problem.)  I am going to try kernel 2.6.38.2
now.


[2873090.912042] ata8.00: failed to read SCR 1 (Emask=0x40)
[2873090.912057] ata8.01: failed to read SCR 1 (Emask=0x40)
[2873090.912065] ata8.02: failed to read SCR 1 (Emask=0x40)
[2873090.912074] ata8.03: failed to read SCR 1 (Emask=0x40)
[2873090.912081] ata8.04: failed to read SCR 1 (Emask=0x40)
[2873090.912089] ata8.05: failed to read SCR 1 (Emask=0x40)
[2873090.912097] ata8.06: failed to read SCR 1 (Emask=0x40)
[2873090.912105] ata8.07: failed to read SCR 1 (Emask=0x40)
[2873090.912112] ata8.08: failed to read SCR 1 (Emask=0x40)
[2873090.912120] ata8.09: failed to read SCR 1 (Emask=0x40)
[2873090.912128] ata8.10: failed to read SCR 1 (Emask=0x40)
[2873090.912136] ata8.11: failed to read SCR 1 (Emask=0x40)
[2873090.912143] ata8.12: failed to read SCR 1 (Emask=0x40)
[2873090.912151] ata8.13: failed to read SCR 1 (Emask=0x40)
[2873090.912159] ata8.14: failed to read SCR 1 (Emask=0x40)
[2873090.912170] ata8.15: exception Emask 0x4 SAct 0x0 SErr 0x0 action 0x6
frozen
[2873090.912184] ata8.00: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6
frozen
[2873090.912197] ata8.00: failed command: READ DMA EXT
[2873090.912209] ata8.00: cmd 25/00:08:10:74:05/00:00:00:01:00/e0 tag 0 dma
4096 in
[2873090.912210]          res 40/00:01:00:4f:c2/00:00:00:00:00/00 Emask 0x4
(timeout)
[2873090.912230] ata8.00: status: { DRDY }
[2873090.912240] ata8.01: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6
frozen
[2873090.912252] ata8.02: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6
frozen
[2873090.912265] ata8.03: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6
frozen
[2873090.912279] ata8.04: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6
frozen
[2873090.912292] ata8.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6
frozen
[2873090.912305] ata8.06: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6
frozen
[2873090.912319] ata8.07: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6
frozen
[2873090.912331] ata8.08: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6
frozen
[2873090.912345] ata8.09: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6
frozen

[2873090.912358] ata8.10: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6
frozen
[2873090.912372] ata8.11: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6
frozen
[2873090.912385] ata8.12: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6
frozen
[2873090.912398] ata8.13: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6
frozen
[2873090.912410] ata8.14: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6
frozen
[2873090.912425] ata8.15: hard resetting link
[2873096.444035] ata8.15: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[2873096.444414] ata8.00: hard resetting link
[2873101.976022] ata8.00: link is slow to respond, please be patient (ready=0)
[2873106.456037] ata8.00: softreset failed (device not ready)
[2873109.456031] ata8.15: qc timeout (cmd 0xe4)
[2873109.456057] ata8.00: failed to read SCR 0 (Emask=0x4)
[2873109.456066] ata8.00: reset failed, giving up
[2873109.456076] ata8.15: hard resetting link
[2873114.988037] ata8.15: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[2873114.988479] ata8.00: hard resetting link
[2873120.520022] ata8.00: link is slow to respond, please be patient (ready=0)
[2873125.000029] ata8.00: softreset failed (device not ready)
[2873128.000034] ata8.15: qc timeout (cmd 0xe4)
[2873128.000057] ata8.00: failed to read SCR 0 (Emask=0x4)
[2873128.000065] ata8.00: reset failed, giving up
[2873128.000076] ata8.15: hard resetting link
[2873138.012024] ata8.15: softreset failed (device not ready)
[2873138.012038] ata8.15: hard resetting link
[2873148.024023] ata8.15: softreset failed (device not ready)
[2873148.024037] ata8.15: hard resetting link
[2873158.596028] ata8.15: link is slow to respond, please be patient (ready=0)
[2873183.068021] ata8.15: softreset failed (device not ready)
[2873183.068037] ata8.15: limiting SATA link speed to 1.5 Gbps
[2873183.068046] ata8.15: hard resetting link
[2873188.256028] ata8.15: softreset failed (device not ready)
[2873188.256042] ata8.15: failed to reset PMP, giving up
[2873188.256050] ata8.15: Port Multiplier detaching
[2873188.256059] ata8.00: disabled
[2873188.256112] ata8.00: disabled
[2873188.256123] ata8: hard resetting link
[2873198.268028] ata8: softreset failed (device not ready)
[2873198.268041] ata8: hard resetting link
[2873208.280024] ata8: softreset failed (device not ready)
[2873208.280037] ata8: hard resetting link
[2873218.852022] ata8: link is slow to respond, please be patient (ready=0)
[2873243.324023] ata8: softreset failed (device not ready)
[2873243.324038] ata8: hard resetting link
[2873248.512026] ata8: softreset failed (device not ready)
[2873248.512039] ata8: reset failed, giving up
[2873248.512050] ata8.00: device reported invalid CHS sector 0
[2873248.512069] ata8: exception Emask 0x40 SAct 0x0 SErr 0x800 action 0x6
frozen t4
[2873248.512081] ata8: SError: { HostInt }
[2873248.512092] ata8: hard resetting link
[2873258.524023] ata8: softreset failed (device not ready)
[2873258.524037] ata8: hard resetting link
[2873268.536022] ata8: softreset failed (device not ready)

[2873268.536036] ata8: hard resetting link
[2873279.108030] ata8: link is slow to respond, please be patient (ready=0)
[2873303.580027] ata8: softreset failed (device not ready)
[2873303.580043] ata8: hard resetting link
[2873308.768031] ata8: softreset failed (device not ready)
[2873308.768044] ata8: reset failed, giving up
[2873308.768067] sd 7:0:0:0: [sdc]  Result: hostbyte=DID_OK
driverbyte=DRIVER_SENSE
[2873308.768080] sd 7:0:0:0: [sdc]  Sense Key : Aborted Command [current]
[descriptor]
[2873308.768097] Descriptor sense data with sense descriptors (in hex):
[2873308.768105]         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00
[2873308.768137]         00 00 00 00
[2873308.768150] sd 7:0:0:0: [sdc]  Add. Sense: No additional sense information
[2873308.768161] sd 7:0:0:0: [sdc] CDB: Read(16): 88 00 00 00 00 01 00 05 74 10
00 00 00 08 00 00
[2873308.768203] end_request: I/O error, dev sdc, sector 4295324688
[2873308.768242] ata8: EH complete
[2873308.768260] ata8.00: detaching (SCSI 7:0:0:0)
[2873308.780173] sd 7:0:0:0: [sdc] Stopping disk
[2873308.780946] sd 7:0:0:0: [sdc] START_STOP FAILED
[2873308.780957] sd 7:0:0:0: [sdc]  Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK
[2873308.796298] lost page write due to I/O error on dm-11
[2873308.796316] btrfs: 1 errors while writing supers
[2873308.796379] ------------[ cut here ]------------
[2873308.796386] kernel BUG at fs/btrfs/disk-io.c:2292!
[2873308.796394] invalid opcode: 0000 [#1] SMP
[2873308.796403] last sysfs file: /sys/devices/virtual/block/dm-4/range
[2873308.796410] CPU 0
[....]

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
