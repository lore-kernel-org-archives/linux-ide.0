From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata_via
Date: Sun, 13 Apr 2008 11:45:31 +0900
Message-ID: <480173CB.5070805@gmail.com>
References: <47F694C8.8020507@wesmo.com> <47F6A5E8.1030602@garzik.org>	 <47F6BD55.3090708@wesmo.com> <5699f8f00804050015kb1ebb1cpf3ab8b587580fffd@mail.gmail.com> <47F7982E.5080701@wesmo.com> <47F7F463.2060402@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0708.google.com ([209.85.198.242]:28168 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753068AbYDMCpk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 12 Apr 2008 22:45:40 -0400
Received: by rv-out-0506.google.com with SMTP id k29so308067rvb.1
        for <linux-ide@vger.kernel.org>; Sat, 12 Apr 2008 19:45:39 -0700 (PDT)
In-Reply-To: <47F7F463.2060402@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Rich West <Rich.West@wesmo.com>, Wander Winkelhorst <w.winkelhorst@gmail.com>, linux-kernel@vger.kernel.org, Linux IDE mailing list <linux-ide@vger.kernel.org>

Jeff Garzik wrote:
> Rich West wrote:
>> I was only curious as to what turning off power management support 
>> would buy with regard to the sata timeout issue.
> 
> 
> ACPI is not only power management.  It is all the information your 
> hardware conveys to your OS, about the setup and workings of your hardware.
> 
> Without ACPI, non-PM things like SMP, laptop dock/undock, and many other 
> gadgets fail to function (or are configured sub-optimally).
> 
> ACPI sets up interrupt routing, and Linux history is _loaded_ with 
> _years_ of problem reports that appear as timeouts, only to be resolved 
> as ACPI interrupt bugs (aka BIOS bugs, since ACPI tables come from BIOS).

Also, please give a shot at the sacred "irqpoll".

-- 
tejun
