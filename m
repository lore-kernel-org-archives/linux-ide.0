From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] ide/libata: fix ata_id_is_cfa() (take 3)
Date: Tue, 27 Jan 2009 13:38:41 +0000
Message-ID: <20090127133841.2405e649@lxorguk.ukuu.org.uk>
References: <200901271619.53025.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:57536 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753372AbZA0Nnf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Jan 2009 08:43:35 -0500
In-Reply-To: <200901271619.53025.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: bzolnier@gmail.com, jgarzik@pobox.com, linux-ide@vger.kernel.org, gdu@mns.spb.ru

On Tue, 27 Jan 2009 17:19:52 +0400
Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:

> When checking for the CFA feature set support, ata_id_is_cfa() tests bit 2 in
> word 82 of the identify data instead the word 83;  it also checks the ATA/PI
> version support in the word 80 (which the CompactFlash specifications have as
> reserved), this having no slightest chance to work on the modern CF cards that
> don't have 0x848A in the word 0...
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

Acked-by: Alan Cox <number6@the-village.bc.nu>
