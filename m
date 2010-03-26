From: Ludovico Cavedon <ludovico.cavedon@gmail.com>
Subject: Re: understanding the cause of ATA failures
Date: Thu, 25 Mar 2010 19:22:00 -0700
Message-ID: <4BAC1A48.5020904@gmail.com>
References: <4BA2A02F.7040200@gmail.com> <4BA2A27E.9040704@buttersideup.com> <4BA2A590.4030505@gmail.com> <4BA2AA34.70105@hardwarefreak.com> <4BA2B15E.6000301@gmail.com> <4BA2B9BE.5030607@hardwarefreak.com> <4BA2F19D.1090501@gmail.com> <4BAAB3D0.90704@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qy0-f188.google.com ([209.85.221.188]:44117 "EHLO
	mail-qy0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753378Ab0CZCWJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 Mar 2010 22:22:09 -0400
Received: by qyk26 with SMTP id 26so6162408qyk.19
        for <linux-ide@vger.kernel.org>; Thu, 25 Mar 2010 19:22:06 -0700 (PDT)
In-Reply-To: <4BAAB3D0.90704@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Stan Hoeppner <stan@hardwarefreak.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> If you have the machine locally, one thing you can try is to pull out
> all the drives and hook them up directly to the motherboard bypassing
> the backplane and see whether anything changes.

Yes, I think I'll try to go this way. Unfortunately (or not :) the issue
happens once a month... I'll see if icnreasing the load on the machine
it will happen more frequently.

Stan Hoeppner wrote:
> In short, I don't know how it all needs to be hooked up, what the specific
> device combination needs to be, or what Linux modules you need to
> communicate with the MG9072 chip on that backplane.  Again, call your
> vendor.  It's their product.  They should have the answers.

Yes, I talked to supermirco and suggested basically what Tejun did:
bypass the backplane and see if the problem persists.

> Your welcome.  Glad to pass on some of my experience if it can help someone
> else.  I wish there was more I could do at this point, but it's pretty much
> up to you now.  Hope I've helped steer you in the right direction.  As
> always, don't put all your eggs in this one troubleshooting basket.  The
> cause of the problem could also lie elsewhere so keep and open mind and
> don't throw up your hand in frustration if this track doesn't pan out.

Very valuable info, thank you.

Cheers,
Ludovico
