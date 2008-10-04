From: Tejun Heo <tj@kernel.org>
Subject: Re: Interoperability problem with Quantum CD72SH SATA tape drive
 and libata
Date: Sun, 05 Oct 2008 05:45:01 +0900
Message-ID: <48E7D5CD.2000003@kernel.org>
References: <48DE96AF.6090301@runbox.com> <48E2ECA8.8060808@kernel.org> <48E40415.7050607@runbox.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010403010008020606020007"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:54068 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753168AbYJDUr1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 4 Oct 2008 16:47:27 -0400
In-Reply-To: <48E40415.7050607@runbox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: John Clark <clarkjc@runbox.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

This is a multi-part message in MIME format.
--------------010403010008020606020007
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

John Clark wrote:
>> We can create a HORKAGE for it.  Can you please post the result of
>> "hdparm -I" of the device?
>>
>>   
> Tejun,
> 
> Here it is:
> 
> /dev/nst0:
> 
> ATAPI Sequential-access device, with removable media
>    Model Number:       QUANTUM DAT    DAT72-000

Can you please test the attached patch?

Alan, John Clark is reporting that the above tape drive chokes on odd
byte PIO transfer, so the default condition check (qc->nbytes & 15) in
atapi_check_dma() breaks the SATA tape drive, so there's always one
which breaks the other way around.  :-(

For the time being, I think the horkage should do.  I was wondering
whether you still think we should lift the default mod16 check in
atapi_check_dma().

Thanks.

-- 
tejun

--------------010403010008020606020007
Content-Type: text/x-patch;
 name="horkage_atapi_mod16_dma.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="horkage_atapi_mod16_dma.patch"

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 1ee9499..e97afce 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4023,6 +4023,7 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 
 	/* Weird ATAPI devices */
 	{ "TORiSAN DVD-ROM DRD-N216", NULL,	ATA_HORKAGE_MAX_SEC_128 },
+	{ "QUANTUM DAT    DAT72-000", NULL,	ATA_HORKAGE_ATAPI_MOD16_DMA },
 
 	/* Devices we expect to fail diagnostics */
 
@@ -4436,7 +4437,8 @@ int atapi_check_dma(struct ata_queued_cmd *qc)
 	/* Don't allow DMA if it isn't multiple of 16 bytes.  Quite a
 	 * few ATAPI devices choke on such DMA requests.
 	 */
-	if (unlikely(qc->nbytes & 15))
+	if (!(qc->dev->horkage & ATA_HORKAGE_ATAPI_MOD16_DMA) &&
+	    unlikely(qc->nbytes & 15))
 		return 1;
 
 	if (ap->ops->check_atapi_dma)
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 8bb81d0..9d903b3 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -371,6 +371,8 @@ enum {
 	ATA_HORKAGE_IPM		= (1 << 7),	/* Link PM problems */
 	ATA_HORKAGE_IVB		= (1 << 8),	/* cbl det validity bit bugs */
 	ATA_HORKAGE_STUCK_ERR	= (1 << 9),	/* stuck ERR on next PACKET */
+	ATA_HORKAGE_ATAPI_MOD16_DMA = (1 << 10), /* use ATAPI DMA for commands
+						    not multiple of 16 bytes */
 
 	 /* DMA mask for user DMA control: User visible values; DO NOT
 	    renumber */

--------------010403010008020606020007--
