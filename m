From: "Stoyan Gaydarov" <stoyboyker@gmail.com>
Subject: Re: ata error
Date: Fri, 25 Jul 2008 13:47:31 -0500
Message-ID: <6d291e080807251147n14b0f0d1g4c8ad1d4759c702b@mail.gmail.com>
References: <6d291e080807251143k6cfc6db1w4e024ac245187d48@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.189]:3574 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751734AbYGYSrd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 25 Jul 2008 14:47:33 -0400
Received: by nf-out-0910.google.com with SMTP id d3so1305334nfc.21
        for <linux-ide@vger.kernel.org>; Fri, 25 Jul 2008 11:47:31 -0700 (PDT)
In-Reply-To: <6d291e080807251143k6cfc6db1w4e024ac245187d48@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

On Fri, Jul 25, 2008 at 1:43 PM, Stoyan Gaydarov <stoyboyker@gmail.com> wrote:
> First thing, can you cc me as I am not a subscriber.
>
> My box keeps freezing and the only thing i can see is that i continue
> to get errors coming from libata.
>
> stoyan@stoydesk:~$ uname -a
> Linux stoydesk 2.6.24-19-generic #1 SMP Fri Jul 11 23:41:49 UTC 2008
> i686 GNU/Linux
>
> The end of dmesg:
>
> [ 1078.546352] ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> [ 1078.546365] ata3.00: cmd 25/00:00:b6:2e:5b/00:01:28:00:00/e0 tag 0
> dma 131072 in
> [ 1078.546367]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask
> 0x4 (timeout)
> [ 1078.546371] ata3.00: status: { DRDY }
> [ 1078.546385] ata3: soft resetting link
> [ 1078.735322] ata3.00: configured for UDMA/133
> [ 1078.735336] ata3: EH complete
> [ 1078.766066] sd 2:0:0:0: [sda] 976773168 512-byte hardware sectors (500108 MB)
> [ 1078.766442] sd 2:0:0:0: [sda] Write Protect is off
> [ 1078.766448] sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
> [ 1078.766957] sd 2:0:0:0: [sda] Write cache: enabled, read cache:
> enabled, doesn't support DPO or FUA
> [ 1107.310768] [drm] Loading R300 Microcode
> [ 1108.810987] ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> [ 1108.811000] ata3.00: cmd c8/00:08:6e:46:10/00:00:00:00:00/e2 tag 0
> dma 4096 in
> [ 1108.811002]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask
> 0x4 (timeout)
> [ 1108.811006] ata3.00: status: { DRDY }
> [ 1108.811021] ata3: soft resetting link
> [ 1116.234620] [drm] Setting GART location based on new memory map
> [ 1116.235636] [drm] Loading R300 Microcode
> [ 1116.235730] [drm] writeback test succeeded in 2 usecs
> [ 1117.841835] ata3.00: revalidation failed (errno=-2)
> [ 1117.841843] ata3: failed to recover some devices, retrying in 5 secs
> [ 1122.841292] ata3: soft resetting link
> [ 1123.034315] ata3.00: configured for UDMA/133
> [ 1123.034335] ata3: EH complete
> [ 1123.053229] sd 2:0:0:0: [sda] 976773168 512-byte hardware sectors (500108 MB)
> [ 1123.053263] sd 2:0:0:0: [sda] Write Protect is off
> [ 1123.053266] sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
> [ 1123.053293] sd 2:0:0:0: [sda] Write cache: enabled, read cache:
> enabled, doesn't support DPO or FUA
> [ 1144.790950] [drm] Loading R300 Microcode
> [ 1153.185867] ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> [ 1153.185934] ata3.00: cmd ca/00:08:46:55:e9/00:00:00:00:00/e0 tag 0
> dma 4096 out
> [ 1153.185936]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask
> 0x4 (timeout)
> [ 1153.185993] ata3.00: status: { DRDY }
> [ 1153.186054] ata3: soft resetting link
> [ 1153.378626] ata3.00: configured for UDMA/133
> [ 1153.378638] ata3: EH complete
> [ 1153.379063] sd 2:0:0:0: [sda] 976773168 512-byte hardware sectors (500108 MB)
> [ 1153.379269] sd 2:0:0:0: [sda] Write Protect is off
> [ 1153.379272] sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
> [ 1153.379694] sd 2:0:0:0: [sda] Write cache: enabled, read cache:
> enabled, doesn't support DPO or FUA
> [ 1183.570407] ata3.00: limiting speed to UDMA/100:PIO4
> [ 1183.570415] ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> [ 1183.570493] ata3.00: cmd c8/00:08:8e:24:27/00:00:00:00:00/e1 tag 0
> dma 4096 in
> [ 1183.570495]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask
> 0x4 (timeout)
> [ 1183.570576] ata3.00: status: { DRDY }
> [ 1183.570648] ata3: soft resetting link
> [ 1183.764233] ata3.00: configured for UDMA/100
> [ 1183.764243] ata3: EH complete
> [ 1183.776780] sd 2:0:0:0: [sda] 976773168 512-byte hardware sectors (500108 MB)
> [ 1183.777051] sd 2:0:0:0: [sda] Write Protect is off
> [ 1183.777055] sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
> [ 1183.777602] sd 2:0:0:0: [sda] Write cache: enabled, read cache:
> enabled, doesn't support DPO or FUA
> [ 1192.911301] [drm] Loading R300 Microcode
> [ 1214.362549] ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> [ 1214.362560] ata3.00: cmd c8/00:08:2e:f3:7b/00:00:00:00:00/e0 tag 0
> dma 4096 in
> [ 1214.362562]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask
> 0x4 (timeout)
> [ 1214.362566] ata3.00: status: { DRDY }
> [ 1214.362580] ata3: soft resetting link
> [ 1214.546911] ata3.00: configured for UDMA/100
> [ 1214.546922] ata3: EH complete
> [ 1214.559814] sd 2:0:0:0: [sda] 976773168 512-byte hardware sectors (500108 MB)
> [ 1214.559839] sd 2:0:0:0: [sda] Write Protect is off
> [ 1214.559843] sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
> [ 1214.559869] sd 2:0:0:0: [sda] Write cache: enabled, read cache:
> enabled, doesn't support DPO or FUA
> [ 1216.802968] [drm] Setting GART location based on new memory map
> [ 1216.803978] [drm] Loading R300 Microcode
> [ 1216.804074] [drm] writeback test succeeded in 2 usecs
> [ 1299.509565] ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> [ 1299.509578] ata3.00: cmd ca/00:58:86:a1:77/00:00:00:00:00/e0 tag 0
> dma 45056 out
> [ 1299.509580]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask
> 0x4 (timeout)
> [ 1299.509584] ata3.00: status: { DRDY }
> [ 1299.509598] ata3: soft resetting link
> [ 1299.690019] ata3.00: configured for UDMA/100
> [ 1299.690032] ata3: EH complete
> [ 1299.702833] sd 2:0:0:0: [sda] 976773168 512-byte hardware sectors (500108 MB)
> [ 1299.702858] sd 2:0:0:0: [sda] Write Protect is off
> [ 1299.702862] sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
> [ 1299.702888] sd 2:0:0:0: [sda] Write cache: enabled, read cache:
> enabled, doesn't support DPO or FUA
> [ 1394.623563] ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> [ 1394.623576] ata3.00: cmd ca/00:58:7e:a9:77/00:00:00:00:00/e0 tag 0
> dma 45056 out
> [ 1394.623578]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask
> 0x4 (timeout)
> [ 1394.623582] ata3.00: status: { DRDY }
> [ 1399.658998] ata3: port is slow to respond, please be patient (Status 0x80)
> [ 1399.886793] ata3: soft resetting link
> [ 1400.067439] ata3.00: configured for UDMA/100
> [ 1400.067450] ata3: EH complete
> [ 1400.067907] sd 2:0:0:0: [sda] 976773168 512-byte hardware sectors (500108 MB)
> [ 1400.067930] sd 2:0:0:0: [sda] Write Protect is off
> [ 1400.067933] sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
> [ 1400.067958] sd 2:0:0:0: [sda] Write cache: enabled, read cache:
> enabled, doesn't support DPO or FUA

[ 1435.035055] ata3.00: status: { DRDY }
[ 1435.035069] ata3: soft resetting link
[ 1465.163780] ata3.00: qc timeout (cmd 0xec)
[ 1465.163790] ata3.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[ 1465.163794] ata3.00: revalidation failed (errno=-5)
[ 1465.163800] ata3: failed to recover some devices, retrying in 5 secs
[ 1471.226287] ata3: soft resetting link
[ 1471.411791] ata3.00: configured for UDMA/33
[ 1471.411810] ata3: EH complete
[ 1471.412276] sd 2:0:0:0: [sda] 976773168 512-byte hardware sectors (500108 MB)
[ 1471.412499] sd 2:0:0:0: [sda] Write Protect is off
[ 1471.412503] sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
[ 1471.413360] sd 2:0:0:0: [sda] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA


This seemed important as there is a failed operation and it looks
different then the other sets of messages

>
> I know that its a timeout(says dmesg and the wiki) issue because
> libata is probably waiting for an interrupt but doesn't get one, but
> freezing my system is not that fun, if theres any other info that I
> can provide to help me out and figure this out then let me know.
>
> -Stoyan G
>
