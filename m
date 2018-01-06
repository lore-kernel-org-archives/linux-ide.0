From: Darren Stevens <darren@stevens-zone.net>
Subject: Re: libata:pata_atiixp: Don't use unconnected secondary port on
 SB600
Date: Sat, 06 Jan 2018 10:13:34 +0000 (GMT)
Message-ID: <4b44622c6c4.4181ace8@auth.smtp.1and1.co.uk>
References: <4b3d1364126.4c1d107e@auth.smtp.1and1.co.uk>
 <20180102145608.GA3668920@devbig577.frc2.facebook.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:53023 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752821AbeAFKNu (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 6 Jan 2018 05:13:50 -0500
In-Reply-To: <20180102145608.GA3668920@devbig577.frc2.facebook.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

Hello Tejun

On 02/01/2018, Tejun Heo wrote:
> Hello, Darren.
>
> On Sun, Dec 31, 2017 at 09:11:05PM +0000, Darren Stevens wrote:
>>     The AMD SB600 southbridge has an PATA IDE interface, but the
>>     secondary port has no physical connections, so is disabled in
>>     the PCI header which makes it appear as a legacy port.
>
> How sure are you about the secondary port never being used?  Given the
> age of the device and that this has been like this the whole time, I'd
> prefer if the workaround were more specific - ie. mark it dummy only
> on the specific machines that are known to be broken.  That said, if
> we know with certainty that the secondary port is never used, sure.

I'm reasonably sure.
>From '46157-sb600-bdg-pub-3.00'

Page 27 section 6.1.2

Note: Secondary IDE channel should always be disabled for there is no pin out for secondary IDE.

However I was trying to keep patches for the X1000 inside arch/powerpc rather than all over the linux tree. If you are OK with a specific patch I can resubmit.

Thanks
Darren

