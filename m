From: Ricky Beam <jfbeam@bluetronic.net>
Subject: Re: [PATCH] fix sata_sil quirk
Date: Wed, 23 Jun 2004 02:34:35 -0400 (EDT)
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <Pine.GSO.4.33.0406230230010.25702-100000@sweetums.bluetronic.net>
References: <40D8FE55.3030008@pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sweetums.bluetronic.net ([24.199.150.42]:56062 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id S266126AbUFWGkj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 23 Jun 2004 02:40:39 -0400
In-Reply-To: <40D8FE55.3030008@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Paul Jakma <paul@clubi.ie>, linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>

On Tue, 22 Jun 2004, Jeff Garzik wrote:
>Nope, my patch only enables ATA_DFLAG_LOCK_SECTORS for devices flagged
>with SIL_QUIRK_MOD15WRITE:
...

That list needs a:
         { "ST3160023AS",        SIL_QUIRK_MOD15WRITE },
as well.

--Ricky

PS: I've completed 23 cycles of zeroing a 40G section of RAID0 space without
    error.


