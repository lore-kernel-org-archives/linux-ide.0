From: Steven Scholz <steven.scholz@imc-berlin.de>
Subject: Re: no DRQ after issuing MULTWRITE_EXT ?
Date: Thu, 01 Feb 2007 17:02:17 +0100
Message-ID: <45C20F09.4070908@imc-berlin.de>
References: <45C1B079.3080704@imc-berlin.de> <45C1E5CD.8010707@ru.mvista.com> <45C1EC18.5040802@imc-berlin.de> <45C1ED96.3030701@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.imc-berlin.de ([217.110.46.186]:33607 "EHLO
	mx1.imc-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751839AbXBAQCW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 1 Feb 2007 11:02:22 -0500
In-Reply-To: <45C1ED96.3030701@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

Hi Sergei,

>>>   Looks like a spurious interrupt... Is your IDE IRQ shared with other
>>> devices?
>> .. 
>> But IIUC then first the HDD times out, the ide driver handles this and
>> then an irq occurs which is probably the irq the driver was waiting for.
> 
>    The driver is *not* waiting for any IRQ after issuing MULTWRITE_EXT,
> that's why it's "unexpected".

Hmm. But how does he "know" when that MULTWRITE_EXT is finished!?

Steven
