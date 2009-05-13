From: Raz <raziebe@gmail.com>
Subject: stex : invalid tag
Date: Wed, 13 May 2009 22:07:28 +0300
Message-ID: <5d96567b0905131207n3b5ca4acj8f9ded7ae8e49b2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qy0-f133.google.com ([209.85.221.133]:38278 "EHLO
	mail-qy0-f133.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754053AbZEMTHt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 13 May 2009 15:07:49 -0400
Received: by qyk39 with SMTP id 39so1553591qyk.33
        for <linux-ide@vger.kernel.org>; Wed, 13 May 2009 12:07:49 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: promise_linux@promise.com
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Ed hello
I am getting the bellow errors ( kernel 2.6.18.el5 )
It is a  RAID bus controller: Promise Technology, Inc. 80333
[SuperTrak EX8350/EX16350], 80331 [SuperTrak EX8300/EX16300].
is it broken ? can i fix it somehow ?
thank you
raz

[2141509.667701] stex(0000:04:0e.0): invalid tag
[2141509.676432] stex(0000:04:0e.0): invalid tag
[2141509.687695] stex(0000:04:0e.0): invalid tag
[2141509.696430] stex(0000:04:0e.0): invalid tag
[2141509.705148] stex(0000:04:0e.0): invalid tag
[2141509.716974] stex(0000:04:0e.0): invalid tag
[2141509.725707] stex(0000:04:0e.0): invalid tag
[2141509.737228] stex(0000:04:0e.0): invalid tag
[2141509.745961] stex(0000:04:0e.0): invalid tag
[2141509.754681] stex(0000:04:0e.0): invalid tag
[2141509.763393] stex(0000:04:0e.0): invalid tag
[2141509.772110] stex(0000:04:0e.0): invalid tag
[2141569.701671] stex(0000:04:0e.0): invalid tag
[2141569.712296] stex(0000:04:0e.0): invalid tag
[2141569.721025] stex(0000:04:0e.0): invalid tag
[2141569.769203] stex(0000:04:0e.0): invalid tag
[2141570.538141] stex(0000:04:0e.0): invalid tag
[2141585.598346] stex(0000:04:0e.0): invalid tag
[2141585.607082] stex(0000:04:0e.0): invalid tag
[2141585.615804] stex(0000:04:0e.0): invalid tag
[2142220.137103] stex(0000:04:0e.0): no handshake signature
[2142220.147740] stex(0000:04:0e.0): resetting: handshake failed
[2142220.159244] sd 0:0:3:0: scsi: Device offlined - not ready after
error recovery
[2142220.174053] sd 0:0:2:0: scsi: Device offlined - not ready after
error recovery
[2142220.188861] sd 0:0:6:0: scsi: Device offlined - not ready after
error recovery
[2142220.203663] sd 0:0:1:0: scsi: Device offlined - not ready after
error recovery
[2142220.218469] sd 0:0:5:0: scsi: Device offlined - not ready after
error recovery
[2142220.233270] sd 0:0:1:0: scsi: Device offlined - not ready after
error recovery
[2142220.248077] sd 0:0:5:0: scsi: Device offlined - not ready after
error recovery
[2142220.262881] sd 0:0:3:0: scsi: Device offlined - not ready after
error recovery
[2142220.277684] sd 0:0:1:0: scsi: Device offlined - not ready after
error recovery
[2142220.292493] sd 0:0:5:0: scsi: Device offlined - not ready after
error recovery
[2142220.307293] sd 0:0:1:0: scsi: Device offlined - not ready after
error recovery
[2142220.322094] sd 0:0:1:0: scsi: Device offlined - not ready after
error recovery
[2142220.336903] sd 0:0:2:0: scsi: Device offlined - not ready after
error recovery
[2142220.351705] sd 0:0:2:0: scsi: Device offlined - not ready after
error recovery
[2142220.366524] sd 0:0:3:0: SCSI error: return code = 0x06000000
[2142220.378199] end_request: I/O error, dev sdd, sector 12030269
[2142220.389873] raid1: Disk failure on md2, disabling device.
[2142220.389875]        Operation continuing on 1 devices
[2142220.410493] sd 0:0:6:0: rejecting I/O to offline device
[2142220.421293] sd 0:0:6:0: rejecting I/O to offline device
[2142220.432092] sd 0:0:6:0: SCSI error: return code = 0x00010000
[2142220.443763] end_request: I/O error, dev sdg, sector 9575493
[2142220.455358] sd 0:0:5:0: rejecting I/O to offline device
[2142220.455947] sd 0:0:1:0: rejecting I/O to offline device
[2142220.455955] sd 0:0:1:0: rejecting I/O to offline device
[2142220.456502] sd 0:0:1:0: SCSI error: return code = 0x00010000
[2142220.456505] end_request: I/O error, dev sdb, sector 9511381
[2142220.510898] sd 0:0:5:0: rejecting I/O to offline device
[2142220.521696] sd 0:0:5:0: rejecting I/O to offline device
[2142220.532509] sd 0:0:3:0: rejecting I/O to offline device
[2142220.532515] sd 0:0:5:0: SCSI error: return code = 0x00010000
[2142220.532518] end_request: I/O error, dev sdf, sector 9511358
[2142220.546038] Device md6, XFS metadata write error block 0x1c9f698 in md6
[2142220.580027] sd 0:0:3:0: rejecting I/O to offline device
[2142220.590821] sd 0:0:3:0: rejecting I/O to offline device
[2142220.601629] sd 0:0:3:0: SCSI error: return code = 0x00010000
[2142220.613292] end_request: I/O error, dev sdd, sector 24517845
[2142220.625217] sd 0:0:2:0: SCSI error: return code = 0x06000000
[2142220.636905] end_request: I/O error, dev sdc, sector 28247
[2142220.648055] raid1: Disk failure on md0, disabling device.
[2142220.648057]        Operation continuing on 1 devices
[2142220.668648] sd 0:0:6:0: SCSI error: return code = 0x06000000
[2142220.680329] end_request: I/O error, dev sdg, sector 28247
[2142220.691504] sd 0:0:1:0: SCSI error: return code = 0x06000000
[2142220.703183] end_request: I/O error, dev sdb, sector 509392920
[2142220.715067] sd 0:0:2:0: rejecting I/O to offline device
[2142220.725878] sd 0:0:3:0: rejecting I/O to offline device
[2142220.728806] sd 0:0:5:0: SCSI error: return code = 0x06000000
[2142220.728809] end_request: I/O error, dev sdf, sector 139253280
[2142220.728814] raid5: Disk failure on sdf3, disabling device.
Operation continuing on 7 devices
[2142220.728823] sd 0:0:5:0: rejecting I/O to offline device
[2142220.728828] raid5:md5: read error not correctable (sector
467366880 on sdf3).
[2142220.728834] sd 0:0:1:0: SCSI error: return code = 0x06000000
[2142220.728836] end_request: I/O error, dev sdb, sector 19515717
[2142220.728855] sd 0:0:5:0: SCSI error: return code = 0x06000000
[2142220.728858] end_request: I/O error, dev sdf, sector 17082341
[2142220.849450] raid5:md5: read error not correctable (sector
467366880 on sdd3).
[2142220.864071] raid5: Disk failure on sdd3, disabling device.
Operation continuing on 6 devices
[2142220.881297] sd 0:0:6:0: rejecting I/O to offline device
[2142220.881737] sd 0:0:3:0: SCSI error: return code = 0x06000000
[2142220.881740] end_request: I/O error, dev sdd, sector 19581797
[2142220.881753] sd 0:0:1:0: SCSI error: return code = 0x06000000
[2142220.881755] end_request: I/O error, dev sdb, sector 9511373
[2142220.881762] sd 0:0:5:0: SCSI error: return code = 0x06000000
[2142220.881765] end_request: I/O error, dev sdf, sector 9511365
[2142220.881776] sd 0:0:1:0: SCSI error: return code = 0x06000000
[2142220.881779] end_request: I/O error, dev sdb, sector 9511358
[2142220.881787] sd 0:0:1:0: SCSI error: return code = 0x06000000
[2142220.881790] end_request: I/O error, dev sdb, sector 9511365
[2142220.881799] sd 0:0:2:0: SCSI error: return code = 0x06000000
[2142220.881802] end_request: I/O error, dev sdc, sector 9575493
[2142220.881813] sd 0:0:2:0: SCSI error: return code = 0x06000000
[2142220.881815] end_request: I/O error, dev sdc, sector 9575525
[2142221.054301] raid5:md5: read error not correctable (sector
467366880 on sdg3).
[2142221.068920] raid5: Disk failure on sdg3, disabling device.
Operation continuing on 5 devices
[2142221.087408] sd 0:0:2:0: rejecting I/O to offline device
[2142221.098202] sd 0:0:2:0: rejecting I/O to offline device
[2142221.108996] sd 0:0:2:0: rejecting I/O to offline device
[2142221.119789] raid5: Disk failure on sdc3, disabling device.
Operation continuing on 4 devices
[2142221.137031] sd 0:0:1:0: rejecting I/O to offline device
[2142221.147840] sd 0:0:1:0: rejecting I/O to offline device
[2142221.158631] sd 0:0:1:0: rejecting I/O to offline device
[2142221.169426] raid5: Disk failure on sdb3, disabling device.
Operation continuing on 3 devices
