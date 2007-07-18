From: Tejun Heo <htejun@gmail.com>
Subject: Re: ALi SATA problem
Date: Wed, 18 Jul 2007 18:45:46 +0900
Message-ID: <469DE14A.60101@gmail.com>
References: <200707181117.41129.pavel@netsafe.cz> <469DDEC4.6080908@gmail.com> <200707181138.01161.pavel@netsafe.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.185]:19009 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751848AbXGRJpv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Jul 2007 05:45:51 -0400
Received: by rv-out-0910.google.com with SMTP id k20so3255rvb
        for <linux-ide@vger.kernel.org>; Wed, 18 Jul 2007 02:45:51 -0700 (PDT)
In-Reply-To: <200707181138.01161.pavel@netsafe.cz>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Pavel Mateja <pavel@netsafe.cz>
Cc: linux-ide@vger.kernel.org

Pavel Mateja wrote:
> Dne Wednesday 18 of July 2007 11:35:00 jste napsal(a):
>> Pavel Mateja wrote:
>>> ata2: exception Emask 0x10 SAct 0x0 SErr 0x4060000 action 0x2 frozen
>>> ata2: (irq_stat 0x00000040, connection status changed)
>>> ata4: exception Emask 0x10 SAct 0x0 SErr 0x4060000 action 0x2 frozen
>>> ata4: (irq_stat 0x00000040, connection status changed)
>>> ata2: soft resetting port
>> Please check power supply and re-cable things.
> 
> Funny thing is there are no cables to be checked. Nothing is connected to 
> those ports. Just ata1 is occupied by disk.

Sigh... The controller is telling the driver that "there's something
going on this port (hotplug event), please take look".  Can you try
hotplug some device at those ports and report the resulting kernel log?

-- 
tejun
