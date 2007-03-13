From: "Fajun Chen" <fajunchen@gmail.com>
Subject: PATA Sil680 Command Timeout on ARM XScale
Date: Tue, 13 Mar 2007 11:34:02 -0700
Message-ID: <8202f4270703131134x68c028fbv7fb536c694a6b898@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.229]:58009 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752379AbXCMSeD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 13 Mar 2007 14:34:03 -0400
Received: by nz-out-0506.google.com with SMTP id s1so1576858nze
        for <linux-ide@vger.kernel.org>; Tue, 13 Mar 2007 11:34:02 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Cc: Tejun Heo <htejun@gmail.com>, Alan <alan@lxorguk.ukuu.org.uk>

Hi Folks,

We have a command timeout with Sil680 controller on ARM XScale. The
kernel is 2.6.18-rc2 and libata 2.00 with preemptive enabled. Similar
problem observed as well with kernel preemptive disabled.  ATA pass
through and sg are used.  Heavy IO test was ran on both channels of
Sil680 and the system was pretty loaded where the load average was
above 1.5.   Two timers are used to track command timeout in our test
software.  The one in the user space is set to 6 seconds using alarm()
call while the one in the kernel (scsi timer) is set to 5 seconds.
These timeout values are probably too low to be realistic,  but the
issue here is not about the timeout itself but to understand why it is
always user space timer expired before kernel timer.   Since kernel
timer uses jiffies to track time, does this imply a kernel bug where
the time interrupts were lost or delay somehow?  Do you know any know
problems related to command timeout in PATA Sil680?

Thanks,
Fajun
--------------------------------
User space trace:
Cmd 4276 timed out after 7.260137 secs: start time 1173775439.409099
secs, timed out at 1173775446.669236 secs
[Tue Mar 13 08:44:06 2007]:
Test:               Random Write Sectors Extended
LBA Low:            0
LBA High:           100000
...
Num Cmds:           4277
Num_Failed_Cmds:    1
...
Status:             Fail [Error 401: Command timeout]

Dmesg log

