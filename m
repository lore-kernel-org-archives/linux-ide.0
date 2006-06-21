From: Kirill Smelkov <kirr@mns.spb.ru>
Subject: Re: [PATCH] ide: fix revision comparison in ide_in_drive_list
Date: Wed, 21 Jun 2006 17:11:13 +0400
Message-ID: <200606211711.14731.kirr@mns.spb.ru>
References: <200606201452.33925.kirr@mns.spb.ru> <200606211017.28987.kirr@mns.spb.ru> <1150890282.15275.54.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.mnsspb.ru ([84.204.75.2]:666 "EHLO mail.mnsspb.ru")
	by vger.kernel.org with ESMTP id S1751559AbWFUNIJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 21 Jun 2006 09:08:09 -0400
In-Reply-To: <1150890282.15275.54.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

21 Jun 2006 15:44, Alan Cox wrote:
> > id->model="TRANSCEND",
> > id->fw_rev="20050811TRANSCEND"
> > 
> > note the trailing in id->fw_rev,
> 
> These are not null terminated strings in the ident block. So if you
> merely print them or test against them you'll break on 8 char long
> firmware names. They may also be space rather than \0 padded if shorter
This justifies strstr usage.

Thanks again.

-- 
	Kirill

