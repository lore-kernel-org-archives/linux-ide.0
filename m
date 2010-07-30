From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: SATA device powerdown
Date: Fri, 30 Jul 2010 12:12:44 -0600
Message-ID: <4C53161C.6050308@gmail.com>
References: <4C52CCCC.7010902@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:53540 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760128Ab0G3SMt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 30 Jul 2010 14:12:49 -0400
Received: by ywh1 with SMTP id 1so720656ywh.19
        for <linux-ide@vger.kernel.org>; Fri, 30 Jul 2010 11:12:48 -0700 (PDT)
In-Reply-To: <4C52CCCC.7010902@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Richard <tuxbox.guru@gmail.com>
Cc: linux-ide@vger.kernel.org

On 07/30/2010 06:59 AM, Richard wrote:
> Hi All,
>
> I have a question relating to the ATA drives and a SATA drive powerdown.
> Currently you can issue a HDD Spindown/Sleep command to a drive which
> will result in it going to sleep, but I have a hardware platform that
> requires the drive to be Powered-Off completely. (its in an extreme
> energy saving mode)
>
> Normal modes the HDD can sleep, and when any IO happens the disk wakes..
>
> I can get the HDD to power-off when it enters deep-sleep (SMART register
> reading) but how can I get the disk to re-powered before next access is
> needed. Currently the /dev/sdx deregisters when the SATA bus is
> disconnected and re-registers when the device is avaliable.
>
> Is there a method to keep the open files alive when the HDD is powered
> off and execute a custom hardware relay switch to power the HDD back up
> and continue working with the files that were open previous to the sleep?
>
> Is this at all possible?

At present I don't think this is possible. I suppose one thing you could 
do would be to hack whatever ATA driver the system was using to ignore 
all hotplug notifications, but then you'd have to make other changes to 
wake up the drive again when an access was required.

If you really need to retain apparent access to the disk when it's 
switched off, I kind of question whether the power saving from this is 
worthwhile compared to just turning on aggressive SATA link power 
management and putting the disk in standby mode..
