From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: libata todo item: retry certain classes of errors
Date: Tue, 01 Feb 2005 20:50:13 -0500
Message-ID: <420031D5.9090304@pobox.com>
References: <41DE1118.9020209@pobox.com> <1105106379.17166.325.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:43648 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262203AbVBBBud (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 1 Feb 2005 20:50:33 -0500
In-Reply-To: <1105106379.17166.325.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>, Albert Lee <albertcc@tw.ibm.com>, Andy Warner <andyw@pobox.com>

Alan Cox wrote:
> On Gwe, 2005-01-07 at 04:33, Jeff Garzik wrote:
> 
>>libata error handling is still of the "stupid simple" variety.  While 
>>that makes it easy to verify, it also means that we don't always recover 
>>  from some situations.
>>
>>Right now, libata simply returns an error back to the SCSI layer.
> 
> 
> I did actually arrange that all the SCSI errors it faked caused the
> right retry behaviour at the SCSI level when I did that. Perhaps I
> should have commented that fact.

Well the retry needs to e.g. include a bus reset prior to retrying.

	Jeff



