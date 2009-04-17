From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH 5/5] libata: Add support for TRIM
Date: Fri, 17 Apr 2009 15:44:47 -0400
Message-ID: <49E8DC2F.8050307@rtr.ca>
References: <1238683047-13588-1-git-send-email-willy@linux.intel.com> <1238683047-13588-2-git-send-email-willy@linux.intel.com> <1238683047-13588-3-git-send-email-willy@linux.intel.com> <1238683047-13588-4-git-send-email-willy@linux.intel.com> <1238683047-13588-5-git-send-email-willy@linux.intel.com> <49E79445.3080806@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:33075 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751330AbZDQTou (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 17 Apr 2009 15:44:50 -0400
In-Reply-To: <49E79445.3080806@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matthew Wilcox <willy@linux.intel.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, jgarzik@redhat.com

Mark Lord wrote:
> Matthew Wilcox wrote:
>> Signed-off-by: Matthew Wilcox <willy@linux.intel.com>
>> ---
>>  drivers/ata/libata-scsi.c |   46 
>> +++++++++++++++++++++++++++++++++++++++++++++
>>  1 files changed, 46 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
>> index b9747fa..d4c8b8b 100644
>> --- a/drivers/ata/libata-scsi.c
>> +++ b/drivers/ata/libata-scsi.c
> ...
> 
> It works.  :)
> 
> I'm using TRIM on a 120GB OCZ Vertex SSD here now,
..

I take that back now.  The command is apparently failing,
but we don't log the failure, and nor do we stop attempting
to continue to use it on future TRIMs.

I dug deeper into the kernel side, when my own attempts in hdparm
all failed, both using SG_IO directly and using the BLKDISCARD ioctl().

The commands are simply rejected by the drive, with status=0x51, err=0x04.

Everything *looks* okay on the Linux side, so I'm guessing that the OCZ
drive uses a vendor-unique opcode or protocol for it.  They do have it
in there for a windows tool, but no further info than that.

-ml
