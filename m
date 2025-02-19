Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62FF1A4E77
	for <linux-ide@vger.kernel.org>; Wed, 19 Feb 2025 15:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739980139; cv=none; b=qG8vECEvFnBjRJDVUSWNXDOTYqtCPe04eIQSgbFnBZycyb9nF3vyu+p7tCMLl2ZZE32V/x/LZXCIm1b37XOx8uoC3qEVH4E24dALy7tVJb3ATTeNx7dzuDU3hd1petbXFu4ba6svy7soyDBQGk8N34yXsXjvUOHhFDD1aYXfd/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739980139; c=relaxed/simple;
	bh=SybDlp7F/OBvQeigJTI678A8AKC/l3p22qh/ZyCiKBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DwSOiXWYADxCzUPBm9e8JW+T8rzb2xfTuaEE1bYsXiEqIrWT+tT6hZBNp40x6Vnd246OMWbpuYn0lJzWESMBDiUmG+dPCXAvlilwVi5bxBC42Vbu5NcjWVCj+IWV5n9J8ldXSeVAhM0Mka+mzFB3XccAc0W2/U3bcuPNdBRmkTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sda3Zh9g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sda3Zh9g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A13B8C4CED1;
	Wed, 19 Feb 2025 15:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739980139;
	bh=SybDlp7F/OBvQeigJTI678A8AKC/l3p22qh/ZyCiKBk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sda3Zh9gsphdMp5pKdB8EIUr5oKDSvvHF7oVCRgBUe6LJDMU9CXbOdo7rDx1DYhH+
	 g8nE8LZg19eO4VGXPK8zs4lJJKVFvJ5EpaOl4vlGgcBmoLw8y5vuN4kt48T10lbVJR
	 3BazhPSOjgnqO3AAo3jv/jU0yej9TuL8TMRzZQf7ws2j0jketM9UajRoAOBnrXwIFv
	 uTazIk4vr5Jgg7ifBLc7+zqw7CERL2Pzt44xkH2Y/BJFdbEnDCrYd6c6fz9JEv8pmH
	 tzYkva5e/F+Hu3kEBvJqLx1RHDLhrGQB2MtDryL/pI++V7YcTuxwMcj4rSUuZBI00n
	 sxh21iSkjC9Ig==
Date: Wed, 19 Feb 2025 16:48:56 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Philip Pemberton <lists@philpem.me.uk>
Cc: linux-ide@vger.kernel.org
Subject: Re: Zip 100 ATAPI not working, "qc timeout" and "failed to clear
 UNIT ATTENTION"
Message-ID: <Z7X9aPpgBjNln9CJ@ryzen>
References: <c6722ee8-5e21-4169-af59-cbbae9edc02f@philpem.me.uk>
 <Z36GMwr49ihd2nAG@ryzen>
 <e1985151-c206-4be1-91c1-92eac16f6236@philpem.me.uk>
 <Z3-_dt0m_2UrtKon@ryzen>
 <e1b79ece-b4b2-42e5-b259-290820324b5e@philpem.me.uk>
 <Z4pdD1Z2mJnF7N3O@ryzen>
 <2bb1510c-c42f-468b-a8cb-70603bee846b@philpem.me.uk>
 <Z5NlVjIMp6Wo8dQd@ryzen>
 <9253b1b9-0f92-45ab-8b8a-44064ffa9cd9@philpem.me.uk>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9253b1b9-0f92-45ab-8b8a-44064ffa9cd9@philpem.me.uk>

Hello Philip,

