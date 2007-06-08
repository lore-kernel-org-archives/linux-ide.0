From: Robert de Rooy <robert.de.rooy@gmail.com>
Subject: Re: libata and legacy ide pcmcia failure
Date: Sat, 09 Jun 2007 00:06:16 +0200
Message-ID: <4669D2D8.3020806@gmail.com>
References: <464A0321.3080201@gmail.com>	<464C1575.8070005@gmail.com> <464CB7C9.2080807@gmail.com>	<46503192.1040300@gmail.com> <4650B9E3.7070409@gmail.com>	<46518798.2020808@gmail.com> <4651B66E.6030505@gmail.com>	<4651B834.3060702@gmail.com> <4651C4A1.6000101@gmail.com>	<4651C74B.7020108@gmail.com> <46520B36.90409@garzik.org> <20070523150229.00a0c3c4@the-village.bc.nu> <466718B6.4080105@gmail.com> <4667B39D.209@gmail.com> <46685AE5.4010908@gmail.com> <466900F3.7040801@gmail.com> <46694FB2.6040007@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:17451 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968451AbXFHWGX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 8 Jun 2007 18:06:23 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1052680ugf
        for <linux-ide@vger.kernel.org>; Fri, 08 Jun 2007 15:06:21 -0700 (PDT)
In-Reply-To: <46694FB2.6040007@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <mlord@pobox.com>
Cc: Tejun Heo <htejun@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org, bzolnier@gmail.com, linux-pcmcia@lists.infradead.org, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Mark Lord wrote:
> I still don't see much evidence that interrupts are actually 
> functioning here.
> It would be good to see /proc/interrupts before/after libata tries to 
> talk to it.
>
> Let's assume for the moment that interrupts are b0rken.
> The legacy IDE driver can talk to such devices completely without 
> interrupts,
> if the IDE polling patch (below) is applied.
>
> So, Robert:  could you try again with the old IDE driver,
> except apply this patch to it first?  This will give valuable info.
I tried the patch, but a get a kernel panic on boot with it. I can try 
to get a screenshot of it tomorrow.
