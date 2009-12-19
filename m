From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [git patches] libata updates
Date: Sat, 19 Dec 2009 15:11:11 -0500
Message-ID: <4B2D335F.6050705@garzik.org>
References: <20091219181350.GA21058@havoc.gtf.org> <alpine.LFD.2.00.0912191102320.3712@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yx0-f187.google.com ([209.85.210.187]:64410 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753353AbZLSULO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 19 Dec 2009 15:11:14 -0500
In-Reply-To: <alpine.LFD.2.00.0912191102320.3712@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, saeed bishara <saeed.bishara@gmail.com>

On 12/19/2009 02:05 PM, Linus Torvalds wrote:
> On Sat, 19 Dec 2009, Jeff Garzik wrote:
>>
>> to receive the following updates:
>>
>>   drivers/ata/libata-scsi.c    |    2 +-
>>   drivers/ata/libata-sff.c     |    2 +-
>>   drivers/ata/pata_hpt3x2n.c   |   64 ++++++++++---------
>>   drivers/ata/pata_octeon_cf.c |    2 +-
>>   drivers/ata/sata_mv.c        |  144 ++++++++++++++++++++++++++++++++++++------
>>   5 files changed, 163 insertions(+), 51 deletions(-)
>>   mode change 100644 =>  100755 drivers/ata/sata_mv.c
>
> WTF is that mode change?
>
> It's introduced by commit 6481f2b52cd5411ea6342b749daf0e4f3b390d7b:
> "sata_mv: add power management support for the platform driver", and it's
> totally nonsensical.
>
> I fixed that crazy stuff when merging, but you should look at your own
> summaries a bit, and should have noticed that it was crazy. That file
> isn't an executable.

Whoops, you're absolutely right.  That's broken.

	Jeff



