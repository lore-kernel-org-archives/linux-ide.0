From: "Ulli.Brennenstuhl" <Ulli.Brennenstuhl@fs.ei.tum.de>
Subject: Re: Corrupt data - RAID sata_sil 3114 chip
Date: Fri, 29 Jan 2010 17:13:08 +0100
Message-ID: <4B630914.9010503@fs.ei.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from stella.fs.ei.tum.de ([129.187.54.7]:43458 "EHLO
	stella.fs.ei.tum.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752088Ab0A2Qq4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 29 Jan 2010 11:46:56 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.fs.ei.tum.de (Postfix) with ESMTP id AFAB01C36A
	for <linux-ide@vger.kernel.org>; Fri, 29 Jan 2010 17:13:08 +0100 (CET)
Received: from stella.fs.ei.tum.de ([127.0.0.1])
	by localhost (stella.fs.ei.tum.de [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id rRPDX9zMxXmv for <linux-ide@vger.kernel.org>;
	Fri, 29 Jan 2010 17:13:08 +0100 (CET)
Received: from [192.168.113.68] (dick.fs.ei.tum.de [192.168.113.68])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by stella.fs.ei.tum.de (Postfix) with ESMTP id 784E31C35D
	for <linux-ide@vger.kernel.org>; Fri, 29 Jan 2010 17:13:08 +0100 (CET)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

The last message of this discussion is more than one year old, but still 
there was no solution to this problem.

I recently encountered the same problem that a raid created with mdadm 
consisting of three SAMSUNG HD154UI sata harddisks had random errors and 
mdadm --examine would randomly report that checksums are wrong/correct.

The sata controller with the SIL 3114 chipset runs on an old Epox 8K3A 
board with a VIA KT133 chipset. I noticed that placing the controller in 
another pci slot would change the results of mdadm --examine.
While in one slot it was the checksums were randomly changing between 
correct and wrong in another slot it was always displayed as wrong.

After deactivating every single bios option that somehow optimizes the 
pci bus the problem seems to be gone. After some more testing I could 
narrow the problem down to the option "PCI Master 0 WS Write", which 
controls if requests to the pci bus are executed immediately (with zero 
wait states) or if every write request will be delayed by one wait state.

Obviously this reduces the performance. I didn't perform tests but the 
resync speed of the raid dropped from ~ 28mb/s to ~ 17mb/s.

I hope this also solves the problems for other people and it would be 
interesting if any change to the driver would allow to reenable the "PCI 
Master 0 WS Write" option.


Regards,
Ulli Brennenstuhl

