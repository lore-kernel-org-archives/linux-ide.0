From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] (IDE) restore access to low order LBA following error
Date: Thu, 05 Aug 2004 17:45:05 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1091724300.8043.58.camel@localhost.localdomain>
References: <41126458.1050203@emc.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from the-village.bc.nu ([81.2.110.252]:10686 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267838AbUHERre (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 5 Aug 2004 13:47:34 -0400
In-Reply-To: <41126458.1050203@emc.com>
List-Id: linux-ide@vger.kernel.org
To: Brett Russ <russb@emc.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>

I would make sure you are looking at the right register set in your own
code. Any code now thats going to exist for most 2.4 users will need to
do that itself, and after my 2.4 experience with the IDE core I'd advise
anyone working on it to

a) Pass it off to another maintainer as fast as possible ;)
b) Program defensively

Once Jeff has MWDMA and ATAPI in the new SATA/ATA driver he wrote then
migration might be an even better option. It'll certainly be easier to
do a lot of things right with the newest SATA code than with the current
IDE layer.


