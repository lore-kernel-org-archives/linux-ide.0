From: Richard Scobie <r.scobie@clear.net.nz>
Subject: SAS v SATA interface performance
Date: Sat, 01 Dec 2007 08:19:19 +1300
Message-ID: <47506237.3000406@clear.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.sauce.co.nz ([210.48.49.72]:47000 "EHLO smtp.sauce.co.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754902AbXK3T1P (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 30 Nov 2007 14:27:15 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

If one disregards the rotational speed and access time advantage that 
SAS drives have over SATA, does the SAS interface offer any performance 
advantage?

For example, assume a SAS drive and a SATA drive can both sustained 
stream 70MB/s. A 16 drive JBOD SAS enclosure with internal SAS expander 
is connected via a 4port SAS RAID controller, configured for RAID 5 
across all 16 drives.

If tests are then run reading and writing a multi gigabyte file to empty 
arrays made up of 16 SAS drives and 16 SATA drives, would the results be 
identical?

I ask, as I have seen a comment to the effect that SATA drives are less 
efficient interacting at the bus/interface level in this situation, but 
I have had no luck confirming this after extensive searching.

Regards,

Richard
