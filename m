From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: JMicron Technology JMB362 JMB363 SError: { DevExch }
 ExpressCard, sometimes fails to boot
Date: Tue, 13 Dec 2011 16:44:32 -0600
Message-ID: <20111213224432.GA3619@elie.hsd1.il.comcast.net>
References: <20111030211240.GE7696@google.com>
 <201110310300.p9V3021e019006@jmr105.jmicron.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:33171 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752914Ab1LMWol (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 13 Dec 2011 17:44:41 -0500
Received: by vbbfc26 with SMTP id fc26so159100vbb.19
        for <linux-ide@vger.kernel.org>; Tue, 13 Dec 2011 14:44:40 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <201110310300.p9V3021e019006@jmr105.jmicron.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: 'Tejun Heo' <tj@kernel.org>, 'Orson' <orson.wellies@gmail.com>, Aries Lee <arieslee@jmicron.com>

(Aries: sorry for the duplicate message)
Hi,

Aries Lee wrote:

> Is it possible to install windows OS on the same hardware,
> If it still get the same error, that we can conclude it as a hardware issue.

Orson wrote:

> I installed WinXP SP3 as a dual boot option onto my HP NX6325.
> I booted into windows and my dual port express card was found immediately, I
> installed the latest driver from J Micron and everything seemed to be OK.
> I looked through the winxp system messages and all was OK, I looked through
> device manager and it said everything was OK, all resources were OK.
> I attached an external esata drive and it was detected instantly and was
> available in my list of drives, I copied some files over, all went OK, I ran
> scandisk to check the drive and all went OK, the drive did not seem to
> re-attach itself or give any errors.  So it seems to work fine in windows.

All right; looks like the hardware works.

> I then shut down my laptop and removed the esata drive and booted into Debian
> wheezy, same error appeared during boot (without any drive attached)
> irq_stat 0x00000040, connection status changed
> ata1: SError: { PHYInt CommWake DevExch }
> ata1: hard resetting link
> ata1: COMRESET failed (errno=-32)
> ata1: reset failed (errno=-32), retrying in 8 secs
> ata1: limiting SATA link speed to 1.5 Gbps
> ata1: hard resetting link
> ata1: SATA link down (SStatus 0 SControl 310)
> ata1: EH complete
>
> etc, etc.

Right.

> I booted back to windows and all was OK, but, here is what I have found, if I
> boot into Linux from windows without shutting down (warm boot) then the
> express card is initialised in Debian without problems and works as normal, if
> I shut down and cold boot straight to Debian, the error appears again.

Interesting.  So it sounds like Windows is doing some initialization
that Linux does not.

> Perhaps the card is faulty or (I suspect) there is a problem with the bios on
> the NX6325, the latest bios is dated 2007 and HP seem to have stopped
> supporting this model, even though mine was purchased new in 2007.

Please send "acpidump" output as an attachment for reference.

> Anyway, because the express card is so cheap I have just ordered a replacement
> of the same type, so this will tell me if it's the card that is at fault.

Ok.  Thanks for your work.

linux-ide folks: any ideas for debugging this further?  For example,
is there a way to find the difference between the state after a cold
boot and a warm boot from windows?

Ciao,
Jonathan
