From: Ryan Castellucci <ryan.castellucci@gmail.com>
Subject: "device error via D2H FIS" w/ Samsung drive and Si3726
Date: Tue, 26 Jul 2011 20:59:39 -0700
Message-ID: <CAO+W5hp61FEEz1gks-=uYfNB4L=Fw6UWU1r4tOUALLZfXrVufg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yi0-f46.google.com ([209.85.218.46]:49110 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750702Ab1G0EAU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 27 Jul 2011 00:00:20 -0400
Received: by yia27 with SMTP id 27so773452yia.19
        for <linux-ide@vger.kernel.org>; Tue, 26 Jul 2011 21:00:19 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello,

I've got a eight bay RAID enclosure with two Si3726 based port
multipliers. I have some Seagate ST31500341AS drives which work fine,
but my Samsung HD204UI do not like this.  I've tried swapping the
cable.  I've tried both with a on-board JMB362 AHCI and a Si3132 and
get similar errors.  On the Si3132 (with latest non-raid firmware):

I have eight of these Samsung drives and they all do the same thing,
but work fine when direct attached.

Here's what spews into the kernel log:

Jul 26 20:07:01 server kernel: [    2.411334] ata2: SATA max UDMA/100
host m128@0xfe484000 port 0xfe482000 irq 16
Jul 26 20:07:01 server kernel: [    6.580764] ata2: SATA link down
(SStatus 0 SControl 0)
Jul 26 20:07:31 server kernel: [   58.546476] ata2: exception Emask
0x10 SAct 0x0 SErr 0x0 action 0xe frozen
Jul 26 20:07:31 server kernel: [   58.546480] ata2: irq_stat
0x00b40090, PHY RDY changed
Jul 26 20:07:31 server kernel: [   58.546487] ata2: hard resetting link
Jul 26 20:07:33 server kernel: [   60.759380] ata2: SATA link up 3.0
Gbps (SStatus 123 SControl 0)
Jul 26 20:07:33 server kernel: [   60.759883] ata2.15: Port Multiplier
1.1, 0x1095:0x3726 r23, 6 ports, feat 0x1/0x9
Jul 26 20:07:33 server kernel: [   60.762227] ata2.00: hard resetting link
Jul 26 20:07:33 server kernel: [   61.199137] ata2.00: link resume
succeeded after 1 retries
Jul 26 20:07:34 server kernel: [   61.319577] ata2.00: SATA link down
(SStatus 0 SControl 310)
Jul 26 20:07:34 server kernel: [   61.319624] ata2.01: hard resetting link
Jul 26 20:07:34 server kernel: [   61.669293] ata2.01: SATA link down
(SStatus 0 SControl 320)
Jul 26 20:07:34 server kernel: [   61.669340] ata2.02: hard resetting link
Jul 26 20:07:34 server kernel: [   62.019084] ata2.02: SATA link up
3.0 Gbps (SStatus 123 SControl 300)
Jul 26 20:07:34 server kernel: [   62.019109] ata2.03: hard resetting link
Jul 26 20:07:35 server kernel: [   62.368889] ata2.03: SATA link up
3.0 Gbps (SStatus 123 SControl 300)
Jul 26 20:07:35 server kernel: [   62.368914] ata2.04: hard resetting link
Jul 26 20:07:35 server kernel: [   62.718713] ata2.04: SATA link down
(SStatus 0 SControl 320)
Jul 26 20:07:35 server kernel: [   62.718761] ata2.05: hard resetting link
Jul 26 20:07:35 server kernel: [   63.068542] ata2.05: SATA link up
1.5 Gbps (SStatus 113 SControl 320)
Jul 26 20:07:35 server kernel: [   63.167966] ata2.02: failed to
IDENTIFY (I/O error, err_mask=0x11)
Jul 26 20:07:35 server kernel: [   63.167972] ata2.15: hard resetting link
Jul 26 20:07:35 server kernel: [   63.167974] ata2: controller in
dubious state, performing PORT_RST
Jul 26 20:07:38 server kernel: [   65.426684] ata2.15: SATA link up
3.0 Gbps (SStatus 123 SControl 0)
Jul 26 20:07:38 server kernel: [   65.427192] ata2.00: hard resetting link
Jul 26 20:07:38 server kernel: [   65.866433] ata2.00: link resume
succeeded after 1 retries
Jul 26 20:07:38 server kernel: [   65.986792] ata2.00: SATA link down
(SStatus 0 SControl 310)
Jul 26 20:07:38 server kernel: [   65.986840] ata2.01: hard resetting link
Jul 26 20:07:39 server kernel: [   66.336621] ata2.01: SATA link down
(SStatus 0 SControl 320)
Jul 26 20:07:39 server kernel: [   67.015737] ata2.02: hard resetting link
Jul 26 20:07:40 server kernel: [   67.365992] ata2.02: SATA link up
3.0 Gbps (SStatus 123 SControl 300)
Jul 26 20:07:40 server kernel: [   67.366017] ata2.03: hard resetting link
Jul 26 20:07:40 server kernel: [   67.715792] ata2.03: SATA link up
3.0 Gbps (SStatus 123 SControl 300)
Jul 26 20:07:40 server kernel: [   68.065127] ata2.05: hard resetting link
Jul 26 20:07:41 server kernel: [   68.415380] ata2.05: SATA link up
1.5 Gbps (SStatus 113 SControl 320)
Jul 26 20:07:41 server kernel: [   68.514873] ata2.02: failed to
IDENTIFY (I/O error, err_mask=0x11)
Jul 26 20:07:41 server kernel: [   68.514879] ata2.15: hard resetting link
Jul 26 20:07:41 server kernel: [   68.514881] ata2: controller in
dubious state, performing PORT_RST
Jul 26 20:07:43 server kernel: [   70.773576] ata2.15: SATA link up
3.0 Gbps (SStatus 123 SControl 0)
Jul 26 20:07:43 server kernel: [   70.774042] ata2.00: hard resetting link
Jul 26 20:07:43 server kernel: [   71.213337] ata2.00: link resume
succeeded after 1 retries
Jul 26 20:07:44 server kernel: [   71.333723] ata2.00: SATA link down
(SStatus 0 SControl 310)
Jul 26 20:07:44 server kernel: [   71.333771] ata2.01: hard resetting link
Jul 26 20:07:44 server kernel: [   71.683532] ata2.01: SATA link down
(SStatus 0 SControl 320)
Jul 26 20:07:45 server kernel: [   72.362634] ata2.02: hard resetting link
Jul 26 20:07:45 server kernel: [   72.712893] ata2.02: SATA link up
3.0 Gbps (SStatus 123 SControl 300)
Jul 26 20:07:45 server kernel: [   72.712918] ata2.03: hard resetting link
Jul 26 20:07:45 server kernel: [   73.062725] ata2.03: SATA link up
3.0 Gbps (SStatus 123 SControl 300)
Jul 26 20:07:45 server kernel: [   73.062751] ata2.04: hard resetting link
Jul 26 20:07:46 server kernel: [   73.412524] ata2.04: SATA link down
(SStatus 0 SControl 320)
Jul 26 20:07:46 server kernel: [   73.412571] ata2.05: hard resetting link
Jul 26 20:07:46 server kernel: [   73.762320] ata2.05: SATA link up
1.5 Gbps (SStatus 113 SControl 320)
Jul 26 20:07:46 server kernel: [   73.791078] ata2.02: ATA-8:
ST31500341AS, CC1H, max UDMA/133
Jul 26 20:07:46 server kernel: [   73.791083] ata2.02: 2930277168
sectors, multi 0: LBA48 NCQ (depth 31/32)
Jul 26 20:07:46 server kernel: [   73.833013] ata2.02: configured for UDMA/100
Jul 26 20:07:46 server kernel: [   73.863338] ata2.03: ATA-8:
ST31500341AS, CC1H, max UDMA/133
Jul 26 20:07:46 server kernel: [   73.863342] ata2.03: 2930277168
sectors, multi 0: LBA48 NCQ (depth 31/32)
Jul 26 20:07:46 server kernel: [   73.905250] ata2.03: configured for UDMA/100
Jul 26 20:07:46 server kernel: [   73.905344] ata2: EH complete
Jul 26 20:07:57 server kernel: [   84.418558] ata2.01: exception Emask
0x10 SAct 0x0 SErr 0x4050000 action 0xf
Jul 26 20:07:57 server kernel: [   84.418560] ata2.01: SError: {
PHYRdyChg CommWake DevExch }
Jul 26 20:07:57 server kernel: [   84.418683] ata2.01: hard resetting link
Jul 26 20:07:57 server kernel: [   85.165675] ata2.01: SATA link up
3.0 Gbps (SStatus 123 SControl 320)
Jul 26 20:07:57 server kernel: [   85.265162] ata2.01: failed to
IDENTIFY (I/O error, err_mask=0x11)
Jul 26 20:07:57 server kernel: [   85.265168] ata2.15: hard resetting link
Jul 26 20:07:57 server kernel: [   85.265171] ata2: controller in
dubious state, performing PORT_RST
Jul 26 20:08:00 server kernel: [   87.523872] ata2.15: SATA link up
3.0 Gbps (SStatus 123 SControl 0)
Jul 26 20:08:00 server kernel: [   87.524338] ata2.00: hard resetting link
Jul 26 20:08:00 server kernel: [   87.963633] ata2.00: link resume
succeeded after 1 retries
Jul 26 20:08:00 server kernel: [   88.084006] ata2.00: SATA link down
(SStatus 0 SControl 310)
Jul 26 20:08:02 server kernel: [   90.162324] ata2.01: hard resetting link
Jul 26 20:08:03 server kernel: [   90.512573] ata2.01: SATA link up
3.0 Gbps (SStatus 123 SControl 300)
Jul 26 20:08:03 server kernel: [   90.512599] ata2.02: hard resetting link
Jul 26 20:08:03 server kernel: [   90.862374] ata2.02: SATA link up
3.0 Gbps (SStatus 123 SControl 300)
Jul 26 20:08:03 server kernel: [   90.862399] ata2.03: hard resetting link
Jul 26 20:08:03 server kernel: [   91.212172] ata2.03: SATA link up
3.0 Gbps (SStatus 123 SControl 300)
Jul 26 20:08:03 server kernel: [   91.212197] ata2.04: hard resetting link
Jul 26 20:08:04 server kernel: [   91.562007] ata2.04: SATA link down
(SStatus 0 SControl 320)
Jul 26 20:08:04 server kernel: [   91.562054] ata2.05: hard resetting link
Jul 26 20:08:04 server kernel: [   91.911802] ata2.05: SATA link up
1.5 Gbps (SStatus 113 SControl 320)
Jul 26 20:08:04 server kernel: [   92.011253] ata2.01: failed to
IDENTIFY (I/O error, err_mask=0x11)
Jul 26 20:08:04 server kernel: [   92.011259] ata2.15: hard resetting link
Jul 26 20:08:04 server kernel: [   92.011262] ata2: controller in
dubious state, performing PORT_RST
Jul 26 20:08:06 server kernel: [   94.269974] ata2.15: SATA link up
3.0 Gbps (SStatus 123 SControl 0)
Jul 26 20:08:06 server kernel: [   94.270357] ata2.00: hard resetting link
Jul 26 20:08:07 server kernel: [   94.709737] ata2.00: link resume
succeeded after 1 retries
Jul 26 20:08:07 server kernel: [   94.830092] ata2.00: SATA link down
(SStatus 0 SControl 310)
Jul 26 20:08:08 server kernel: [   95.509229] ata2.01: hard resetting link
Jul 26 20:08:08 server kernel: [   95.859496] ata2.01: SATA link up
3.0 Gbps (SStatus 123 SControl 300)
Jul 26 20:08:08 server kernel: [   95.859527] ata2.02: hard resetting link
Jul 26 20:08:08 server kernel: [   96.209250] ata2.02: SATA link up
3.0 Gbps (SStatus 123 SControl 300)
Jul 26 20:08:08 server kernel: [   96.209281] ata2.03: hard resetting link
Jul 26 20:08:09 server kernel: [   96.559047] ata2.03: SATA link up
3.0 Gbps (SStatus 123 SControl 300)
Jul 26 20:08:09 server kernel: [   96.908420] ata2.05: hard resetting link
Jul 26 20:08:09 server kernel: [   97.258682] ata2.05: SATA link up
1.5 Gbps (SStatus 113 SControl 320)
Jul 26 20:08:09 server kernel: [   97.264855] ata2.01: ATA-8: SAMSUNG
HD204UI, 1AQ10001, max UDMA/133
Jul 26 20:08:09 server kernel: [   97.264860] ata2.01: 3907029168
sectors, multi 0: LBA48 NCQ (depth 31/32)
Jul 26 20:08:09 server kernel: [   97.271186] ata2.01: configured for UDMA/100
Jul 26 20:08:10 server kernel: [   97.341790] ata2.02: configured for UDMA/100
Jul 26 20:08:10 server kernel: [   97.412377] ata2.03: configured for UDMA/100
Jul 26 20:08:10 server kernel: [   97.412454] ata2: EH complete
Jul 26 20:08:10 server kernel: [   97.915279] ata2.01: exception Emask
0x0 SAct 0x1 SErr 0x0 action 0x0
Jul 26 20:08:10 server kernel: [   97.915281] ata2.01: irq_stat
0x00060002, device error via D2H FIS
Jul 26 20:08:10 server kernel: [   97.915283] ata2.01: failed command:
READ FPDMA QUEUED
Jul 26 20:08:10 server kernel: [   97.915286] ata2.01: cmd
60/08:00:00:00:00/00:00:00:00:00/40 tag 0 ncq 4096 in
Jul 26 20:08:10 server kernel: [   97.915288] ata2.01: status: { DRDY }
Jul 26 20:08:10 server kernel: [   97.927685] ata2.01: configured for UDMA/100
Jul 26 20:08:10 server kernel: [   97.927750] ata2: EH complete
Jul 26 20:08:41 server kernel: [  128.410225] ata2.00: failed to read
SCR 1 (Emask=0x40)
Jul 26 20:08:41 server kernel: [  128.410230] ata2.01: failed to read
SCR 1 (Emask=0x40)
Jul 26 20:08:41 server kernel: [  128.410242] ata2.01: NCQ disabled
due to excessive errors
Jul 26 20:08:41 server kernel: [  128.410244] ata2.02: failed to read
SCR 1 (Emask=0x40)
Jul 26 20:08:41 server kernel: [  128.410246] ata2.03: failed to read
SCR 1 (Emask=0x40)
Jul 26 20:08:41 server kernel: [  128.410248] ata2.04: failed to read
SCR 1 (Emask=0x40)
Jul 26 20:08:41 server kernel: [  128.410250] ata2.05: failed to read
SCR 1 (Emask=0x40)
Jul 26 20:08:41 server kernel: [  128.410256] ata2.15: exception Emask
0x4 SAct 0x0 SErr 0x0 action 0x6 frozen
Jul 26 20:08:41 server kernel: [  128.410260] ata2.00: exception Emask
0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
Jul 26 20:08:41 server kernel: [  128.410263] ata2.01: exception Emask
0x100 SAct 0x1 SErr 0x0 action 0x6 frozen
Jul 26 20:08:41 server kernel: [  128.410266] ata2.01: failed command:
READ FPDMA QUEUED
Jul 26 20:08:41 server kernel: [  128.410272] ata2.01: cmd
60/08:00:00:00:00/00:00:00:00:00/40 tag 0 ncq 4096 in
Jul 26 20:08:41 server kernel: [  128.410275] ata2.01: status: { DRDY }
Jul 26 20:08:41 server kernel: [  128.410278] ata2.02: exception Emask
0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
Jul 26 20:08:41 server kernel: [  128.410281] ata2.03: exception Emask
0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
Jul 26 20:08:41 server kernel: [  128.410284] ata2.04: exception Emask
0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
Jul 26 20:08:41 server kernel: [  128.410287] ata2.05: exception Emask
0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
Jul 26 20:08:41 server kernel: [  128.410292] ata2.15: hard resetting link
Jul 26 20:08:43 server kernel: [  130.628905] ata2.15: SATA link up
3.0 Gbps (SStatus 123 SControl 0)
Jul 26 20:08:43 server kernel: [  130.629396] ata2.00: hard resetting link
Jul 26 20:08:43 server kernel: [  131.068653] ata2.00: link resume
succeeded after 1 retries
Jul 26 20:08:43 server kernel: [  131.189059] ata2.00: SATA link down
(SStatus 0 SControl 310)
Jul 26 20:08:43 server kernel: [  131.189113] ata2.01: hard resetting link
Jul 26 20:08:44 server kernel: [  131.538822] ata2.01: SATA link up
3.0 Gbps (SStatus 123 SControl 300)
Jul 26 20:08:44 server kernel: [  131.538851] ata2.02: hard resetting link
Jul 26 20:08:44 server kernel: [  131.888677] ata2.02: SATA link up
3.0 Gbps (SStatus 123 SControl 300)
Jul 26 20:08:44 server kernel: [  131.888706] ata2.03: hard resetting link
Jul 26 20:08:44 server kernel: [  132.238459] ata2.03: SATA link up
3.0 Gbps (SStatus 123 SControl 300)
Jul 26 20:08:44 server kernel: [  132.238484] ata2.04: hard resetting link
Jul 26 20:08:45 server kernel: [  132.588250] ata2.04: SATA link down
(SStatus 0 SControl 320)
Jul 26 20:08:45 server kernel: [  132.588303] ata2.05: hard resetting link
Jul 26 20:08:45 server kernel: [  132.938030] ata2.05: SATA link up
1.5 Gbps (SStatus 113 SControl 320)
Jul 26 20:08:45 server kernel: [  132.950420] ata2.01: configured for UDMA/100
Jul 26 20:08:45 server kernel: [  133.021099] ata2.02: configured for UDMA/100
Jul 26 20:08:45 server kernel: [  133.091697] ata2.03: configured for UDMA/100
Jul 26 20:08:45 server kernel: [  133.091772] ata2: EH complete
Jul 26 20:08:45 server kernel: [  133.092358] ata2.01: exception Emask
0x0 SAct 0x0 SErr 0x0 action 0x0
Jul 26 20:08:45 server kernel: [  133.092361] ata2.01: irq_stat
0x00060002, device error via D2H FIS
Jul 26 20:08:45 server kernel: [  133.092364] ata2.01: failed command: READ DMA
Jul 26 20:08:45 server kernel: [  133.092370] ata2.01: cmd
c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4096 in
Jul 26 20:08:45 server kernel: [  133.092374] ata2.01: status: { DRDY ERR }
Jul 26 20:08:45 server kernel: [  133.092375] ata2.01: error: { ABRT }
Jul 26 20:08:45 server kernel: [  133.104829] ata2.01: configured for UDMA/100
Jul 26 20:08:45 server kernel: [  133.104892] ata2: EH complete
Jul 26 20:08:45 server kernel: [  133.105406] ata2.01: exception Emask
0x0 SAct 0x0 SErr 0x0 action 0x0
Jul 26 20:08:45 server kernel: [  133.105407] ata2.01: irq_stat
0x00060002, device error via D2H FIS
Jul 26 20:08:45 server kernel: [  133.105408] ata2.01: failed command: READ DMA
Jul 26 20:08:45 server kernel: [  133.105411] ata2.01: cmd
c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4096 in
Jul 26 20:08:45 server kernel: [  133.105413] ata2.01: status: { DRDY ERR }
Jul 26 20:08:45 server kernel: [  133.105414] ata2.01: error: { ABRT }
Jul 26 20:08:45 server kernel: [  133.117865] ata2.01: configured for UDMA/100
Jul 26 20:08:45 server kernel: [  133.117934] ata2: EH complete
Jul 26 20:08:45 server kernel: [  133.118541] ata2.01: exception Emask
0x0 SAct 0x0 SErr 0x0 action 0x0
Jul 26 20:08:45 server kernel: [  133.118543] ata2.01: irq_stat
0x00060002, device error via D2H FIS
Jul 26 20:08:45 server kernel: [  133.118546] ata2.01: failed command: READ DMA
Jul 26 20:08:45 server kernel: [  133.118550] ata2.01: cmd
c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4096 in
Jul 26 20:08:45 server kernel: [  133.118553] ata2.01: status: { DRDY ERR }
Jul 26 20:08:45 server kernel: [  133.118554] ata2.01: error: { ABRT }
Jul 26 20:08:45 server kernel: [  133.130903] ata2.01: configured for UDMA/100
Jul 26 20:08:45 server kernel: [  133.130971] ata2: EH complete
Jul 26 20:08:45 server kernel: [  133.131465] ata2.01: exception Emask
0x0 SAct 0x0 SErr 0x0 action 0x0
Jul 26 20:08:45 server kernel: [  133.131467] ata2.01: irq_stat
0x00060002, device error via D2H FIS
Jul 26 20:08:45 server kernel: [  133.131469] ata2.01: failed command: READ DMA
Jul 26 20:08:45 server kernel: [  133.131474] ata2.01: cmd
c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4096 in
Jul 26 20:08:45 server kernel: [  133.131477] ata2.01: status: { DRDY ERR }
Jul 26 20:08:45 server kernel: [  133.131478] ata2.01: error: { ABRT }
Jul 26 20:08:45 server kernel: [  133.143799] ata2.01: configured for UDMA/100
Jul 26 20:08:45 server kernel: [  133.143918] ata2: EH complete
Jul 26 20:08:45 server kernel: [  133.144421] ata2.01: exception Emask
0x0 SAct 0x0 SErr 0x0 action 0x0
Jul 26 20:08:45 server kernel: [  133.144424] ata2.01: irq_stat
0x00060002, device error via D2H FIS
Jul 26 20:08:45 server kernel: [  133.144426] ata2.01: failed command: READ DMA
Jul 26 20:08:45 server kernel: [  133.144432] ata2.01: cmd
c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4096 in
Jul 26 20:08:45 server kernel: [  133.144436] ata2.01: status: { DRDY ERR }
Jul 26 20:08:45 server kernel: [  133.144438] ata2.01: error: { ABRT }
Jul 26 20:08:45 server kernel: [  133.156987] ata2.01: configured for UDMA/100
Jul 26 20:08:45 server kernel: [  133.157051] ata2: EH complete
Jul 26 20:08:45 server kernel: [  133.157705] ata2.01: exception Emask
0x0 SAct 0x0 SErr 0x0 action 0x0
Jul 26 20:08:45 server kernel: [  133.157709] ata2.01: irq_stat
0x00060002, device error via D2H FIS
Jul 26 20:08:45 server kernel: [  133.157713] ata2.01: failed command: READ DMA
Jul 26 20:08:45 server kernel: [  133.157719] ata2.01: cmd
c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4096 in
Jul 26 20:08:45 server kernel: [  133.157723] ata2.01: status: { DRDY ERR }
Jul 26 20:08:45 server kernel: [  133.157725] ata2.01: error: { ABRT }
Jul 26 20:08:45 server kernel: [  133.170197] ata2.01: configured for UDMA/100
Jul 26 20:08:45 server kernel: [  133.170278] ata2: EH complete

Later:

Jul 26 20:08:48 server kernel: [  135.920773] ata2.01: exception Emask
0x0 SAct 0x0 SErr 0x0 action 0x0
Jul 26 20:08:48 server kernel: [  135.920778] ata2.01: irq_stat
0x00060002, device error via D2H FIS
Jul 26 20:08:48 server kernel: [  135.920781] ata2.01: failed command:
READ DMA EXT
Jul 26 20:08:48 server kernel: [  135.920787] ata2.01: cmd
25/00:08:a8:88:e0/00:00:e8:00:00/e0 tag 0 dma 4096 in
Jul 26 20:08:48 server kernel: [  135.920792] ata2.01: status: { DRDY ERR }
Jul 26 20:08:48 server kernel: [  135.920794] ata2.01: error: { ABRT }
Jul 26 20:08:48 server kernel: [  135.933417] ata2.01: configured for UDMA/100
Jul 26 20:08:48 server kernel: [  135.933497] ata2: EH complete

The *really* interesting thing is that the drive responds just find to
identify commands -

# hdparm -i /dev/sdj

/dev/sdj:

 Model=SAMSUNG HD204UI, FwRev=1AQ10001, SerialNo=S2H7JD2ZA1[truncated]
 Config={ Fixed }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=4
 BuffType=unknown, BuffSize=unknown, MaxMultSect=16, MultSect=off
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=3907029168
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4
 DMA modes:  mdma0 mdma1 mdma2
 UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5 udma6
 AdvancedPM=yes: unknown setting WriteCache=enabled
 Drive conforms to: unknown:  ATA/ATAPI-0,1,2,3,4,5,6,7

 * signifies the current active mode

I've spend a bunch of time trying to find an answer to this, but am
not having any luck.  What else can I try?

Thanks!

-- 
Ryan Castellucci http://ryanc.org/
