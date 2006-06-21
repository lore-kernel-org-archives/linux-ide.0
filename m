From: Kirill Smelkov <kirr@mns.spb.ru>
Subject: Re: [PATCH] ide: fix revision comparison in ide_in_drive_list
Date: Wed, 21 Jun 2006 10:17:27 +0400
Message-ID: <200606211017.28987.kirr@mns.spb.ru>
References: <200606201452.33925.kirr@mns.spb.ru> <20060620151950.21ad94d6.akpm@osdl.org> <1150845122.15275.8.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.mnsspb.ru ([84.204.75.2]:46219 "EHLO mail.mnsspb.ru")
	by vger.kernel.org with ESMTP id S1751187AbWFUGQ0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 21 Jun 2006 02:16:26 -0400
In-Reply-To: <1150845122.15275.8.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

21 Jun 2006 03:12, Alan Cox wrote:
> Ar Maw, 2006-06-20 am 15:19 -0700, ysgrifennodd Andrew Morton:
> > hm.  This seems...  rather serious.  I assume that in most cases, the
> > firmware rev which we have in the table (eg "24.09P07") is a full-string
> > match for the string which the drive returned.
> 
> They are full matches as far as I can see so it should be ok, plus the
> DMA blacklist is mostly hardware that went out ten or more years ago.
> Even if it did mis-trigger we'd be blacklisting extra firmware revs of
> iffy hardware so that isn't do worrying.

No, they are *not* full matches.

My case:
CF model="TRANSCEND", revision="20050811" as reported by "hdparm -I" and bios,

but

id->model="TRANSCEND",
id->fw_rev="20050811TRANSCEND"

note the trailing in id->fw_rev,

So lets look at ide_in_drive_list -- it should try to detect blacklisted revision,
so it looks for substr device_table->id_firmware in id->fw_rev.

NB: I don't know what causes id->fw_rev to be bogus (?), but maybe the right fix
NB: is to correct its initialization. Some person with IDE background should clarify this. 

-- 
	Kirill

