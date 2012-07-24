From: "Rus V. Brushkoff" <brushkoff@gmail.com>
Subject: AMD SP5100 SATA low perfomance
Date: Tue, 24 Jul 2012 21:34:57 +0300
Message-ID: <CAKu2wpS-9T+jeab4HoBozuxa-7LPVCL3+3JZok-QkTHs6CNksA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:50790 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755803Ab2GXSfj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 24 Jul 2012 14:35:39 -0400
Received: by weyx8 with SMTP id x8so5316804wey.19
        for <linux-ide@vger.kernel.org>; Tue, 24 Jul 2012 11:35:38 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello All !

 I'm observing the problem with AMD SP5100 SATA controller. The
problem appears as very low (2-3MB/s) write perfomance. Reading drops
too, but not such dramatically (from 100Mb/s on other hardware to
50-60Mb/s on SP5100). This problem is checked on several kernels
(2.6.x, 3.2.x, 3.4.x) including latest 3.5 and with all possible SATA
BIOS settings. The hardware is Tyan S8005 m/b (latest BIOS v1.03), AMD
X6 1045T, 8GB ECC memory and Hitachi HTS725050A7E630 drive.  Moreover
- I've checked 2 different identical boxes - it is 100% reproducable
on both.
 So I'm asking for help for resolving this issue. The same HDD with
another SATA controller (checked with Asus M2NPV and M5A78 m/b) shows
normal write (150Mb/s-300Mb/s) perfomance. The SMART for HDD is good,
contains no errors and passes the short test.
The http://sfinxsoft.com/tyan URL contains dmesg (dmesg-bad file) and
some screenshots. Can provide any additional info by request. It is
looks like HDD fimrware bug, but Hitachi support refused to help
saying that this is "third-party" problems and they will not support
the end users ;(

Thanks in advance

-- 
Rus
