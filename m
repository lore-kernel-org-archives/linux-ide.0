From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] ide/libata: fix ata_id_is_cfa()
Date: Fri, 23 Jan 2009 13:33:52 +0000
Message-ID: <20090123133352.60add80e@lxorguk.ukuu.org.uk>
References: <200901231615.38011.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:42209 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755898AbZAWNe0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 23 Jan 2009 08:34:26 -0500
In-Reply-To: <200901231615.38011.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: bzolnier@gmail.com, jgarzik@pobox.com, linux-ide@vger.kernel.org, gdu@mns.spb.ru

On Fri, 23 Jan 2009 17:15:37 +0400
Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:

> When checking for CFA feature set support, ata_id_is_cfa() tests bit 2 in word
> 82 of the identify data instead the word 83.  It also checks the ATA revision
> in the  word 80 instead of usual validity check for the words 82-83 -- word 83
> bit 14 set, bit 15 cleared.

The word 82 validity bit is not sufficient as that bit is itself not
defined in ATA < 3. Otherwise the change looks correct.

Alan
