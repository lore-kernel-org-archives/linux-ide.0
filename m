From: maximilian attems <debian@sternwelten.at>
Subject: (fwd) Re: Bug#289770: kernel-image-2.6.10-1-686: 2.6.10 fails to set up DMA on my IBM thinkpad
Date: Tue, 11 Jan 2005 20:53:45 +0100
Message-ID: <20050111195345.GI2618@stro.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from baikonur.stro.at ([213.239.196.228]:47748 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S261618AbVAKTxr
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 11 Jan 2005 14:53:47 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, 289770@bugs.debian.org, Philip Armstrong <phil@kantaka.co.uk>


dma on a thinkpad  600E worked for 2.6.8, but didn't since 2.6.9
also non working 2.6.10.

-hda: 12594960 sectors (6448 MB) w/460KiB Cache, CHS=13328/15/63, UDMA(33)
+hda: 12594960 sectors (6448 MB) w/460KiB Cache, CHS=13328/15/63

could you please look at the following ide dma bug report for piix in
debian -> http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=289770
full dmesg of both 2.6.8 and 2.6.10 are posted there.

thanks maks

