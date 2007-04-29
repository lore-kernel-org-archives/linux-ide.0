From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 09/13] libata-acpi: clean up ata_acpi_exec_tfs()
Date: Sun, 29 Apr 2007 11:56:46 +0900
Message-ID: <4634096E.2060708@gmail.com>
References: <1177263666341-git-send-email-htejun@gmail.com> <463399C4.80505@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.233]:48262 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754228AbXD2C5n (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 28 Apr 2007 22:57:43 -0400
Received: by wr-out-0506.google.com with SMTP id 76so1296794wra
        for <linux-ide@vger.kernel.org>; Sat, 28 Apr 2007 19:57:42 -0700 (PDT)
In-Reply-To: <463399C4.80505@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: mjg59@srcf.ucam.org, rdunlap@xenotime.net, trenn@suse.de, alan@lxorguk.ukuu.org.uk, forrest.zhao@gmail.com, kristen.c.accardi@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
>> This patch cleans up ata_acpi_exec_tfs() and its friends.
>>
>> * Rename taskfile_array to ata_acpi_gtf and make it __packed as it's
>>   used as argument to ACPI method, and use pointer to ata_acpi_gtf and
>>   number of taskfiles to represent _GTF taskfiles instead of a pointer
>>   casted into unsigned long and byte count.  This makes argument
>>   re-checking in do_drive_set_taskfiles() unnecessary.
>>
>> * Pointer in void * not in unsigned long.
>>
>> * Clean up do_drive_get_GTF() error handling and make
>>   do_drive_get_GTF() return number of taskfiles on success, 0 if _GTF
>>   doesn't exist or doesn't contain valid ata.  -errno on other errors.
>>
>> * Remove superflous check for acpi->buffer.pointer.
>>
>> * Update taskfile_load_raw() such that printed messages look similar
>>   to the messages printed by ata_eh_report().
>>
>> Signed-off-by: Tejun Heo <htejun@gmail.com>
>> ---
>>  drivers/ata/libata-acpi.c |  219
>> ++++++++++++++++++++++-----------------------
>>  1 files changed, 107 insertions(+), 112 deletions(-)
> 
> ACK
> 
> As an aside, I hate the "do_" prefix on functions.  It is utterly
> redundant.

Okay, will drop.

-- 
tejun
