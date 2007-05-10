From: Harald Dunkel <harald.dunkel@t-online.de>
Subject: Re: [PATCH] Re: 2.6.19.1, sata_sil: sata dvd writer doesn't work
Date: Thu, 10 May 2007 22:27:43 +0200
Message-ID: <4643803F.5040808@t-online.de>
References: <46362672.7080103@gmx.net> <4636EA85.40809@t-online.de> <46371628.9060905@gmail.com> <46379CA1.601@t-online.de> <463AEAF9.3000103@gmail.com> <463B6E3F.5000300@t-online.de> <463EFF88.7050308@gmail.com> <463F6E45.504@t-online.de> <464088BF.5070106@gmail.com> <464206DB.1010506@t-online.de> <4643176A.80809@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout02.sul.t-online.com ([194.25.134.17]:40081 "EHLO
	mailout02.sul.t-online.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756558AbXEJU1y (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 10 May 2007 16:27:54 -0400
In-Reply-To: <4643176A.80809@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, Daniel Beichl <daniel_beichl@gmx.net>

Hi Tejun,

Setting the timeout to 15 did not help, either :-(. All your patches
are still in, of course.


Regards

Harri
=======================================================================
kern.log says:

May 10 22:15:55 pluto kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
May 10 22:15:55 pluto kernel: ata2.00: cmd a0/01:00:00:00:00/00:00:00:00:00/a0 tag 0 cdb 0xad data 2052 in
May 10 22:15:55 pluto kernel:          res 40/00:02:00:08:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
May 10 22:15:55 pluto kernel: ata2: soft resetting port
May 10 22:15:55 pluto kernel: CLASSIFY TF 00/01:01:01:14:eb/a0 <6>ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
May 10 22:15:55 pluto kernel: ata2.00: XXX: IDENTIFY
May 10 22:15:55 pluto kernel: 00: 3b38 13ed f880 edbe  8013 bef8 13ed f880
May 10 22:15:55 pluto kernel: 08: edbe 8013 9ed8 33cd  d8a0 cd9e a033 9ed8
May 10 22:15:55 pluto kernel: 10: 33cd d8a0 cd9e a033  bef8 13ed f880 befc
May 10 22:15:55 pluto kernel: 18: b021 9ed8 33cd acd3  beea e37c cc88 50a9
May 10 22:15:55 pluto kernel: 20: d7c4 bbfa d733 edb0  3ebe c9b8 deff a033
May 10 22:15:55 pluto kernel: 28: 9ed8 33cd d8a0 cd9e  a033 9ed8 33cd f880
May 10 22:15:55 pluto kernel: 30: edbe 8f13 bef8 11ed  fa80 edb8 8013 bef8
May 10 22:15:55 pluto kernel: 38: 13ed f880 edbe 8013  bef8 13ed f880 edb9
May 10 22:15:55 pluto kernel: 40: 8010 be80 1395 f8f8  edc6 8013 bef8 13ed
May 10 22:15:55 pluto kernel: 48: f880 edbe 8013 bef8  15ef f880 edd6 8053
May 10 22:15:55 pluto kernel: 50: bef8 13ed f880 adbe  c013 bef8 13ed b880
May 10 22:15:55 pluto kernel: 58: e9b9 8013 bef8 13ed  f880 edbe 8013 bef8
May 10 22:15:55 pluto kernel: 60: 13ed f880 edbe 8013  bef8 13ed f880 edbe
May 10 22:15:55 pluto kernel: 68: 8013 bef8 13ed f880  edbe 8013 bef8 13ed
May 10 22:15:55 pluto kernel: 70: f880 edbe 8013 bef8  13ed f880 edbe 8013
May 10 22:15:55 pluto kernel: 78: bef8 13ed f880 edbe  8013 bef8 13ed f880
May 10 22:15:55 pluto kernel: 80: edbe 8013 bef8 13ed  f880 edbe 8013 bef8
May 10 22:15:55 pluto kernel: 88: 13ed f880 edbe 8013  bef8 13ed f880 edbe
May 10 22:15:55 pluto kernel: 90: 8013 bef8 13ed f880  edbe 8013 bef8 13ed
May 10 22:15:55 pluto kernel: 98: f880 edbe 8013 bef8  13ed f880 edbe 8013
May 10 22:15:55 pluto kernel: a0: bef8 13ed f880 edbe  8013 bef8 13ed f880
May 10 22:15:55 pluto kernel: a8: edbe 8013 bef8 13ed  f880 edbe 8013 bef8
May 10 22:15:55 pluto kernel: b0: 13ed f880 edbe 8013  bef8 13ed f880 edbe
May 10 22:15:55 pluto kernel: b8: 8013 bef8 13ed f880  edbe 8013 bef8 13ed
May 10 22:15:55 pluto kernel: c0: f880 edbe 8013 bef8  13ed f880 edbe 8013
May 10 22:15:55 pluto kernel: c8: bef8 13ed f880 edbe  8013 bef8 13ed f880
May 10 22:15:55 pluto kernel: d0: edbe 8013 bef8 13ed  f880 edbe 8013 bef8
May 10 22:15:55 pluto kernel: d8: 13ed f880 edbe 8013  bef8 13ed f880 edbe
May 10 22:15:55 pluto kernel: e0: 8013 bef8 13ed f880  edbe 8013 bef8 13ed
May 10 22:15:55 pluto kernel: e8: f880 edbe 8013 bef8  13ed f880 edbe 8013
May 10 22:15:55 pluto kernel: f0: bef8 13ed f880 edbe  8013 bef8 13ed f880
May 10 22:15:55 pluto kernel: f8: edbe 8013 bef8 13ed  f880 edbe 8013 225d
May 10 22:15:55 pluto kernel: ata2.00: failed to IDENTIFY (device reports illegal type, err_mask=0x0)
May 10 22:15:55 pluto kernel: ata2.00: revalidation failed (errno=-22)
May 10 22:15:55 pluto kernel: ata2.00: limiting speed to UDMA/33:PIO3
May 10 22:15:55 pluto kernel: ata2: failed to recover some devices, retrying in 5 secs
May 10 22:16:00 pluto kernel: ata2: hard resetting port
May 10 22:16:01 pluto kernel: CLASSIFY TF 00/01:01:01:14:eb/a0 <6>ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
May 10 22:16:01 pluto kernel: ata2.00: XXX: IDENTIFY
May 10 22:16:01 pluto kernel: 00: 85c0 0000 0000 0000  0000 0000 0000 0000
May 10 22:16:01 pluto kernel: 08: 0000 0000 2020 2020  2020 2020 2020 2020
May 10 22:16:01 pluto kernel: 10: 2020 2020 2020 2020  0000 0000 0000 5342
May 10 22:16:01 pluto kernel: 18: 3032 2020 2020 5453  5354 636f 7270 4344
May 10 22:16:01 pluto kernel: 20: 2f44 5644 5720 5348  2d53 3138 3341 2020
May 10 22:16:01 pluto kernel: 28: 2020 2020 2020 2020  2020 2020 2020 0000
May 10 22:16:01 pluto kernel: 30: 0000 0f00 0000 0200  0200 0006 0000 0000
May 10 22:16:01 pluto kernel: 38: 0000 0000 0000 0000  0000 0000 0000 0007
May 10 22:16:01 pluto kernel: 40: 0003 0078 0078 0078  0078 0000 0000 0000
May 10 22:16:01 pluto kernel: 48: 0000 0000 0000 0000  0602 0000 0068 0040
May 10 22:16:01 pluto kernel: 50: 0000 0000 0000 4000  4000 0000 0000 4000
May 10 22:16:01 pluto kernel: 58: 0407 0000 0000 0000  0000 0000 0000 0000
May 10 22:16:01 pluto kernel: 60: 0000 0000 0000 0000  0000 0000 0000 0000
May 10 22:16:01 pluto kernel: 68: 0000 0000 0000 0000  0000 0000 0000 0000
May 10 22:16:01 pluto kernel: 70: 0000 0000 0000 0000  0000 0000 0000 0000
May 10 22:16:01 pluto kernel: 78: 0000 0000 0000 0000  0000 0000 0000 0000
May 10 22:16:01 pluto kernel: 80: 0000 0000 0000 0000  0000 0000 0000 0000
May 10 22:16:01 pluto kernel: 88: 0000 0000 0000 0000  0000 0000 0000 0000
May 10 22:16:01 pluto kernel: 90: 0000 0000 0000 0000  0000 0000 0000 0000
May 10 22:16:01 pluto kernel: 98: 0000 0000 0000 0000  0000 0000 0000 0000
May 10 22:16:01 pluto kernel: a0: 0000 0000 0000 0000  0000 0000 0000 0000
May 10 22:16:01 pluto kernel: a8: 0000 0000 0000 0000  0000 0000 0000 0000
May 10 22:16:01 pluto kernel: b0: 0000 0000 0000 0000  0000 0000 0000 0000
May 10 22:16:01 pluto kernel: b8: 0000 0000 0000 0000  0000 0000 0000 0000
May 10 22:16:01 pluto kernel: c0: 0000 0000 0000 0000  0000 0000 0000 0000
May 10 22:16:01 pluto kernel: c8: 0000 0000 0000 0000  0000 0000 0000 0000
May 10 22:16:01 pluto kernel: d0: 0000 0000 0000 0000  0000 0000 0000 0000
May 10 22:16:01 pluto kernel: d8: 0000 0000 0000 0000  0000 0000 0000 0000
May 10 22:16:01 pluto kernel: e0: 0000 0000 0000 0000  0000 0000 0000 0000
May 10 22:16:01 pluto kernel: e8: 0000 0000 0000 0000  0000 0000 0000 0000
May 10 22:16:01 pluto kernel: f0: 0000 0000 0000 0000  0000 0000 0000 0000
May 10 22:16:01 pluto kernel: f8: 0000 0000 0000 0000  0000 0000 0000 9ca5
May 10 22:16:01 pluto kernel: ata2.00: configured for UDMA/33
May 10 22:16:01 pluto kernel: ata2: EH complete

