From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] ide/libata: fix ata_id_is_cfa() (take 2)
Date: Mon, 26 Jan 2009 23:34:17 +0300
Message-ID: <497E1E49.1090409@ru.mvista.com>
References: <200901262309.31771.sshtylyov@ru.mvista.com> <20090126201905.43e57378@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:4823 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753053AbZAZUdr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 26 Jan 2009 15:33:47 -0500
In-Reply-To: <20090126201905.43e57378@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: bzolnier@gmail.com, jgarzik@pobox.com, linux-ide@vger.kernel.org, gdu@mns.spb.ru

Alan Cox wrote:

>>When checking for the CFA feature set support, ata_id_is_cfa() tests bit 2 in
>>word 82 of the identify data instead the word 83;  it also checks the ATA/PI
>>standard support in the word 80 -- which the CompactFlash specification has
>>as reserved, this having no slightest chance to work on CF drives that don't
>>have 0x848A in the word 0. Use instead the usual validity check: word 83 bit
>>14 must be set, bit 15 cleared.

>>Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

> NAK please stop mixing corrections with bugs that have been explained.

    Huh? You haven't explained anything. Your ATA base explanation is simply 
not valid in the CF world.

> You can't exercise logic in the id_is_cfa check that relies upon the
> device being CFA, which is what your comment says you are doing.

    Otherwise it has no chance to detect a CF drive *following the CF specs* 
and not having 0x848A in word 0. Please suggest a better solution. Perhaps we 
could check for word 80 being 0?

MBR, Sergei
