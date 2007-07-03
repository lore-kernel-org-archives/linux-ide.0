From: Tejun Heo <htejun@gmail.com>
Subject: Re: 2.6.22-rc5 libata/ata_piix failure with older CDROM
Date: Tue, 03 Jul 2007 16:36:13 +0900
Message-ID: <4689FC6D.3060107@gmail.com>
References: <200706231346.l5NDkYm5018432@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.183]:20486 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753016AbXGCHhh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Jul 2007 03:37:37 -0400
Received: by py-out-1112.google.com with SMTP id u77so3075345pyb
        for <linux-ide@vger.kernel.org>; Tue, 03 Jul 2007 00:37:37 -0700 (PDT)
In-Reply-To: <200706231346.l5NDkYm5018432@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: linux-ide@vger.kernel.org

Mikael Pettersson wrote:
> ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> ata2.00: cmd a0/01:00:00:00:00/00:00:00:00:00/a0 tag 0 cdb 0x12 data 36 in
>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)

This is hopefully fixed by using PIO for ATAPI data transfers which
aren't multiple of 16bytes, which made into -rc7.  Care to give it a shot?

-- 
tejun
