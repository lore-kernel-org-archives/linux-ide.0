From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] ide/libata: fix ata_id_is_cfa()
Date: Tue, 27 Jan 2009 00:38:55 +0300
Message-ID: <497E2D6F.3070605@ru.mvista.com>
References: <200901231615.38011.sshtylyov@ru.mvista.com>	<497B9EE4.8010807@ru.mvista.com>	<497E0548.80904@ru.mvista.com>	<20090126190801.7d198246@lxorguk.ukuu.org.uk>	<497E0EF3.2000201@ru.mvista.com>	<497E101C.9040008@ru.mvista.com>	<20090126194237.4897b6ce@lxorguk.ukuu.org.uk>	<497E1550.1000501@ru.mvista.com>	<20090126200143.733b0cec@lxorguk.ukuu.org.uk>	<497E1DBB.80709@ru.mvista.com>	<497E242C.3040307@ru.mvista.com> <20090126212212.3d52781f@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:5741 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752028AbZAZVi0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 26 Jan 2009 16:38:26 -0500
In-Reply-To: <20090126212212.3d52781f@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: bzolnier@gmail.com, jgarzik@pobox.com, linux-ide@vger.kernel.org, gdu@mns.spb.ru

Alan Cox wrote:

>>    I'm sorry, that was totally off base. I've misread this whole paragraph in 
>>haste. :-<
>>    The rest of my evening was wasted, sigh.

> If it got the CF code fixed it wasn't a waste.

> Do I understand rightly that the agreed things to do are

> - redo the version check patch using the signed check as you suggested
> and remove the changes to the CFA check from it

    Yes, those shouldn't have been intermixed from the very start.

> - make the CFA code check word 80 == 0 as a sanity check

    That'll work unless we bump into a drive that does follow ATA in that 
matter. My vote would still be for ignoring the version...

> - apply your change to check the bit in the right command word for CFA

    My change wasn't only that. I will repost it after some sleep -- with word 
80 check for 0 if you're so adamant about it.

> Alan

MBR, Sergei
