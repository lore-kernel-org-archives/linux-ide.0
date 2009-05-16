From: Alexander Beregalov <a.beregalov@gmail.com>
Subject: Re: [PATCH] sata_sx4: speed up ECC initialization
Date: Sat, 16 May 2009 23:17:27 +0400
Message-ID: <a4423d670905161217x7da4e01tcaa64597beb590dd@mail.gmail.com>
References: <1239675982-32584-1-git-send-email-a.beregalov@gmail.com>
	 <49E47A45.60902@garzik.org> <20090414200054.GB17134@orion>
	 <49E4F047.3030500@garzik.org>
	 <a4423d670904141351o72c4c0acka87a00360f1a53eb@mail.gmail.com>
	 <4A0E5D5F.1080708@garzik.org> <20090516132912.GA23272@orion>
	 <4A0F0FFF.9010809@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f174.google.com ([209.85.218.174]:52897 "EHLO
	mail-bw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754971AbZEPTR1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 16 May 2009 15:17:27 -0400
Received: by bwz22 with SMTP id 22so2513654bwz.37
        for <linux-ide@vger.kernel.org>; Sat, 16 May 2009 12:17:27 -0700 (PDT)
In-Reply-To: <4A0F0FFF.9010809@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org

2009/5/16 Jeff Garzik <jeff@garzik.org>:
> Alexander Beregalov wrote:
>>
>> On Sat, May 16, 2009 at 02:29:51AM -0400, Jeff Garzik wrote:
>>>
>>> Check out 2.6.30-rc6, sata_sx4 received several major bug fixes...
>>
>> Thanks, but it still does not work.
>
> oh well... =C2=A0 did behavior improve for you, at least? =C2=A0Did t=
he driver make it
> farther than before?

No, the same behavior.
My modification is not enough for driver to work as PATA controller.
