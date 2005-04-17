From: Ludwig Meyerhoff <ludwig@antar.de>
Subject: VT8237 SATA + RAID
Date: Sun, 17 Apr 2005 12:19:58 +0200
Message-ID: <4262384E.2090607@antar.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ant6.hh.gtn.com ([194.77.162.158]:53472 "EHLO srv.antar.de")
	by vger.kernel.org with ESMTP id S261247AbVDQKVf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 17 Apr 2005 06:21:35 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org

Hallo!

I wanted to install a new low-usage linux-server, so I bought a 
mainboard with a SATA RAID controller (VT8237) onboard.

I know there are better solutions like RAID controllers with their own 
microcontrollers, but as I only wanted to mirror the data, a "BIOS RAID" 
should do, too.

So I have two 250GB SATA drives, a configured RAID and a Debian 
Netinstall CD (2.6.8-10 kernel). My problem is the "sata_via" module 
loads but does not recognize the RAID function, as instead of one drive 
it finds two.

Googling around I found many people sharing my problem but no one having 
a solution which does not consist of a software-raid managed by the 
kernel (I had some trouble with it when one of the two disks (RAID 1) 
crashed - all data lost).


There seems to be a driver at viaarena.com, but it looks like if it were 
only for 2.4 kernel.



To me it looks like if the sata_via driver lacks the BIOS support, so I 
ask You whether this is the case and what I can do.



Saluti!

Ludwig Meyerhoff

P.s.: I did not subscribe to the list, so please do not forget to cc me 
in replies!
