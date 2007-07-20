From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 02/21] libata: add @is_cmd to ata_tf_to_fis()
Date: Fri, 20 Jul 2007 08:20:58 -0400
Message-ID: <46A0A8AA.8020008@garzik.org>
References: <1184563778203-git-send-email-htejun@gmail.com> <46A0A450.8070003@garzik.org> <46A0A825.9010201@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:50108 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755198AbXGTMVB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 20 Jul 2007 08:21:01 -0400
In-Reply-To: <46A0A825.9010201@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Forrest Zhao <forrest.zhao@gmail.com>

Tejun Heo wrote:
> Jeff Garzik wrote:
>> Tejun Heo wrote:
>>> Add @is_cmd to ata_tf_to_fis().  This controls bit 7 of the second
>>> byte which tells the device whether this H2D FIS is for a command or
>>> not.  This cleans up ahci a bit and will be used by PMP.
>>>
>>> Signed-off-by: Tejun Heo <htejun@gmail.com>
>>> ---
>>>  drivers/ata/ahci.c        |   10 ++++------
>>>  drivers/ata/libata-core.c |   14 ++++++++------
>>>  drivers/ata/sata_qstor.c  |    2 +-
>>>  drivers/ata/sata_sil24.c  |    2 +-
>>>  include/linux/libata.h    |    3 ++-
>>>  5 files changed, 16 insertions(+), 15 deletions(-)
>> applied 2-14
> 
> Hmmm... Where did patch 1 go?  Did you receive it?

It was one of several copies I received :)


