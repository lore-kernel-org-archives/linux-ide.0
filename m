From: "Al Boldi" <a1426z@gawab.com>
Subject: RE: Organized summary of the pacthes
Date: Thu, 30 Jun 2005 15:45:45 +0300
Message-ID: <200506301246.PAA29456@raad.intranet>
References: <42C3B0B1.6090001@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [212.76.81.127] ([212.76.81.127]:48900 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S262820AbVF3N5T (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 30 Jun 2005 09:57:19 -0400
In-Reply-To: <42C3B0B1.6090001@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: 'Albert Lee' <albertcc@tw.ibm.com>, 'Jeff Garzik' <jgarzik@pobox.com>
Cc: doug_maxey@us.ibm.com, linux-ide@vger.kernel.org, 'Bartlomiej Zolnierkiewicz' <B.Zolnierkiewicz@elka.pw.edu.pl>, 'Alan Cox' <alan@lxorguk.ukuu.org.uk>, 'Tejun Heo' <htejun@gmail.com>, 'Benjamin Herrenschmidt' <benh@kernel.crashing.org>

By the way,
Why is the ide-driver in so slow?
Hdparm -tT gives 28mb/s in 2.6.12 
Cat /dev/hda > /dev/null gives 2% user 25% sys 0% idle 73% IOWAIT

Hdparm -tT gives 38mb/s in 2.4.31
Cat /dev/hda > /dev/null gives 2% user 33% sys 65% idle

It feels like DMA is not being applied properly in 2.6.12.

Your comments please.

Thanks!