~ $ dmesg
.770000] Calling initcall 0xc001ebb4: inet_diag_init+0x0/0x80()
[42949375.770000] Calling initcall 0xc001ec34: tcp_diag_init+0x0/0x1c()
[42949375.770000] Calling initcall 0xc001ec50: bictcp_register+0x0/0x1c()
[42949375.770000] TCP bic registered
[42949375.770000] Calling initcall 0xc001ee2c: af_unix_init+0x0/0x80()
[42949375.770000] NET: Registered protocol family 1
[42949375.770000] Calling initcall 0xc001eeac: packet_init+0x0/0x70()
[42949375.770000] NET: Registered protocol family 17
[42949375.770000] Calling initcall 0xc0012a88:
clocksource_done_booting+0x0/0x24()
[42949375.770000] Calling initcall 0xc0019ed4: seqgen_init+0x0/0x1c()
[42949375.770000] Calling initcall 0xc001ba44:
early_uart_console_switch+0x0/0x90()
[42949375.770000] Calling initcall 0xc013a150: net_random_reseed+0x0/0x38()
[42949375.770000] RAMDISK: Compressed image found at block 0
[42949378.950000] VFS: Mounted root (ext2 filesystem).
[42949378.960000] Freeing init memory: 104K
[42949549.170000] ata1: soft resetting port
[42949549.250000] ata1.00: ATA-6, max UDMA/100, 78140160 sectors: LBA48
[42949549.250000] ata1.00: configured for UDMA/100
[42949549.250000] ata1: EH complete
[42949549.250000]   Vendor: ATA       Model: ST940813AM        Rev: 3.02
[42949549.250000]   Type:   Direct-Access                      ANSI
SCSI revision: 05
[42949549.260000] SCSI device sda: 78140160 512-byte hdwr sectors (40008 MB)
[42949549.260000] sda: Write Protect is off
[42949549.260000] sda: Mode Sense: 00 3a 00 00
[42949549.260000] SCSI device sda: drive cache: write back
[42949549.270000] SCSI device sda: 78140160 512-byte hdwr sectors (40008 MB)
[42949549.270000] sda: Write Protect is off
[42949549.270000] sda: Mode Sense: 00 3a 00 00
[42949549.270000] SCSI device sda: drive cache: write back
[42949549.270000]  sda: unknown partition table
[42949549.290000] sd 0:0:0:0: Attached scsi disk sda
[42949549.290000] sd 0:0:0:0: Attached scsi generic sg0 type 0
[42949549.320000] ata1: soft resetting port
[42949549.380000] ata1.00: configured for UDMA/100
[42949549.380000] ata1: EH complete
[42949549.380000] SCSI device sda: 78140160 512-byte hdwr sectors (40008 MB)
[42949549.380000] sda: Write Protect is off
[42949549.380000] sda: Mode Sense: 00 3a 00 00
[42949549.390000] SCSI device sda: drive cache: write back
[42949559.280000] ata2: soft resetting port
[42949559.420000] ata2.00: ATA-6, max UDMA/100, 78140160 sectors: LBA48
[42949559.420000] ata2.00: configured for UDMA/100
[42949559.420000] ata2: EH complete
[42949559.420000]   Vendor: ATA       Model: ST94811A          Rev: 3.07
[42949559.420000]   Type:   Direct-Access                      ANSI
SCSI revision: 05
[42949559.430000] SCSI device sdb: 78140160 512-byte hdwr sectors (40008 MB)
[42949559.430000] sdb: Write Protect is off
[42949559.430000] sdb: Mode Sense: 00 3a 00 00
[42949559.430000] SCSI device sdb: drive cache: write back
[42949559.430000] SCSI device sdb: 78140160 512-byte hdwr sectors (40008 MB)
[42949559.440000] sdb: Write Protect is off
[42949559.440000] sdb: Mode Sense: 00 3a 00 00
[42949559.440000] SCSI device sdb: drive cache: write back
[42949559.440000]  sdb: unknown partition table
[42949559.460000] sd 1:0:0:0: Attached scsi disk sdb
[42949559.460000] sd 1:0:0:0: Attached scsi generic sg1 type 0
[  643.230000] NWFPE: ntpd[38] takes exception 00000001 at c002d514
from 0001d308
[  711.230000] NWFPE: ntpd[38] takes exception 00000001 at c002d514
from 0001d308
[  777.220000] NWFPE: ntpd[38] takes exception 00000001 at c002d514
from 0001d308
[  841.300000] NWFPE: ntpd[38] takes exception 00000001 at c002d514
from 0001d308
[  906.270000] NWFPE: ntpd[38] takes exception 00000001 at c002d514
from 0001d308
[  972.190000] NWFPE: ntpd[38] takes exception 00000001 at c002d514
from 0001d308
[ 1035.280000] NWFPE: ntpd[38] takes exception 00000001 at c002d514
from 0001d308
[ 1162.190000] NWFPE: ntpd[38] takes exception 00000001 at c002d514
from 0001d308
[ 1292.230000] NWFPE: ntpd[38] takes exception 00000001 at c002d514
from 0001d308
[ 1422.220000] NWFPE: ntpd[38] takes exception 00000001 at c002d514
from 0001d308
[ 1551.310000] NWFPE: ntpd[38] takes exception 00000001 at c002d514
from 0001d308
[ 1680.260000] NWFPE: ntpd[38] takes exception 00000001 at c002d514
from 0001d308
[ 1936.230000] NWFPE: ntpd[38] takes exception 00000001 at c002d514
from 0001d308
[ 2193.200000] NWFPE: ntpd[38] takes exception 00000001 at c002d514
from 0001d308
[ 2450.170000] NWFPE: ntpd[38] takes exception 00000001 at c002d514
from 0001d308
[ 2707.240000] NWFPE: ntpd[38] takes exception 00000001 at c002d514
from 0001d308
[ 3219.170000] NWFPE: ntpd[38] takes exception 00000001 at c002d514
from 0001d308
[ 3733.170000] NWFPE: ntpd[38] takes exception 00000001 at c002d514
from 0001d308
[ 4245.140000] NWFPE: ntpd[38] takes exception 00000001 at c002d514
from 0001d308
[ 4759.130000] NWFPE: ntpd[38] takes exception 00000001 at c002d514
from 0001d308
[ 5782.140000] NWFPE: ntpd[38] takes exception 00000001 at c002d514
from 0001d308
[ 6808.180000] NWFPE: ntpd[38] takes exception 00000001 at c002d514
from 0001d308
[ 7831.150000] NWFPE: ntpd[38] takes exception 00000001 at c002d514
from 0001d308
[ 8855.110000] NWFPE: ntpd[38] takes exception 00000001 at c002d514
from 0001d308
[ 9880.070000] NWFPE: ntpd[38] takes exception 00000001 at c002d514
from 0001d308
[10906.100000] NWFPE: ntpd[38] takes exception 00000001 at c002d514
from 0001d308
[11931.030000] NWFPE: ntpd[38] takes exception 00000001 at c002d514
from 0001d308
[12955.070000] NWFPE: ntpd[38] takes exception 00000001 at c002d514
from 0001d308
[13978.110000] NWFPE: ntpd[38] takes exception 00000001 at c002d514
from 0001d308
[15003.060000] NWFPE: ntpd[38] takes exception 00000001 at c002d514
from 0001d308
[16028.010000] NWFPE: ntpd[38] takes exception 00000001 at c002d514
from 0001d308
[17051.960000] NWFPE: ntpd[38] takes exception 00000001 at c002d514
from 0001d308
[18077.950000] NWFPE: ntpd[38] takes exception 00000001 at c002d514
from 0001d308
[19100.930000] NWFPE: ntpd[38] takes exception 00000001 at c002d514
from 0001d308
[20126.930000] NWFPE: ntpd[38] takes exception 00000001 at c002d514
from 0001d308
[21150.920000] NWFPE: ntpd[38] takes exception 00000001 at c002d514
from 0001d308
[22176.890000] NWFPE: ntpd[38] takes exception 00000001 at c002d514
from 0001d308
[23199.900000] NWFPE: ntpd[38] takes exception 00000001 at c002d514
from 0001d308
[24224.920000] NWFPE: ntpd[38] takes exception 00000001 at c002d514
from 0001d308
[25248.860000] NWFPE: ntpd[38] takes exception 00000001 at c002d514
from 0001d308
[26271.850000] NWFPE: ntpd[38] takes exception 00000001 at c002d514
from 0001d308
[27297.860000] NWFPE: ntpd[38] takes exception 00000001 at c002d514
from 0001d308
[28323.790000] NWFPE: ntpd[38] takes exception 00000001 at c002d514
from 0001d308
[29346.790000] NWFPE: ntpd[38] takes exception 00000001 at c002d514
from 0001d308
[30382.830000] NWFPE: ntpd[38] takes exception 00000001 at c002d514
from 0001d308
[31406.810000] NWFPE: ntpd[38] takes exception 00000001 at c002d514
from 0001d308
[32429.780000] NWFPE: ntpd[38] takes exception 00000001 at c002d514
from 0001d308
[33454.720000] NWFPE: ntpd[38] takes exception 00000001 at c002d514
from 0001d308
[34480.710000] NWFPE: ntpd[38] takes exception 00000001 at c002d514
from 0001d308
[35503.690000] NWFPE: ntpd[38] takes exception 00000001 at c002d514
from 0001d308
[36498.280000] sg_cmd_done: sg0, pack_id=349, res=0x0, dur=2240 ms
[36526.680000] NWFPE: ntpd[38] takes exception 00000001 at c002d514
from 0001d308
[37552.780000] NWFPE: ntpd[38] takes exception 00000001 at c002d514
from 0001d308
[38577.660000] NWFPE: ntpd[38] takes exception 00000001 at c002d514
from 0001d308
[39602.630000] NWFPE: ntpd[38] takes exception 00000001 at c002d514
from 0001d308
[40627.630000] NWFPE: ntpd[38] takes exception 00000001 at c002d514
from 0001d308
