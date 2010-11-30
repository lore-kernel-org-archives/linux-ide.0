From: Tejun Heo <htejun@gmail.com>
Subject: Re: Cannot detect SATA disks w/ CONFIG_SATA_PMP w/o actually using
 SATA multiplier
Date: Tue, 30 Nov 2010 20:49:29 +0100
Message-ID: <4CF55549.4080000@gmail.com>
References: <AANLkTi=kbTcq3hYBiDzGcAb02Ppwb1QEcs12-1W_T=LG@mail.gmail.com> <4CF50574.6000706@gmail.com> <AANLkTi=0gBcfrAyJNb0+=obH2QDsqhGM5a9xxwHAoh88@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:39164 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754249Ab0K3TuM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Nov 2010 14:50:12 -0500
Received: by bwz15 with SMTP id 15so5364904bwz.19
        for <linux-ide@vger.kernel.org>; Tue, 30 Nov 2010 11:50:11 -0800 (PST)
In-Reply-To: <AANLkTi=0gBcfrAyJNb0+=obH2QDsqhGM5a9xxwHAoh88@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Lin Mac <mkl0301@gmail.com>
Cc: cbouatmailru@gmail.com, linux-arm-kernel@lists.infradead.org, jgarzik@pobox.com, linux-ide@vger.kernel.org

Hello,

On 11/30/2010 06:46 PM, Lin Mac wrote:
> Could be,  but disabling it is the last option. And it's anoying to
> have 2 different modules for different uses.
> 
> I'd prefer some clues/checkpoint if possible.

One thing which could be possible is that the controller stashes the
result code for the PMP aware SRST according to the PMP number instead
of the usual place, so the driver can't see it.  In that case, the
driver can be modified to check both places I suppose but if the
hardware can be fixed, that would be great.

> I supposed the behavior of detecting and resetting disks (without
> using port multiplier) should be the same for both with and without
> CONFIG_SATA_PMP. All I know about port multiplier is when it is used
> (not much too), but is there any register configuration or behavior is
> required for multiplier to work properly and take effect even when no
> multiplier is used?

Yeah, the only difference is the PMP port number when issuing SRST.
Non-PMP devices ignore it and respond the same way while PMP
recognizes it and responds with PMP signature instead of the signature
of the first device.  As written above, I think it's quite likely that
the controller is handling the response D2H Reg FIS incorrectly when a
non-PMP device responds to PMP SRST.

Good luck.

-- 
tejun
