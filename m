From: Pat LaVarre <p.lavarre@ieee.org>
Subject: patapi bus traces - dmadir awareness absent
Date: 25 May 2004 17:52:57 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1085529177.3157.4.camel@patibmrh9>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from email-out2.iomega.com ([147.178.1.83]:4349 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S265243AbUEYXxD
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 25 May 2004 19:53:03 -0400
Received: from royntex01.iomegacorp.com (franklin [10.1.1.83])
	by email.iomega.com (Postfix) with ESMTP id B4EA916AF
	for <linux-ide@vger.kernel.org>; Tue, 25 May 2004 17:53:02 -0600 (MDT)
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I have acquired a PATAPI trace of a SATAPI Si 3611 r1.4 hanging when
told x01 Dma Out rather than x05 Dma In for op x12 "INQUIRY".

But I'm vague on the relevant netiquette.  I don't myself have a good
place to put this on the web, yet I wonder if 21874 bytes is enough of
an attachment to annoy people here.

Pat LaVarre

$
$ ls -l dmadir*
-rw-rw-r--    1 pat      pat         21874 May 25 17:48 dmadir.tgz
 
dmadir:
total 392
-rw-rw-r--    1 pat      pat         35464 May 25 17:47 dmadir.bin
-rw-rw-r--    1 pat      pat        360037 May 25 17:47 dmadir.txt
$


