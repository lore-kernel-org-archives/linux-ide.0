From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] ide: fix revision comparison in ide_in_drive_list
Date: Wed, 21 Jun 2006 12:44:42 +0100
Message-ID: <1150890282.15275.54.camel@localhost.localdomain>
References: <200606201452.33925.kirr@mns.spb.ru>
	 <20060620151950.21ad94d6.akpm@osdl.org>
	 <1150845122.15275.8.camel@localhost.localdomain>
	 <200606211017.28987.kirr@mns.spb.ru>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:4737 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751504AbWFUL3l (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 21 Jun 2006 07:29:41 -0400
In-Reply-To: <200606211017.28987.kirr@mns.spb.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kirill Smelkov <kirr@mns.spb.ru>
Cc: Andrew Morton <akpm@osdl.org>, B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Ar Mer, 2006-06-21 am 10:17 +0400, ysgrifennodd Kirill Smelkov:
> id->model="TRANSCEND",
> id->fw_rev="20050811TRANSCEND"
> 
> note the trailing in id->fw_rev,

These are not null terminated strings in the ident block. So if you
merely print them or test against them you'll break on 8 char long
firmware names. They may also be space rather than \0 padded if shorter

Alan

