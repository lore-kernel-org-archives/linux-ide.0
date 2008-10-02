From: Damazy <damazy@gmail.com>
Subject: sata_sil for 3512A chip on kernel 2.6.26.3
Date: Thu, 02 Oct 2008 10:53:06 +0200
Message-ID: <48E48BF2.1010403@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:39447 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753030AbYJBIwZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 2 Oct 2008 04:52:25 -0400
Received: by fg-out-1718.google.com with SMTP id 19so682624fgg.17
        for <linux-ide@vger.kernel.org>; Thu, 02 Oct 2008 01:52:23 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

Hi.
 I have big problem working with sata_sil.
If I plugin SAMSUNG HD502IJ to one of 3512A and try to copy anything 
from that drive to the same one big partition is always hard resetting 
link and stops responds for 5 sec.

first is always timeout
status DRDY
hard resetting link

next some times drive error or HSM violation

I know that drive is good because I'v check it in diffrent hardware and os.

I'v test my config with WD800 and its work perfect.
What can I do with that?
What more information I must send to proper diagnose the problem?
I'v read lots of information on web, but nothing helps at all.
The only way to stops this problem is disable DMA with libata.dma=0 but 
performance of this solution unacceptable.

I'll be very thanfull for any help.

-- 
 Kind regards.
Damazy
