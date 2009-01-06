From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 7/7] libata: Add 32bit PIO support
Date: Tue, 06 Jan 2009 15:47:37 +0300
Message-ID: <496352E9.9030101@ru.mvista.com>
References: <20090105141102.28189.44312.stgit@localhost.localdomain> <20090105141619.28189.6174.stgit@localhost.localdomain> <4962AE92.5060401@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:20946 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750711AbZAFMrn (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Jan 2009 07:47:43 -0500
In-Reply-To: <4962AE92.5060401@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, jeff@garzik.org, linux-ide@vger.kernel.org

Hello.

Robert Hancock wrote:

>> This matters for some controllers and in one or two cases almost doubles
>> PIO performance. Add a bmdma32 operations set we can inherit and 
>> activate
>> it for some controllers
>>
>> Signed-off-by: Alan Cox <alan@redhat.com>
>> ---
>>
>>  drivers/ata/ata_piix.c    |    2 +-
>>  drivers/ata/libata-sff.c  |   53 
>> +++++++++++++++++++++++++++++++++++++++++++++
>>  drivers/ata/pata_ali.c    |    6 +++--
>>  drivers/ata/pata_amd.c    |    4 ++-
>>  drivers/ata/pata_mpiix.c  |    3 ++-
>>  drivers/ata/pata_sil680.c |    4 ++-
>>  include/linux/libata.h    |    3 +++
>>  7 files changed, 66 insertions(+), 9 deletions(-)
>
> This can likely be enabled for more controllers (presumably all the 
> SFF-based SATA controllers as well as any other PATA that couldn't be 
> on a physical ISA bus).

   Why are you so sure? Some controllers only support 32-bit accesses 
when prefetch is enabled, some may not support it at all...

> This is a start though.
>
> Don't some of the VLB controller drivers have their own private 32-bit 
> PIO implementation? Those should likely be updated to use this support.

   You mean sequence of 3 reads of some non-datra register?

MBR, Sergei


