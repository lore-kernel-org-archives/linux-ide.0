From: =?UTF-8?B?SMOla29uIEzDuHZkYWw=?= <hlovdal@gmail.com>
Subject: Re: "raid5:md0: read error not correctable (sector 795463080 on
	sdf1)" error on controller with SIL 3114
Date: Sat, 20 Feb 2010 14:05:59 +0100
Message-ID: <a01a16b51002200505v2b4ef73alefe368401523f592@mail.gmail.com>
References: <a01a16b51002080311i420f6429ld3545c44c04603eb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f219.google.com ([209.85.220.219]:58974 "EHLO
	mail-fx0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754857Ab0BTNGB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 20 Feb 2010 08:06:01 -0500
Received: by fxm19 with SMTP id 19so975683fxm.21
        for <linux-ide@vger.kernel.org>; Sat, 20 Feb 2010 05:05:59 -0800 (PST)
In-Reply-To: <a01a16b51002080311i420f6429ld3545c44c04603eb@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

On 8 February 2010 12:11, H=C3=A5kon L=C3=B8vdal <hlovdal@gmail.com> wr=
ote:
> While I have not tested this time, I have previously when getting sim=
ilar
> errors run spinrite (http://www.grc.com/sr/spinrite.htm) on the disks
> without finding any problems. So I do believe that this is not disk e=
rrors.
>
> The machine is running Fedora 10 with kernel 2.6.27.41-170.2.117.fc10=
=2Ex86_64,
> mdadm updated to the latest 3.0.3 release from Fedora 12.
>
> Unfortunately I have too little time to do any thorough investigation
> on this. My plan is to upgrade to Fedora 12 and maybe build some late=
st
> kernel to see if that makes any difference, and if not (or probably i=
n
> any case) swap out the 3114 card with a Promise TX4 card instead.

Update: Seems to be disk error after all. I changed to Promise TX4
and updated to Fedora 12. Rebuilding the raid went ok, but then the
following day the following occurred:

=46eb 19 09:54:30 localhost kernel: ata8.00: exception Emask 0x0 SAct
0x0 SErr 0x0 action 0x0
=46eb 19 09:54:30 localhost kernel: ata8.00: port_status 0x20200000
=46eb 19 09:54:30 localhost kernel: ata8.00: cmd
25/00:00:30:cc:69/00:03:2f:00:00/e0 tag 0 dma 393216 in
=46eb 19 09:54:30 localhost kernel:         res
51/40:00:e4:cd:69/40:00:2f:00:00/e0 Emask 0x9 (media error)
=46eb 19 09:54:30 localhost kernel: ata8.00: status: { DRDY ERR }
=46eb 19 09:54:30 localhost kernel: ata8.00: error: { UNC }
=46eb 19 09:54:31 localhost kernel: ata8.00: configured for UDMA/133
=46eb 19 09:54:31 localhost kernel: ata8: EH complete
=46eb 19 09:54:32 localhost kernel: ata8.00: exception Emask 0x0 SAct
0x0 SErr 0x0 action 0x0
=46eb 19 09:54:32 localhost kernel: ata8.00: port_status 0x20200000
=46eb 19 09:54:32 localhost kernel: ata8.00: cmd
25/00:00:30:cc:69/00:03:2f:00:00/e0 tag 0 dma 393216 in
=46eb 19 09:54:32 localhost kernel:         res
51/40:00:e4:cd:69/40:00:2f:00:00/e0 Emask 0x9 (media error)
=46eb 19 09:54:32 localhost kernel: ata8.00: status: { DRDY ERR }
=46eb 19 09:54:32 localhost kernel: ata8.00: error: { UNC }
=46eb 19 09:54:33 localhost kernel: ata8.00: configured for UDMA/133
=46eb 19 09:54:33 localhost kernel: ata8: EH complete
=46eb 19 09:54:34 localhost kernel: ata8.00: exception Emask 0x0 SAct
0x0 SErr 0x0 action 0x0
=46eb 19 09:54:34 localhost kernel: ata8.00: port_status 0x20200000
=46eb 19 09:54:34 localhost kernel: ata8.00: cmd
25/00:00:30:cc:69/00:03:2f:00:00/e0 tag 0 dma 393216 in
=46eb 19 09:54:34 localhost kernel:         res
51/40:00:e4:cd:69/40:00:2f:00:00/e0 Emask 0x9 (media error)
=46eb 19 09:54:34 localhost kernel: ata8.00: status: { DRDY ERR }
=46eb 19 09:54:34 localhost kernel: ata8.00: error: { UNC }
=46eb 19 09:54:35 localhost kernel: ata8.00: configured for UDMA/133
=46eb 19 09:54:35 localhost kernel: ata8: EH complete
=46eb 19 09:54:36 localhost kernel: ata8.00: exception Emask 0x0 SAct
0x0 SErr 0x0 action 0x0
=46eb 19 09:54:36 localhost kernel: ata8.00: port_status 0x20200000
=46eb 19 09:54:36 localhost kernel: ata8.00: cmd
25/00:00:30:cc:69/00:03:2f:00:00/e0 tag 0 dma 393216 in
=46eb 19 09:54:36 localhost kernel:         res
51/40:00:e4:cd:69/40:00:2f:00:00/e0 Emask 0x9 (media error)
=46eb 19 09:54:36 localhost kernel: ata8.00: status: { DRDY ERR }
=46eb 19 09:54:36 localhost kernel: ata8.00: error: { UNC }
=46eb 19 09:54:37 localhost kernel: ata8.00: configured for UDMA/133
=46eb 19 09:54:37 localhost kernel: ata8: EH complete
=46eb 19 09:54:38 localhost kernel: ata8.00: exception Emask 0x0 SAct
0x0 SErr 0x0 action 0x0
=46eb 19 09:54:38 localhost kernel: ata8.00: port_status 0x20200000
=46eb 19 09:54:38 localhost kernel: ata8.00: cmd
25/00:00:30:cc:69/00:03:2f:00:00/e0 tag 0 dma 393216 in
=46eb 19 09:54:38 localhost kernel:         res
51/40:00:e4:cd:69/40:00:2f:00:00/e0 Emask 0x9 (media error)
=46eb 19 09:54:38 localhost kernel: ata8.00: status: { DRDY ERR }
=46eb 19 09:54:38 localhost kernel: ata8.00: error: { UNC }
=46eb 19 09:54:39 localhost kernel: ata8.00: configured for UDMA/133
=46eb 19 09:54:39 localhost kernel: ata8: EH complete
=46eb 19 09:54:40 localhost kernel: ata8.00: exception Emask 0x0 SAct
0x0 SErr 0x0 action 0x0
=46eb 19 09:54:40 localhost kernel: ata8.00: port_status 0x20200000
=46eb 19 09:54:40 localhost kernel: ata8.00: cmd
25/00:00:30:cc:69/00:03:2f:00:00/e0 tag 0 dma 393216 in
=46eb 19 09:54:40 localhost kernel:         res
51/40:00:e4:cd:69/40:00:2f:00:00/e0 Emask 0x9 (media error)
=46eb 19 09:54:40 localhost kernel: ata8.00: status: { DRDY ERR }
=46eb 19 09:54:40 localhost kernel: ata8.00: error: { UNC }
=46eb 19 09:54:41 localhost kernel: ata8.00: configured for UDMA/133
=46eb 19 09:54:41 localhost kernel: sd 7:0:0:0: [sdf] Unhandled sense c=
ode
=46eb 19 09:54:41 localhost kernel: sd 7:0:0:0: [sdf] Result:
hostbyte=3DDID_OK driverbyte=3DDRIVER_SENSE
=46eb 19 09:54:41 localhost kernel: sd 7:0:0:0: [sdf] Sense Key : Mediu=
m
Error [current] [descriptor]
=46eb 19 09:54:41 localhost kernel: Descriptor sense data with sense
descriptors (in hex):
=46eb 19 09:54:41 localhost kernel:        72 03 11 04 00 00 00 0c 00 0=
a
80 00 00 00 00 00
=46eb 19 09:54:41 localhost kernel:        2f 69 cd e4
=46eb 19 09:54:41 localhost kernel: sd 7:0:0:0: [sdf] Add. Sense:
Unrecovered read error - auto reallocate failed
=46eb 19 09:54:41 localhost kernel: end_request: I/O error, dev sdf,
sector 795463140
=46eb 19 09:54:41 localhost kernel: ata8: EH complete
=46eb 19 09:54:43 localhost kernel: ata8.00: exception Emask 0x0 SAct
0x0 SErr 0x0 action 0x0
=46eb 19 09:54:43 localhost kernel: ata8.00: port_status 0x20200000
=46eb 19 09:54:43 localhost kernel: ata8.00: cmd
25/00:e0:30:cf:69/00:00:2f:00:00/e0 tag 0 dma 114688 in
=46eb 19 09:54:43 localhost kernel:         res
51/40:00:36:cf:69/40:00:2f:00:00/e0 Emask 0x9 (media error)
=46eb 19 09:54:43 localhost kernel: ata8.00: status: { DRDY ERR }
=46eb 19 09:54:43 localhost kernel: ata8.00: error: { UNC }
=46eb 19 09:54:44 localhost kernel: ata8.00: configured for UDMA/133
=46eb 19 09:54:44 localhost kernel: ata8: EH complete
=46eb 19 09:54:45 localhost kernel: ata8.00: exception Emask 0x0 SAct
0x0 SErr 0x0 action 0x0
=46eb 19 09:54:45 localhost kernel: ata8.00: port_status 0x20200000
=46eb 19 09:54:45 localhost kernel: ata8.00: cmd
25/00:e0:30:cf:69/00:00:2f:00:00/e0 tag 0 dma 114688 in
=46eb 19 09:54:45 localhost kernel:         res
51/40:00:36:cf:69/40:00:2f:00:00/e0 Emask 0x9 (media error)
=46eb 19 09:54:45 localhost kernel: ata8.00: status: { DRDY ERR }
=46eb 19 09:54:45 localhost kernel: ata8.00: error: { UNC }
=46eb 19 09:54:46 localhost kernel: ata8.00: configured for UDMA/133
=46eb 19 09:54:46 localhost kernel: ata8: EH complete
=46eb 19 09:54:47 localhost kernel: ata8.00: exception Emask 0x0 SAct
0x0 SErr 0x0 action 0x0
=46eb 19 09:54:47 localhost kernel: ata8.00: port_status 0x20200000
=46eb 19 09:54:47 localhost kernel: ata8.00: cmd
25/00:e0:30:cf:69/00:00:2f:00:00/e0 tag 0 dma 114688 in
=46eb 19 09:54:47 localhost kernel:         res
51/40:00:36:cf:69/40:00:2f:00:00/e0 Emask 0x9 (media error)
=46eb 19 09:54:47 localhost kernel: ata8.00: status: { DRDY ERR }
=46eb 19 09:54:47 localhost kernel: ata8.00: error: { UNC }
=46eb 19 09:54:48 localhost kernel: ata8.00: configured for UDMA/133
=46eb 19 09:54:48 localhost kernel: ata8: EH complete
=46eb 19 09:54:49 localhost kernel: ata8.00: exception Emask 0x0 SAct
0x0 SErr 0x0 action 0x0
=46eb 19 09:54:49 localhost kernel: ata8.00: port_status 0x20200000
=46eb 19 09:54:49 localhost kernel: ata8.00: cmd
25/00:e0:30:cf:69/00:00:2f:00:00/e0 tag 0 dma 114688 in
=46eb 19 09:54:49 localhost kernel:         res
51/40:00:36:cf:69/40:00:2f:00:00/e0 Emask 0x9 (media error)
=46eb 19 09:54:49 localhost kernel: ata8.00: status: { DRDY ERR }
=46eb 19 09:54:49 localhost kernel: ata8.00: error: { UNC }
=46eb 19 09:54:50 localhost kernel: ata8.00: configured for UDMA/133
=46eb 19 09:54:50 localhost kernel: ata8: EH complete
=46eb 19 09:54:51 localhost kernel: ata8.00: exception Emask 0x0 SAct
0x0 SErr 0x0 action 0x0
=46eb 19 09:54:51 localhost kernel: ata8.00: port_status 0x20200000
=46eb 19 09:54:51 localhost kernel: ata8.00: cmd
25/00:e0:30:cf:69/00:00:2f:00:00/e0 tag 0 dma 114688 in
=46eb 19 09:54:51 localhost kernel:         res
51/40:00:36:cf:69/40:00:2f:00:00/e0 Emask 0x9 (media error)
=46eb 19 09:54:51 localhost kernel: ata8.00: status: { DRDY ERR }
=46eb 19 09:54:51 localhost kernel: ata8.00: error: { UNC }
=46eb 19 09:54:52 localhost kernel: ata8.00: configured for UDMA/133
=46eb 19 09:54:52 localhost kernel: ata8: EH complete
=46eb 19 09:54:53 localhost kernel: ata8.00: exception Emask 0x0 SAct
0x0 SErr 0x0 action 0x0
=46eb 19 09:54:53 localhost kernel: ata8.00: port_status 0x20200000
=46eb 19 09:54:53 localhost kernel: ata8.00: cmd
25/00:e0:30:cf:69/00:00:2f:00:00/e0 tag 0 dma 114688 in
=46eb 19 09:54:53 localhost kernel:         res
51/40:00:36:cf:69/40:00:2f:00:00/e0 Emask 0x9 (media error)
=46eb 19 09:54:53 localhost kernel: ata8.00: status: { DRDY ERR }
=46eb 19 09:54:53 localhost kernel: ata8.00: error: { UNC }
=46eb 19 09:54:54 localhost kernel: ata8.00: configured for UDMA/133
=46eb 19 09:54:54 localhost kernel: sd 7:0:0:0: [sdf] Unhandled sense c=
ode
=46eb 19 09:54:54 localhost kernel: sd 7:0:0:0: [sdf] Result:
hostbyte=3DDID_OK driverbyte=3DDRIVER_SENSE
=46eb 19 09:54:54 localhost kernel: sd 7:0:0:0: [sdf] Sense Key : Mediu=
m
Error [current] [descriptor]
=46eb 19 09:54:54 localhost kernel: Descriptor sense data with sense
descriptors (in hex):
=46eb 19 09:54:54 localhost kernel:        72 03 11 04 00 00 00 0c 00 0=
a
80 00 00 00 00 00
=46eb 19 09:54:54 localhost kernel:        2f 69 cf 36
=46eb 19 09:54:54 localhost kernel: sd 7:0:0:0: [sdf] Add. Sense:
Unrecovered read error - auto reallocate failed
=46eb 19 09:54:54 localhost kernel: end_request: I/O error, dev sdf,
sector 795463478
=46eb 19 09:54:54 localhost kernel: ata8: EH complete
=46eb 19 09:54:54 localhost kernel: raid5:md0: read error corrected (8
sectors at 795461088 on sdf1)
=46eb 19 09:54:54 localhost kernel: raid5:md0: read error corrected (8
sectors at 795461096 on sdf1)
=46eb 19 09:54:54 localhost kernel: raid5:md0: read error corrected (8
sectors at 795461104 on sdf1)
=46eb 19 09:54:54 localhost kernel: raid5:md0: read error corrected (8
sectors at 795461112 on sdf1)
=46eb 19 09:54:54 localhost kernel: raid5:md0: read error corrected (8
sectors at 795461120 on sdf1)
=46eb 19 09:54:54 localhost kernel: raid5:md0: read error corrected (8
sectors at 795461128 on sdf1)
=46eb 19 09:54:54 localhost kernel: raid5:md0: read error corrected (8
sectors at 795461136 on sdf1)
=46eb 19 09:54:54 localhost kernel: raid5:md0: read error corrected (8
sectors at 795461144 on sdf1)
=46eb 19 09:54:54 localhost kernel: raid5:md0: read error corrected (8
sectors at 795461152 on sdf1)
=46eb 19 09:54:54 localhost kernel: raid5:md0: read error corrected (8
sectors at 795461160 on sdf1)

A new disk is ordered to replace sdf.

BR H=C3=A5kon L=C3=B8vdal
