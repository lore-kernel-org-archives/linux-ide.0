From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 1/6] libata: update protocol numbers
Date: Fri, 15 Jun 2007 10:45:30 -0400
Message-ID: <4672A60A.80206@garzik.org>
References: <4667B767.5060601@tw.ibm.com> <4667B801.3060603@tw.ibm.com> <466B6C14.5040006@garzik.org> <466C7BDF.9030805@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:56512 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753989AbXFOOpf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 15 Jun 2007 10:45:35 -0400
In-Reply-To: <466C7BDF.9030805@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>, albertl@mail.com
Cc: Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@enoyolf.org>

Mark Lord wrote:
> Jeff Garzik wrote:
>> Albert Lee wrote:
>>> Patch 1/6:
>>>  Update the ATA passthru protocol numbers according to the new spec.
>>>
>>> Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
>>
>> applied 1-4, 6 to #upstream-fixes
> 
> What about this one:  [PATCH 5/6] libata: support ATAPI devices  ??
> 
> I'm quite happy to let Albert run with that,
> as he's busily maintaining the rest of the passthrough stuff.

I answered this a month or so ago, but between your lost mail and my 
apparently-lossy Sent folder, it would probably be worth re-answering:

Rather than sprinkling "is it ata or atapi?" tests throughout the 
libata-scsi hotpaths, I would strongly prefer that
__ata_scsi_queuecmd() change to look more like

	if (device is ATA)
		xlat_func = ata_get_xlat_func()
		if (xlat_func)
			ata_scsi_translate()
		else
			ata_scsi_simulate()
	else
		xlat_func = atapi_get_xlat_func()
		if (xlat_func)
			atapi_scsi_translate()
		else
			atapi_scsi_simulate()

and then make the changes that logically fall from that.

	Jeff


