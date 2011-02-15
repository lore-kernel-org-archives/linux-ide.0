From: Lin Mac <mkl0301@gmail.com>
Subject: Re: Question regarding PORT_IRQ_BAD_PMP (Re: AHCI support Port
 Multiplier problem.)
Date: Tue, 15 Feb 2011 18:26:21 +0800
Message-ID: <AANLkTin_K=KzYkrfO_pJDe_9LZzSJBbQn=8vjO1HhNG4@mail.gmail.com>
References: <20110107212537.GH7355@mtj.dyndns.org>
	<55871.3142.qm@web74203.mail.tp2.yahoo.com>
	<20110111143726.GE30607@htj.dyndns.org>
	<loom.20110215T051458-468@post.gmane.org>
	<20110215085504.GA3160@htj.dyndns.org>
	<AANLkTimG0Y2XjRTmaSLs0uq4h-zoz-x+k_eA-2Abxmg9@mail.gmail.com>
	<20110215100335.GH3160@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:60997 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751963Ab1BOK0Y convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 Feb 2011 05:26:24 -0500
Received: by fxm20 with SMTP id 20so7600fxm.19
        for <linux-ide@vger.kernel.org>; Tue, 15 Feb 2011 02:26:23 -0800 (PST)
In-Reply-To: <20110215100335.GH3160@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com

2011/2/15 Tejun Heo <tj@kernel.org>:
> On Tue, Feb 15, 2011 at 05:50:55PM +0800, Lin Mac wrote:
>> > You're already working around buggy hardware. =A0It isn't surprisi=
ng
>> > that both behave incorrectly in their own separate ways. =A0Just d=
o
>> > what's necessary to get the hardware working as long as the workar=
ound
>> > is localized to the specific controller.
>>
>> If I implement it as a quirk, would you prefer to add a new field
>> quirk, or just use flags of ahci_host_priv and add a new AHCI_HFLAG*=
?
>> I prefer the later, but afraid that it's not what it is for.
>
> Please implement it as a separate ata_port_operations like
> ahci_CONTROLLER_NAME_ops and use the customized reset methods.

In fact, I did. But it doesn't get accepted.

    [PATCH v5 0/3] add CNS3xxx AHCI support (Cavium Networks)
    http://www.spinics.net/lists/linux-ide/msg39859.html

And given that there are many of them, shouldn't we implement it as qui=
rk?


    AHCI support Port Multiplier problem. (Faraday)
    http://www.spinics.net/lists/linux-ide/msg39815.html

    Texas Instruments OMAP L138

    ATI SB600/SB700 (ahci_sb600_softreset)
    http://kerneltrap.org/mailarchive/git-commits-head/2008/6/14/212231=
4

Best Regards,
Mac Lin
