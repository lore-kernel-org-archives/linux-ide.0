From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: libata todo item: retry certain classes of errors
Date: Thu, 03 Feb 2005 10:02:29 +0000
Message-ID: <1107330670.14787.104.camel@localhost.localdomain>
References: <41DE1118.9020209@pobox.com>
	 <1105106379.17166.325.camel@localhost.localdomain>
	 <420031D5.9090304@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Received: from clock-tower.bc.nu ([81.2.110.250]:56452 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S262967AbVBCLHr
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 3 Feb 2005 06:07:47 -0500
In-Reply-To: <420031D5.9090304@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>, Albert Lee <albertcc@tw.ibm.com>, Andy Warner <andyw@pobox.com>

On Mer, 2005-02-02 at 01:50, Jeff Garzik wrote:
> Alan Cox wrote:
> > I did actually arrange that all the SCSI errors it faked caused the
> > right retry behaviour at the SCSI level when I did that. Perhaps I
> > should have commented that fact.
> 
> Well the retry needs to e.g. include a bus reset prior to retrying.

Thats possibly true for some situations. You might also want to avoid
issuing resets as much as you can because they are a rather good source
of "my drive
went away" error reports with the IDE layer (and they take forever).


