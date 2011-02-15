From: Lin Mac <mkl0301@gmail.com>
Subject: Re: Question regarding PORT_IRQ_BAD_PMP (Re: AHCI support Port
 Multiplier problem.)
Date: Tue, 15 Feb 2011 17:50:55 +0800
Message-ID: <AANLkTimG0Y2XjRTmaSLs0uq4h-zoz-x+k_eA-2Abxmg9@mail.gmail.com>
References: <20110107212537.GH7355@mtj.dyndns.org>
	<55871.3142.qm@web74203.mail.tp2.yahoo.com>
	<20110111143726.GE30607@htj.dyndns.org>
	<loom.20110215T051458-468@post.gmane.org>
	<20110215085504.GA3160@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:56012 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752867Ab1BOJvI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 Feb 2011 04:51:08 -0500
Received: by fxm20 with SMTP id 20so6179009fxm.19
        for <linux-ide@vger.kernel.org>; Tue, 15 Feb 2011 01:51:07 -0800 (PST)
In-Reply-To: <20110215085504.GA3160@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

2011/2/15 Tejun Heo <tj@kernel.org>:
> Hello,
> (please always reply-to-all)
I'm sorry about that. I was not subscribed to linux-ide, and replied by=
 gmane.

> On Tue, Feb 15, 2011 at 07:48:18AM +0000, Mac Lin wrote:
>> It seems that the PORT_IRQ_BAD_PMP is not getting cleared, or, asser=
ted every
>> time when it "received a FIS from a device that did not have a comma=
nd
>> outstanding", which is the D2H FIS of softreset.
>>
>> The sb600, which I assume the code work correctly, seems doesn't hav=
e this
>> problem. So I am wondering that whether is this the right behavior o=
n cns3xxx,
>> or =A0and just another issue of the chip?
>
> You're already working around buggy hardware. =A0It isn't surprising
> that both behave incorrectly in their own separate ways. =A0Just do
> what's necessary to get the hardware working as long as the workaroun=
d
> is localized to the specific controller.
If I implement it as a quirk, would you prefer to add a new field
quirk, or just use flags of ahci_host_priv and add a new AHCI_HFLAG*?
I prefer the later, but afraid that it's not what it is for.

Best Regards,
Mac Lin
