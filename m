From: Richard <tuxbox.guru@gmail.com>
Subject: SATA device powerdown
Date: Fri, 30 Jul 2010 13:59:56 +0100
Message-ID: <4C52CCCC.7010902@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:63092 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756667Ab0G3NAA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 30 Jul 2010 09:00:00 -0400
Received: by wyb39 with SMTP id 39so1108384wyb.19
        for <linux-ide@vger.kernel.org>; Fri, 30 Jul 2010 05:59:58 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi All,

I have a question relating to the ATA drives and a SATA drive powerdown. 
Currently you can issue a HDD Spindown/Sleep command to a drive which 
will result in it going to sleep, but I have a hardware platform that 
requires the drive to be Powered-Off completely. (its in an extreme 
energy saving mode)

Normal modes the HDD can sleep, and when any IO happens the disk wakes..

I can get the HDD to power-off when it enters deep-sleep (SMART register 
reading) but how can I get the disk to re-powered before next access is 
needed. Currently the /dev/sdx deregisters when the SATA bus is 
disconnected and re-registers when the device is avaliable.

Is there a method to keep the open files alive when the HDD is powered 
off and execute a custom hardware relay switch to power the HDD back up 
and continue working with the files that were open previous to the sleep?

Is this at all possible?

Best Regards
Richard


