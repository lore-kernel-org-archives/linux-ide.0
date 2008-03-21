From: Tejun Heo <htejun@gmail.com>
Subject: Re: Fw: 2.6.24.X: SATA/AHCI related boot delay. - not with 2.6.24.3
Date: Fri, 21 Mar 2008 11:23:50 +0900
Message-ID: <47E31C36.6060903@gmail.com>
References: <343296.8242.qm@web34508.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.172]:35493 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751547AbYCUCX6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 20 Mar 2008 22:23:58 -0400
Received: by wf-out-1314.google.com with SMTP id 28so1274064wff.4
        for <linux-ide@vger.kernel.org>; Thu, 20 Mar 2008 19:23:58 -0700 (PDT)
In-Reply-To: <343296.8242.qm@web34508.mail.mud.yahoo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: osb972ww-linuxczmil@yahoo.com
Cc: linux-kernel@vger.kernel.org, IDE/ATA development list <linux-ide@vger.kernel.org>

Hello,

osb972ww-linuxczmil@yahoo.com wrote:
>  Greetings,
>   I'm having a problem with 2.6.23.1-42 (Fedora 8) properly driving a SATA 
> drive.  Although it is detected during boot as indicated by the dmesg below, 
> once the sytstem is up and running, the drive is not accessible.   The second 
> issue is with the CFdrive on the the primary IDE.  It works, but I can't enable 
> interrupts with hdparm -u 1 /dev/sda.   
> 
>  The interesting thing is when I put in a Fedora 5 system with a 2.6.17 kernel, 
> everything works as expected.  I can hdparm -u 1 /dev/hda and it works as  expected, and
>  the SATA drive is detected and works properly all on the exact  same hardware.  
>  
>  I've tried several different SATA drives also.   Thery all work on the old 
>  Fedora 5/ 2.6.17 system, and none work on Fedora 8/2.6.23 or 2.6.24 kernels.

Does irqpoll kernel parameter help?

-- 
tejun
