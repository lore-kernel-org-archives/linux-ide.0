From: Alexander Wigen <alex@wigen.net>
Subject: sata_sil driver crashes when not used as a module
Date: Mon, 27 Jun 2005 19:40:53 +1000
Message-ID: <200506271940.54019.alex@wigen.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from asav1.lyse.net ([213.167.96.68]:47754 "EHLO asav1.lyse.net")
	by vger.kernel.org with ESMTP id S261990AbVF0JlA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 27 Jun 2005 05:41:00 -0400
Received: from asav1.lyse.net (asav1.lyse.net [127.0.0.1])
	by localhost.lyse.net (Postfix) with ESMTP id 3CF75902C7
	for <linux-ide@vger.kernel.org>; Mon, 27 Jun 2005 11:35:55 +0200 (CEST)
Received: from mail1.lyse.net (unknown [192.168.42.2])by asav1.lyse.net
	(Postfix) with ESMTP id 24E1E90287for <linux-ide@vger.kernel.org>; Mon, 27
	Jun 2005 11:35:55 +0200 (CEST)
Received: from [84.234.148.2] (helo=wigen.net)by mail1.lyse.net with smtp
	(Exim 4.34)id 1Dmq5r-000184-2Ffor linux-ide@vger.kernel.org; Mon, 27 Jun
	2005 11:39:55 +0200
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Hi Jeff,

I am experiencing an oops with the sata_sil driver. The oops happens on boot 
with the driver compiled into the kernel. The driver works fine when compiled 
as a module though.

I don't know how to get a copy of the call trace, I could take a picture of 
the screen and post that if you like?

I'm using a vanilla 2.6.12 kernel. The sil card is a STLab A-180 2-Port "raid" 
card.
lspci: 0000:01:09.0 RAID bus controller: Silicon Image, Inc. SiI 3112 
[SATALink/SATARaid] Serial ATA Controller (rev 02)


Cheers
Alex
-- 
My page: http://wigen.net                 E-Mail: alex@wigen.net
Patience is a virtue, but persistence to the point of success is a blessing
