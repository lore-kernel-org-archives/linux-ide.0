From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] ide/libata: fix ata_id_is_cfa()
Date: Tue, 27 Jan 2009 02:28:33 +0300
Message-ID: <497E4721.7000107@ru.mvista.com>
References: <200901231615.38011.sshtylyov@ru.mvista.com>	<497B9EE4.8010807@ru.mvista.com>	<497E0548.80904@ru.mvista.com>	<20090126190801.7d198246@lxorguk.ukuu.org.uk>	<497E0EF3.2000201@ru.mvista.com>	<497E101C.9040008@ru.mvista.com>	<20090126194237.4897b6ce@lxorguk.ukuu.org.uk>	<497E1550.1000501@ru.mvista.com>	<20090126200143.733b0cec@lxorguk.ukuu.org.uk>	<497E1DBB.80709@ru.mvista.com>	<497E242C.3040307@ru.mvista.com> <20090126212212.3d52781f@lxorguk.ukuu.org.uk> <497E2D6F.3070605@ru.mvista.com> <497E2E7C.8040407@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:7320 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751601AbZAZX2l (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 26 Jan 2009 18:28:41 -0500
In-Reply-To: <497E2E7C.8040407@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: bzolnier@gmail.com, jgarzik@pobox.com, linux-ide@vger.kernel.org, gdu@mns.spb.ru

Hello, I wrote:

>>> - make the CFA code check word 80 == 0 as a sanity check
>
>>    That'll work unless we bump into a drive that does follow ATA in 
>> that matter.
>
>    ... because it also does specify the CFA feature set (minus the 
> exotic PIO/DMA modes). That's what you get for the closed standards. 
> And yet there seem to be CF drives in the wild that follow neither... :-/

  ... or are just not supporting the CFA feature set -- see 
http://marc.info/?l=linux-ide&m=123263947330207 if you've missed that 
Kingston's wonder. :-/

MBR, Sergei


