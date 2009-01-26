From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] ide/libata: fix ata_id_is_cfa() (take 2)
Date: Mon, 26 Jan 2009 20:19:05 +0000
Message-ID: <20090126201905.43e57378@lxorguk.ukuu.org.uk>
References: <200901262309.31771.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:55171 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752262AbZAZUTo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 26 Jan 2009 15:19:44 -0500
In-Reply-To: <200901262309.31771.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: bzolnier@gmail.com, jgarzik@pobox.com, linux-ide@vger.kernel.org, gdu@mns.spb.ru

On Tue, 27 Jan 2009 00:09:31 +0400
Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:

> When checking for the CFA feature set support, ata_id_is_cfa() tests bit 2 in
> word 82 of the identify data instead the word 83;  it also checks the ATA/PI
> standard support in the word 80 -- which the CompactFlash specification has
> as reserved, this having no slightest chance to work on CF drives that don't
> have 0x848A in the word 0. Use instead the usual validity check: word 83 bit
> 14 must be set, bit 15 cleared.
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

NAK please stop mixing corrections with bugs that have been explained.

You can't exercise logic in the id_is_cfa check that relies upon the
device being CFA, which is what your comment says you are doing.

