From: Matt Darcy <kernel-lists@projecthugo.co.uk>
Subject: 2.6.15-rc5 mm3 V mm5
Date: Wed, 21 Dec 2005 14:58:48 +0000
Message-ID: <43A96DA8.8080001@projecthugo.co.uk>
Reply-To: kernel-lists@projecthugo.co.uk
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.ifl.net ([213.18.248.104]:24042 "EHLO mx1.ifl.net")
	by vger.kernel.org with ESMTP id S932439AbVLUO7C (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 21 Dec 2005 09:59:02 -0500
Received: from [127.0.0.1] (beng-03.stn.ab2.ifl.net [194.238.49.3])
	by mx1.ifl.net (8.12.10/8.12.10) with ESMTP id jBLEwm2Y024778
	for <linux-ide@vger.kernel.org>; Wed, 21 Dec 2005 14:58:51 GMT
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

hi all,

is there anything that anyone would consider "key" to the stability of 
the sata_mv or the libata interaction that has been changed between mm1 
and mm3

I had terrible usablility and stability using 2.6.15-mm1 with the 
sata_mv driver using raid/lvm2, yet in 2.6.15-rc5-mm3 the box has been 
up 2 days with a raid 5 array in lvm2 with multiple lvm's hanging off 
it. Performance seems good and read/writes seem to be fine, no 
corruption yet.

I'm looking through the patches now, and although there does appear to 
be libata changes, I can't see anything directly related to the sata_mv 
driver, or to anything between libata/sata_mv that would effect 
usability this much.

thanks,

Matt.


