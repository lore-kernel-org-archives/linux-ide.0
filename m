From: "dusty@gmx.li" <dusty@gmx.li>
Subject: Re: libata pm
Date: Tue, 5 Feb 2008 18:50:16 -0000 (UTC)
Message-ID: <49452.82.140.55.233.1202237416.squirrel@ssl.cavemail.org>
References: <52279.82.140.50.2.1201370600.squirrel@ssl.cavemail.org>         
          <49398.82.140.50.2.1201377943.squirrel@ssl.cavemail.org>         
          <479BC34D.2000007@gmail.com>            
    <49407.82.140.63.93.1201397926.squirrel@ssl.cavemail.org>         
    <49713.82.140.63.93.1201462475.squirrel@ssl.cavemail.org>         
    <479D2D3C.4050102@gmail.com>      
    <51861.82.140.47.248.1201516318.squirrel@ssl.cavemail.org>      
    <479DC4A4.30809@gmail.com>   
    <50028.82.140.53.128.1201728857.squirrel@ssl.cavemail.org>   
    <47A120D4.7030504@gmail.com>
    <59194.82.140.47.129.1201873378.squirrel@ssl.cavemail.org>
    <47A32749.6060009@rtr.ca> <47A33541.8000305@gmail.com>
Reply-To: dusty@gmx.li
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cavemail.org ([62.75.189.85]:54300 "EHLO mail.cavemail.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751716AbYBESuX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 5 Feb 2008 13:50:23 -0500
In-Reply-To: <47A33541.8000305@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Mark Lord <liml@rtr.ca>, dusty@gmx.li, linux-ide@vger.kernel.org

Hi everybody,

it looks like this will be a never ending story...

>>> After I got the new PSU and the raid was in full sync without any
>>> error for 48h, I thought all problems were gone. Today the sata errors
>>>  reappeared and whenever the load is high enough I get the following:
>>>
I exchanged two (probably failing) of the eight harddrives with new ones.
All remaining disks have a good smart state and are fully readable when
the raid is not active. As long as I mount the filesystem on the raid
readonly there wont happen any error, but the moment I mount it rw and try
to copy something to the fs on the raid I get the already known timeout.
At least I get a little bit desperate now...

ata10.00: failed to read SCR 1 (Emask=0x40)
ata10.01: failed to read SCR 1 (Emask=0x40)
ata10.02: failed to read SCR 1 (Emask=0x40)
ata10.03: failed to read SCR 1 (Emask=0x40)
ata10.04: failed to read SCR 1 (Emask=0x40)
ata10.05: failed to read SCR 1 (Emask=0x40)
ata10.00: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata10.01: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata10.01: cmd ea/00:00:00:00:00/00:00:00:00:00/a0 tag 1 cdb 0x0 data 0
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata10.01: status: { DRDY }
ata10.02: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata10.03: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata10.04: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata10.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata10.15: hard resetting link
ata10.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata10.00: hard resetting link
ata10.00: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata10.01: hard resetting link
ata10.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata10.02: hard resetting link
ata10.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata10.03: hard resetting link
ata10.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata10.04: hard resetting link
ata10.04: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata10.05: hard resetting link
ata10.05: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata10.00: configured for UDMA/100
ata10.01: configured for UDMA/100
ata10.03: configured for UDMA/100
ata10.04: configured for UDMA/100
ata10: EH complete
sd 9:0:0:0: [sdl] 976773168 512-byte hardware sectors (500108 MB)
sd 9:0:0:0: [sdl] Write Protect is off
sd 9:0:0:0: [sdl] Mode Sense: 00 3a 00 00
sd 9:0:0:0: [sdl] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 9:1:0:0: [sdm] 976773168 512-byte hardware sectors (500108 MB)
sd 9:1:0:0: [sdm] Write Protect is off
sd 9:1:0:0: [sdm] Mode Sense: 00 3a 00 00
sd 9:1:0:0: [sdm] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 9:2:0:0: [sdn] 976773168 512-byte hardware sectors (500108 MB)
sd 9:2:0:0: [sdn] Write Protect is off
sd 9:2:0:0: [sdn] Mode Sense: 00 3a 00 00
sd 9:2:0:0: [sdn] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 9:3:0:0: [sdo] 976773168 512-byte hardware sectors (500108 MB)
sd 9:3:0:0: [sdo] Write Protect is off
sd 9:3:0:0: [sdo] Mode Sense: 00 3a 00 00
sd 9:3:0:0: [sdo] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 9:4:0:0: [sdp] 976773168 512-byte hardware sectors (500108 MB)
sd 9:4:0:0: [sdp] Write Protect is off
sd 9:4:0:0: [sdp] Mode Sense: 00 3a 00 00
sd 9:4:0:0: [sdp] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA


