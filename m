From: Tejun Heo <htejun@gmail.com>
Subject: Re: ata, pcmcia: problem with irq and ata_dev_read_id()
Date: Mon, 26 Jul 2010 15:11:16 +0200
Message-ID: <4C4D8974.3030400@gmail.com>
References: <4C034FAE.9090605@denx.de> <4C044C8F.8050406@gmail.com> <4C2833B2.3040209@denx.de> <4C2DFF43.6050502@gmail.com> <4C319741.3060602@denx.de> <4C319D31.60705@gmail.com> <4C31A519.7030806@denx.de> <4C31A6DF.9080109@gmail.com> <4C4D86A4.2040500@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:57421 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753196Ab0GZNLW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 26 Jul 2010 09:11:22 -0400
Received: by bwz1 with SMTP id 1so2772570bwz.19
        for <linux-ide@vger.kernel.org>; Mon, 26 Jul 2010 06:11:21 -0700 (PDT)
In-Reply-To: <4C4D86A4.2040500@denx.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: hs@denx.de
Cc: Robert Hancock <hancockrwd@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Hello,

On 07/26/2010 02:59 PM, Heiko Schocher wrote:
> Hmm.. I am not sure if "leaving things as it is" is the better way,
> because this behaviour comes every time, I insert a card! And with
> my patch I can prevent this behaviour ...

Yes, it fixes the behavior which comes every time in your
configuration but it might at the same time break other configurations
which are more common.  ATA probing is a painful thing and we had
pretty good reasons to turn on TFLAG_POLLING for IDENTIFY by default.

The only side effect your configuration is going to have is IRQ
polling kicking in for short period of time after device insertion.
Please also note that the device can't be quirked as it's before its
identity is known.  So, yeah, I think it is better to leave things as
is as long as IRQ flakiness can be handled in acceptable manner which
we need to do anyway.

Thanks.

-- 
tejun