On Tue, Feb 18, 2025 at 03:05:49AM +0000, Philip Pemberton wrote:
> When the function atapi_eh_clear_ua() [libata-eh.c:3294] is entered, the
> driver sends a SCSI "TEST UNIT READY" (scsicmd 0) CDB inside an ATAPI packet
> command (cmd 0xa0):
> 
> [    4.408044] ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> [    4.408107] ata4.00: direction 2 dmadir 0
> [    4.414687] ata4.00: ATAPI: IOMEGA  ZIP 100       ATAPI, 12.A, max PIO3,
> CDB intr
> [    4.414815] ata4.00: applying bridge limits
> [    4.414870] ata4.00: direction 3 dmadir 0
> [    4.415153] ata4.00: direction 2 dmadir 0
> [    4.421662] ata4.00: configured for PIO3
> [    4.421768] ata4.00: About to do TEST UNIT READY
> [    4.421770] ata4.00: CDB[0] = 0x00
> [    4.421824] ata4.00: CDB[1] = 0x00
> [    4.421876] ata4.00: CDB[2] = 0x00
> [    4.421929] ata4.00: CDB[3] = 0x00
> [    4.421981] ata4.00: CDB[4] = 0x00
> [    4.422033] ata4.00: CDB[5] = 0x00
> [    4.422085] ata4.00: CDB[6] = 0x00
> [    4.422138] ata4.00: CDB[7] = 0x00
> [    4.422190] ata4.00: CDB[8] = 0x00
> [    4.422242] ata4.00: CDB[9] = 0x00
> [    4.422294] ata4.00: CDB[10] = 0x00
> [    4.422347] ata4.00: CDB[11] = 0x00
> [    4.422399] ata4.00: CDB[12] = 0x00
> [    4.422452] ata4.00: CDB[13] = 0x00
> [    4.422504] ata4.00: CDB[14] = 0x00
> [    4.422556] ata4.00: CDB[15] = 0x00
> [    4.422609] ata4.00: direction 3 dmadir 0
> [    4.423185] ata4.00: TEST UNIT READY err_mask=1 sense_key=6
> 
> This fails with err_mask=1 (AC_ERR_DEV=1, "device reported error", defined
> in libata.h). Sense key 6 is UNIT ATTENTION, per
> <https://www.t10.org/lists/2sensekey.htm>.
> 
> The code then goes on to send a SCSI "REQUEST SENSE" CDB (scsicmd 0x03) in
> an attempt to clear the UNIT ATTENTION flag. It's this command which times
> out:
> 
> [    4.423239] ata4.00: CDB[0] = 0x03
> [    4.423295] ata4.00: CDB[1] = 0x00
> [    4.423347] ata4.00: CDB[2] = 0x00
> [    4.423399] ata4.00: CDB[3] = 0x00
> [    4.423452] ata4.00: CDB[4] = 0x60
> [    4.423504] ata4.00: CDB[5] = 0x00
> [    4.423556] ata4.00: CDB[6] = 0x00
> [    4.423609] ata4.00: CDB[7] = 0x00
> [    4.423661] ata4.00: CDB[8] = 0x00
> [    4.423713] ata4.00: CDB[9] = 0x00
> [    4.423765] ata4.00: CDB[10] = 0x00
> [    4.423817] ata4.00: CDB[11] = 0x00
> [    4.423870] ata4.00: CDB[12] = 0x00
> [    4.423922] ata4.00: CDB[13] = 0x00
> [    4.423974] ata4.00: CDB[14] = 0x00
> [    4.424026] ata4.00: CDB[15] = 0x00
> [    4.424079] ata4.00: direction 2 dmadir 0
> [    9.556040] ata4.00: qc timeout after 5000 msecs (cmd 0xa0 cdb[0] 0x3)
> [    9.556155] ata4.00: REQUEST SENSE err_mask=5 sense_key=6


If we look at code in atapi_eh_clear_ua(), it is a for loop that will run
for up to ATA_EH_UA_TRIES number of times.

For e.g. the case with your PIIX controller, it manages to clear Unit
Attention successfully on the second try.

The reason why it does not perform more than one try on your AHCI
controller is because atapi_eh_request_sense() returns AC_ERR_TIMEOUT,
which causes the code to return and not perform additional iterations/retries.

Looking at atapi_eh_request_sense(), I can see this code:
https://github.com/torvalds/linux/blob/v6.14-rc3/drivers/ata/libata-eh.c#L1545-L1553

	/* is it pointless to prefer PIO for "safety reasons"? */
	if (ap->flags & ATA_FLAG_PIO_DMA) {
		tf.protocol = ATAPI_PROT_DMA;
		tf.feature |= ATAPI_PKT_DMA;
	} else {
		tf.protocol = ATAPI_PROT_PIO;
		tf.lbam = SCSI_SENSE_BUFFERSIZE;
		tf.lbah = 0;
	}


Looking at ahci.c, we can see that all boards have .flags set to:
AHCI_FLAG_COMMON
which is defined as:

        AHCI_FLAG_COMMON                = ATA_FLAG_SATA | ATA_FLAG_PIO_DMA |
                                          ATA_FLAG_ACPI_SATA | ATA_FLAG_AN,


ATA_FLAG_PIO_DMA is defined as:
ATA_FLAG_PIO_DMA        = (1 << 7), /* PIO cmds via DMA */

Which, IIUC, seems to mean that atapi_eh_request_sense() will use DMA even
for a port configured to use PIO.


This flag does not appear to be set for any board in the PIIX driver.

Perhaps your could try with something like:

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 3b303d4ae37a..bc2a317c97da 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1543,7 +1543,7 @@ unsigned int atapi_eh_request_sense(struct ata_device *dev,
        tf.command = ATA_CMD_PACKET;
 
        /* is it pointless to prefer PIO for "safety reasons"? */
-       if (ap->flags & ATA_FLAG_PIO_DMA) {
+       if (0) {
                tf.protocol = ATAPI_PROT_DMA;
                tf.feature |= ATAPI_PKT_DMA;
        } else {

To see if NOT using DMA for PIO cmds makes any difference.


> 
> Back onto the PIIX the drive initialises, then there seem to be a couple of
> non-ATAPI commands:
> 
> [    4.564157] ata4.00: ATAPI: IOMEGA  ZIP 100       ATAPI, 12.A, max PIO3,
> CDB intr
> [    4.564223] ata4.00: applying bridge limits
> [    4.564270] ata4.00: direction 3 dmadir 0
> [    4.566480] ata4.00: direction 2 dmadir 0


Perhaps you would want to figure out what these commands are,
to know if the lack of these commands on AHCI could be related
to things not working on AHCI.



Kind regards,
Niklas
