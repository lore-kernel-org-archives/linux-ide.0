From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: libata todo item: retry certain classes of errors
Date: Thu, 03 Feb 2005 12:24:11 -0500
Message-ID: <42025E3B.8030302@pobox.com>
References: <41DE1118.9020209@pobox.com>	 <1105106379.17166.325.camel@localhost.localdomain>	 <420031D5.9090304@pobox.com> <1107330670.14787.104.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:51842 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S263208AbVBCRYe (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 3 Feb 2005 12:24:34 -0500
In-Reply-To: <1107330670.14787.104.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>, Albert Lee <albertcc@tw.ibm.com>, Andy Warner <andyw@pobox.com>

Alan Cox wrote:
> On Mer, 2005-02-02 at 01:50, Jeff Garzik wrote:
> 
>>Alan Cox wrote:
>>
>>>I did actually arrange that all the SCSI errors it faked caused the
>>>right retry behaviour at the SCSI level when I did that. Perhaps I
>>>should have commented that fact.
>>
>>Well the retry needs to e.g. include a bus reset prior to retrying.
> 
> 
> Thats possibly true for some situations. You might also want to avoid
> issuing resets as much as you can because they are a rather good source
> of "my drive
> went away" error reports with the IDE layer (and they take forever).

libata does a reset at the beginning of the probe...

	Jeff



