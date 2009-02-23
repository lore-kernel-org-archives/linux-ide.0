From: Tomasz Chmielewski <mangoo@wpkg.org>
Subject: strange hdparm results with serverworks and pata-serverworks
Date: Mon, 23 Feb 2009 21:37:21 +0100
Message-ID: <49A30901.1@wpkg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx03.syneticon.net ([78.111.66.105]:46278 "EHLO
	mx03.syneticon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751066AbZBWUhG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 23 Feb 2009 15:37:06 -0500
Received: from localhost (filter1.syneticon.net [192.168.113.83])
	by mx03.syneticon.net (Postfix) with ESMTP id B5A3035E1C
	for <linux-ide@vger.kernel.org>; Mon, 23 Feb 2009 21:37:03 +0100 (CET)
Received: from mx03.syneticon.net ([192.168.113.84])
	by localhost (mx03.syneticon.net [192.168.113.83]) (amavisd-new, port 10025)
	with ESMTP id 3ui8GG8KRZNu for <linux-ide@vger.kernel.org>;
	Mon, 23 Feb 2009 21:37:01 +0100 (CET)
Received: from [192.168.10.145] (koln-4db48cd5.pool.einsundeins.de [77.180.140.213])
	by mx03.syneticon.net (Postfix) with ESMTPSA
	for <linux-ide@vger.kernel.org>; Mon, 23 Feb 2009 21:37:01 +0100 (CET)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I have a ProLiant BL30p G1 machine running Debian Lenny (2.6.26 kernel).

It also has two identical, 2.5 inch WDC WD2500BEVE-00WZT0 IDE drives 
(new drives, no smart/badblock errors). Both drives are connected to a 
single IDE channel this machine has.

"hdparm -t" gives me different results for these drives: ~10 MB/s for 
hda, and ~20 MB/s for hdb with "serverworks" driver on Debian's 2.6.26 
kernel.
When using "pata-serverworks" with 2.6.28.7 kernel, hdparm shows the 
same results (~10 MB/s for sda, ~20 MB/s for sdb).


However, when I run "dd if=/dev/sda of=/dev/null bs=64k", I can see with 
iostat that for the first 7-8 seconds, reads are with ~10 MB/s speed. 
Then, reads from sda are with ~20 MB/s or more and are on par with sdb.

Similar dd test for sdb shows that it delivers with speed of ~20 MB/s 
from the first second.

Is there an explanation for that?


-- 
Tomasz Chmielewski
http://wpkg.org
