From: Tejun Heo <htejun@gmail.com>
Subject: Re: Fw: 2.6.24.X: SATA/AHCI related boot delay. - not with 2.6.24.3
Date: Sat, 22 Mar 2008 17:18:40 +0900
Message-ID: <47E4C0E0.4080307@gmail.com>
References: <810485.52126.qm@web34507.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.169]:25532 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753368AbYCVISs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 22 Mar 2008 04:18:48 -0400
Received: by wf-out-1314.google.com with SMTP id 28so1964806wff.4
        for <linux-ide@vger.kernel.org>; Sat, 22 Mar 2008 01:18:48 -0700 (PDT)
In-Reply-To: <810485.52126.qm@web34507.mail.mud.yahoo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: osb972ww-linuxczmil@yahoo.com
Cc: linux-kernel@vger.kernel.org, IDE/ATA development list <linux-ide@vger.kernel.org>

Hello,

osb972ww-linuxczmil@yahoo.com wrote:
> Tejun, Alan,
> 
> Everything works when I disable the USB in the bios settings.  I was
> also able to remove the irqpoll kernel parameter after turning off
> bios USB. The particularly interesting thing is that the USB mouse
> still works, as does a USB 2.0 drive I have connected.  The Compact
> Flash drive at /dev/sda works fine, and the connected SATA drive
> works as well, though I need to do some testing to see how well these
> devices are performing.

Hmmm.. Can you please file a bug report against USB subsystem on
bugzilla.kernel.org and cc me?  USB on your system is triggering IRQ storm.

> Using the irqpoll also made things work except for once.  In that
> case, I got the same errors, delayed bootup, and missing SATA drive.

Hmmm.. Do you have logs?

> Is there a new "hdparm like" tool for working with the new
> drives/drivers to be able to read/set parameters, run various tests,
> etc?

hdparm will still be the utility of choice but libata doesn't allow many
settings IDE used to and libata probably will never implement some of
IDE's tunables.  Is there any specific setting you have in mind?

Thanks.

-- 
tejun
