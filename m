From: Tejun Heo <htejun@gmail.com>
Subject: Regarding sata_sil + seagate mod15write quirk
Date: Tue, 15 Mar 2005 05:32:02 +0900
Message-ID: <20050314203202.GA4494@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Received: from wproxy.gmail.com ([64.233.184.202]:26104 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261882AbVCNUcM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 14 Mar 2005 15:32:12 -0500
Received: by wproxy.gmail.com with SMTP id 70so1833698wra
        for <linux-ide@vger.kernel.org>; Mon, 14 Mar 2005 12:32:08 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kanniball <kanniball@zmail.pt>, David Richards <david@industrialstrengthsolutions.com>
Cc: linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>

 Hello, guys.

 As I also have two seagate drives and siimage controller, I spent
some time tinkering with those, and the benchmark result looks okay.
I'll tidy up the patch and post it tomorrow or the day after tomorrow.

 The patch makes sata_sil driver report normal max_sectors and loops
over write requests longer than 15 sectors inside sata driver.
Currently codes are sort of spread over libata core driver but I think
I can clean things up such that it uses only two additional hooks (One
will be on the issue path and the other on the completion path.  Will
it be okay, Jeff?).  So, don't go out and buy another controller just
yet. :-)

 Per-char results on P3 800 are capped by cpu.

libata-dev-2.6 original         P3 800, Sii3112 rev 02, ST3120026AS
===============================================================================
Version  1.03       ------Sequential Output------ --Sequential Input- --Random-
                    -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP
itj.dyndns.org   2G 10025  94 15399  16  6087   9 10013  87 14753  13 218.1   1
                    ------Sequential Create------ --------Random Create--------
                    -Create-- --Read--- -Delete-- -Create-- --Read--- -Delete--
              files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP
                 16   762  99 +++++ +++ +++++ +++   771  99 +++++ +++  2893 100

libata-dev-2.6 patched:         P3 800, Sii3112 rev 02, ST3120026AS
===============================================================================
Version  1.03       ------Sequential Output------ --Sequential Input- --Random-
                    -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP
itj.dyndns.org   2G 11176  98 30447  29 13527  15 12569  90 52059  30 225.6   1
                    ------Sequential Create------ --------Random Create--------
                    -Create-- --Read--- -Delete-- -Create-- --Read--- -Delete--
              files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP
                 16   811  99 +++++ +++ +++++ +++   757  99 +++++ +++  2807  99

Reference:			A64 3000+, VT6420, ST3200822AS
===============================================================================
Version  1.03       ------Sequential Output------ --Sequential Input- --Random-
                    -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP
htj.dyndns.org   2G 27375  58 30206  13 17009   6 31887  61 42512   6 210.6   0
                    ------Sequential Create------ --------Random Create--------
                    -Create-- --Read--- -Delete-- -Create-- --Read--- -Delete--
              files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP
                 16  2908  99 +++++ +++ +++++ +++  3126  99 +++++ +++  8861  99

--
tejun
