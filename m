From: "Raz Ben-Jehuda(caro)" <raziebe@gmail.com>
Subject: satapii vs ahci
Date: Sun, 26 Mar 2006 23:05:33 +0200
Message-ID: <5d96567b0603261305l5a745a6x786bea846e6902ed@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.229]:55381 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751547AbWCZVFg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 26 Mar 2006 16:05:36 -0500
Received: by wproxy.gmail.com with SMTP id i20so1252504wra
        for <linux-ide@vger.kernel.org>; Sun, 26 Mar 2006 13:05:33 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Hello guys.
I have been testing performance of 4 maxtor disks combined as
raid0 . the test was of reading random 1M ios all over the raid
in asynchrnous IO mode.
ahci bits satapii by 50% . while satapii gives 80MB/s ahci gives
over 120 MB/s .

Why is that ? what is the difference between the two ?

--
Raz
