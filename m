From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: libata todo item: retry certain classes of errors
Date: Thu, 03 Feb 2005 17:16:53 +0000
Message-ID: <1107450889.14847.148.camel@localhost.localdomain>
References: <41DE1118.9020209@pobox.com>
	 <1105106379.17166.325.camel@localhost.localdomain>
	 <420031D5.9090304@pobox.com>
	 <1107330670.14787.104.camel@localhost.localdomain>
	 <42025E3B.8030302@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Received: from clock-tower.bc.nu ([81.2.110.250]:61320 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S263431AbVBCSWZ
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 3 Feb 2005 13:22:25 -0500
In-Reply-To: <42025E3B.8030302@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>, Albert Lee <albertcc@tw.ibm.com>, Andy Warner <andyw@pobox.com>

On Iau, 2005-02-03 at 17:24, Jeff Garzik wrote:
> > went away" error reports with the IDE layer (and they take forever).
> 
> libata does a reset at the beginning of the probe...

Thats fine but resets when the drive is error handling get "interesting"

