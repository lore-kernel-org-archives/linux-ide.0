Received: from nick.sneptech.io (nick.sneptech.io [178.62.38.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECE118E1F
	for <linux-ide@vger.kernel.org>; Tue, 18 Feb 2025 03:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.38.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739849150; cv=none; b=qq0Cw6WoV0eyrJe6mQFO1+xasxeO3ewCiw1QCHjfdheSfkqxegSCW1V1JFMF/VoFC/RT8xdfoNZ0J79OV7vn/3buVp9G71uJIm4QC7woCvtBIrPlyyY8DYg4l2MkmXC79mlbqE6cH5OYnJF+zMgDRKVtio5pSlMzBHbB8AGrycE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739849150; c=relaxed/simple;
	bh=NaTCpm6voOImEkU+ykjdU2L/Vp+ngN/mV+5D2xZqJQc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ipttYbEEml3L/bk+PQDTeqZ/TvuuCzm7iYbn6sK+OIUbMTahQSnnJIyil3BSOu7hQ0PfXvoh0Sx4Bfo2se6c/vChB0nmChB+o3Qx7mrgVJiNIbjwz/FSJsKOJ7K8nxCRk0hF6aiRGfEHR0ocNAgM40E55KOM0ssqHOYsHJHe4fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=philpem.me.uk; spf=pass smtp.mailfrom=philpem.me.uk; dkim=pass (1024-bit key) header.d=philpem.me.uk header.i=@philpem.me.uk header.b=xfNwkcsE; arc=none smtp.client-ip=178.62.38.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=philpem.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=philpem.me.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=philpem.me.uk header.i=@philpem.me.uk header.b="xfNwkcsE"
Received: from wolf.philpem.me.uk (148.163.187.81.in-addr.arpa [81.187.163.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	(Authenticated sender: mailrelay_wolf@philpem.me.uk)
	by nick.sneptech.io (Postfix) with ESMTPSA id B624BBD45F;
	Tue, 18 Feb 2025 03:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=philpem.me.uk;
	s=mail; t=1739847949;
	bh=NaTCpm6voOImEkU+ykjdU2L/Vp+ngN/mV+5D2xZqJQc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=xfNwkcsEst8Dxycc6IeReBeMGkhWU7ZDp3GnZqArAUXYc8cVoR/EIyFcs8yU4XOge
	 35nV42fd/DdQwiBxhileVhtRpuXYS4I/bAwcYzycz7BXc9enJYtdCrIPK8UWiQ1RlW
	 Pu1aaK+dQDuoymX6NKrgD9TrmhUhTGWNAVrRIgpk=
Received: from [10.0.0.32] (cheetah.homenet.philpem.me.uk [10.0.0.32])
	by wolf.philpem.me.uk (Postfix) with ESMTPSA id EA1AE5FC96;
	Tue, 18 Feb 2025 03:05:48 +0000 (GMT)
Message-ID: <9253b1b9-0f92-45ab-8b8a-44064ffa9cd9@philpem.me.uk>
Date: Tue, 18 Feb 2025 03:05:49 +0000
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Zip 100 ATAPI not working, "qc timeout" and "failed to clear UNIT
 ATTENTION"
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org
References: <c6722ee8-5e21-4169-af59-cbbae9edc02f@philpem.me.uk>
 <Z36GMwr49ihd2nAG@ryzen> <e1985151-c206-4be1-91c1-92eac16f6236@philpem.me.uk>
 <Z3-_dt0m_2UrtKon@ryzen> <e1b79ece-b4b2-42e5-b259-290820324b5e@philpem.me.uk>
 <Z4pdD1Z2mJnF7N3O@ryzen> <2bb1510c-c42f-468b-a8cb-70603bee846b@philpem.me.uk>
 <Z5NlVjIMp6Wo8dQd@ryzen>
Content-Language: en-GB
From: Philip Pemberton <lists@philpem.me.uk>
In-Reply-To: <Z5NlVjIMp6Wo8dQd@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Niklas,

On 24/01/2025 10:03, Niklas Cassel wrote:
> Did you try using the same mode as the ata_piix machine? e.g. PIO0/PIO3/DMA.

Yes, I let the kernel autodetect the mode. PIIX didn't rell me what PIO 
mode it had selected.

> You didn't paste the dmesg from the ata_piix driver.
> Did it have ", DMADIR" as part of the string that prints the device?
> i.e.
> "[    4.135599] ata4.00: ATAPI: IOMEGA  ZIP 100       ATAPI, 12.A, max PIO3, CDB intr"

No, there was no mention of DMADIR on the PIIX or the AHCI system.


> I wonder which bug there could be in the ahci driver that allows it to work
> with a lot of ATAPI devices, but not your "SATA to PATA adapter + Zip drive".

I've built a kernel from source tonight (6.10 from the Debian source) 
and added some printk's to try and figure out what's going on.

Starting with the AHCI system...

When the function atapi_eh_clear_ua() [libata-eh.c:3294] is entered, the 
driver sends a SCSI "TEST UNIT READY" (scsicmd 0) CDB inside an ATAPI 
packet command (cmd 0xa0):

[    4.408044] ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    4.408107] ata4.00: direction 2 dmadir 0
[    4.414687] ata4.00: ATAPI: IOMEGA  ZIP 100       ATAPI, 12.A, max 
PIO3, CDB intr
[    4.414815] ata4.00: applying bridge limits
[    4.414870] ata4.00: direction 3 dmadir 0
[    4.415153] ata4.00: direction 2 dmadir 0
[    4.421662] ata4.00: configured for PIO3
[    4.421768] ata4.00: About to do TEST UNIT READY
[    4.421770] ata4.00: CDB[0] = 0x00
[    4.421824] ata4.00: CDB[1] = 0x00
[    4.421876] ata4.00: CDB[2] = 0x00
[    4.421929] ata4.00: CDB[3] = 0x00
[    4.421981] ata4.00: CDB[4] = 0x00
[    4.422033] ata4.00: CDB[5] = 0x00
[    4.422085] ata4.00: CDB[6] = 0x00
[    4.422138] ata4.00: CDB[7] = 0x00
[    4.422190] ata4.00: CDB[8] = 0x00
[    4.422242] ata4.00: CDB[9] = 0x00
[    4.422294] ata4.00: CDB[10] = 0x00
[    4.422347] ata4.00: CDB[11] = 0x00
[    4.422399] ata4.00: CDB[12] = 0x00
[    4.422452] ata4.00: CDB[13] = 0x00
[    4.422504] ata4.00: CDB[14] = 0x00
[    4.422556] ata4.00: CDB[15] = 0x00
[    4.422609] ata4.00: direction 3 dmadir 0
[    4.423185] ata4.00: TEST UNIT READY err_mask=1 sense_key=6

This fails with err_mask=1 (AC_ERR_DEV=1, "device reported error", 
defined in libata.h). Sense key 6 is UNIT ATTENTION, per 
<https://www.t10.org/lists/2sensekey.htm>.

The code then goes on to send a SCSI "REQUEST SENSE" CDB (scsicmd 0x03) 
in an attempt to clear the UNIT ATTENTION flag. It's this command which 
times out:

[    4.423239] ata4.00: CDB[0] = 0x03
[    4.423295] ata4.00: CDB[1] = 0x00
[    4.423347] ata4.00: CDB[2] = 0x00
[    4.423399] ata4.00: CDB[3] = 0x00
[    4.423452] ata4.00: CDB[4] = 0x60
[    4.423504] ata4.00: CDB[5] = 0x00
[    4.423556] ata4.00: CDB[6] = 0x00
[    4.423609] ata4.00: CDB[7] = 0x00
[    4.423661] ata4.00: CDB[8] = 0x00
[    4.423713] ata4.00: CDB[9] = 0x00
[    4.423765] ata4.00: CDB[10] = 0x00
[    4.423817] ata4.00: CDB[11] = 0x00
[    4.423870] ata4.00: CDB[12] = 0x00
[    4.423922] ata4.00: CDB[13] = 0x00
[    4.423974] ata4.00: CDB[14] = 0x00
[    4.424026] ata4.00: CDB[15] = 0x00
[    4.424079] ata4.00: direction 2 dmadir 0
[    9.556040] ata4.00: qc timeout after 5000 msecs (cmd 0xa0 cdb[0] 0x3)
[    9.556155] ata4.00: REQUEST SENSE err_mask=5 sense_key=6

It does this for PIO3 and PIO2.


Back onto the PIIX the drive initialises, then there seem to be a couple 
of non-ATAPI commands:

[    4.564157] ata4.00: ATAPI: IOMEGA  ZIP 100       ATAPI, 12.A, max 
PIO3, CDB intr
[    4.564223] ata4.00: applying bridge limits
[    4.564270] ata4.00: direction 3 dmadir 0
[    4.566480] ata4.00: direction 2 dmadir 0

TEST UNIT READY gives the same response:

[    4.588159] ata4.00: About to do TEST UNIT READY
[    4.588167] ata4.00: CDB[0] = 0x00
[    4.588214] ata4.00: CDB[1] = 0x00
[    4.588256] ata4.00: CDB[2] = 0x00
[    4.588297] ata4.00: CDB[3] = 0x00
[    4.588339] ata4.00: CDB[4] = 0x00
[    4.588380] ata4.00: CDB[5] = 0x00
[    4.588421] ata4.00: CDB[6] = 0x00
[    4.588462] ata4.00: CDB[7] = 0x00
[    4.588504] ata4.00: CDB[8] = 0x00
[    4.588545] ata4.00: CDB[9] = 0x00
[    4.588586] ata4.00: CDB[10] = 0x00
[    4.588627] ata4.00: CDB[11] = 0x00
[    4.588669] ata4.00: CDB[12] = 0x00
[    4.588710] ata4.00: CDB[13] = 0x00
[    4.588751] ata4.00: CDB[14] = 0x00
[    4.588792] ata4.00: CDB[15] = 0x00
[    4.588834] ata4.00: direction 3 dmadir 0
[    4.589445] ata4.00: TEST UNIT READY err_mask=1 sense_key=6

But REQUEST SENSE doesn't time out:

[    4.589490] ata4.00: CDB[0] = 0x03
[    4.589534] ata4.00: CDB[1] = 0x00
[    4.589575] ata4.00: CDB[2] = 0x00
[    4.589616] ata4.00: CDB[3] = 0x00
[    4.589657] ata4.00: CDB[4] = 0x60
[    4.589698] ata4.00: CDB[5] = 0x00
[    4.589740] ata4.00: CDB[6] = 0x00
[    4.589782] ata4.00: CDB[7] = 0x00
[    4.589823] ata4.00: CDB[8] = 0x00
[    4.589864] ata4.00: CDB[9] = 0x00
[    4.589905] ata4.00: CDB[10] = 0x00
[    4.589947] ata4.00: CDB[11] = 0x00
[    4.589988] ata4.00: CDB[12] = 0x00
[    4.590029] ata4.00: CDB[13] = 0x00
[    4.590070] ata4.00: CDB[14] = 0x00
[    4.590111] ata4.00: CDB[15] = 0x00
[    4.590152] ata4.00: direction 2 dmadir 0
[    4.591250] ata4.00: REQUEST SENSE err_mask=5 sense_key=6

Then it sends TEST UNIT READY again and gets sense_key 2, drive not ready:

[    4.591294] ata4.00: About to do TEST UNIT READY
[    4.591339] ata4.00: CDB[0] = 0x00
[    4.591382] ata4.00: CDB[1] = 0x00
[    4.591423] ata4.00: CDB[2] = 0x00
[    4.591466] ata4.00: CDB[3] = 0x00
[    4.591507] ata4.00: CDB[4] = 0x00
[    4.591549] ata4.00: CDB[5] = 0x00
[    4.591590] ata4.00: CDB[6] = 0x00
[    4.591631] ata4.00: CDB[7] = 0x00
[    4.591672] ata4.00: CDB[8] = 0x00
[    4.591713] ata4.00: CDB[9] = 0x00
[    4.591754] ata4.00: CDB[10] = 0x00
[    4.591796] ata4.00: CDB[11] = 0x00
[    4.591837] ata4.00: CDB[12] = 0x00
[    4.591879] ata4.00: CDB[13] = 0x00
[    4.591920] ata4.00: CDB[14] = 0x00
[    4.591962] ata4.00: CDB[15] = 0x00
[    4.592003] ata4.00: direction 3 dmadir 0
[    4.592679] ata4.00: TEST UNIT READY err_mask=1 sense_key=2

It's then picked up as a SCSI device:

[    4.597222] scsi 3:0:0:0: Direct-Access     IOMEGA   ZIP 100 
12.A PQ: 0 ANSI: 5


Thanks.
-- 
Phil.
philpem@philpem.me.uk
https://www.philpem.me.uk/
