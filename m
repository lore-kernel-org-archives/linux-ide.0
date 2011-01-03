From: Tejun Heo <tj@kernel.org>
Subject: Re: PowerPC MPC5200B ATA MWDMA regression
Date: Mon, 3 Jan 2011 15:33:07 +0100
Message-ID: <AANLkTi=5TrmxeWppabYaFUr-AhLwWcn4b_EQgLSJT44T@mail.gmail.com>
References: <201101031445.47922.roman.fietze@telemotive.de>
	<20110103135929.GO18831@htj.dyndns.org>
	<4D21DD55.2000000@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:52189 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754672Ab1ACOdJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Jan 2011 09:33:09 -0500
Received: by qyj19 with SMTP id 19so15912220qyj.19
        for <linux-ide@vger.kernel.org>; Mon, 03 Jan 2011 06:33:08 -0800 (PST)
In-Reply-To: <4D21DD55.2000000@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: Roman Fietze <roman.fietze@telemotive.de>, linux-ide@vger.kernel.org, linuxppc-dev@lists.ozlabs.org

On Mon, Jan 3, 2011 at 3:29 PM, Sergei Shtylyov <sshtylyov@mvista.com> =
wrote:
>> The commit you bisected to contains all those conversions too. =A0Ta=
ke a
>> look at a similar driver and look at how it has been converted
>> recently. =A0Even better, just send the driver upstream. =A0:-)
>
> =A0 It's already there...

Ouch, did I forget to convert it or was it a merge timing problem?
Anyways, sorry about that.  Please go ahead and fix it. :-)

--=20
tejun
