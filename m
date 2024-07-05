Received: from mx.bauer-kirch.de (mx.bauer-kirch.de [89.238.71.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88EC14430E
	for <linux-ide@vger.kernel.org>; Fri,  5 Jul 2024 12:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.238.71.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720180958; cv=none; b=Na2kSMBFHrYL1W8vyJxOBTXOsfuf4E4Cl7+R+NlPR2LqTh2gSOiWuia2H48A7rGl3fSRNPMd4PJetxMrKLdk6pg4Dz0E+5AVPBfcZ/mJ86mD/sxrYCjofhJjhjiLXWNu4lrXUabc4Y/lqKOseyyc5YQadj2MFbp1vhV8vNSAzAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720180958; c=relaxed/simple;
	bh=wUhv3+kdCxOmo8OqCc+iROD6UtPvcZZ0YFbV6JNFtW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LgBn7Q0Yw0aRpmsU9agZHoSoLl0zEQtPPm0KuUbsgwawx3LqvGErKmA2aPy9Oq3XGezEAGQytkZya1GcBKfOy9skscrPaIbWKfeOCEUV9XTmxBa7SDz6B7/AX+kw2iuTwHWSb/qnrX9byag7hpxGrzqen4hD6ksArTxC3QfoKik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=noerenberg.de; spf=pass smtp.mailfrom=noerenberg.de; arc=none smtp.client-ip=89.238.71.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=noerenberg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=noerenberg.de
Received: by mail.bauer-kirch.de with ESMTPSA id 1sPhdy-0000000AIqw-2FIO
	authenticated id <420001312>
	(TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128);
	Fri, 05 Jul 2024 14:02:26 +0200
Message-ID: <e0d05674-d894-4a38-ac36-5a0ad3fcb3c8@noerenberg.de>
Date: Fri, 5 Jul 2024 14:02:25 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Marvel 88SE6121 fails with SATA-2/3 HDDs
To: Damien Le Moal <dlemoal@kernel.org>,
 Damien Le Moal <damien.lemoal@opensource.wdc.com>, linux-ide@vger.kernel.org
Cc: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, risc4all@yahoo.com,
 helgaas@kernel.org, kw@linux.com
References: <db6b48b7-d69a-564b-24f0-75fbd6a9e543@noerenberg.de>
 <930a0685-c741-110e-40c2-660754301e5a@opensource.wdc.com>
 <a248857e-991c-16d7-496c-9dc692186ead@noerenberg.de>
 <b4a515f6-e11c-756b-ff90-114836f919f9@noerenberg.de>
 <341397a1-9da5-466d-a738-cad79e8d2390@opensource.wdc.com>
 <53372f11-1d97-5310-32e7-6368a653115f@noerenberg.de>
 <b02e3814-16a0-9bc6-01be-d53fa81d99c2@opensource.wdc.com>
 <29b60f42-45ba-4c39-9e30-1dd4811b181d@noerenberg.de>
 <0d097346-c990-4c48-bab4-ab4259ee242f@kernel.org>
From: Hajo Noerenberg <hajo-linux-ide@noerenberg.de>
In-Reply-To: <0d097346-c990-4c48-bab4-ab4259ee242f@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Am 02.07.2024 um 12:21 schrieb Damien Le Moal:
>>
>> Just to summerize again: Gen2/3 HDDs only work with the 88SE6121 controller
>> in the Seagate Blackarmor NAS 440 [1] if they are jumpered to Gen1 (1.5 Gbit/s).
>> This is unsatisfactory because they correctly work with the U-Boot bootloader
>> without any jumpers at Gen2 speed (3 Gbit/s).
>>
>>
>>>>> Can you try with libata.force=nolpm ? A lot of old WD drives have broken LPM.
>>>>>
>>>>
>>>> libata.force=nolpm slightly changes the kernel log: the drive is basically detected (the model name and drive geometry show up), but in the end it fails:
>>>>
>>
>> After many many tests I can say that no kernel option I tried (e.g. libata.force with
>> nolpm, noncq, nodma, 1.5Gbps and almost all others) helps to mitigate the problem.
>>
>> By chance I saw an old Debian kernel patch [2], which, when applied make Gen2
>> HDDs reproducibly work with 3.x kernels. After some more investigation
>> I figured out that similarly commenting out some lines in the interrupt handler in
>> libahci.c causes them to be recognized with kernel 6.x as well:
>>
>> /*      if (sata_lpm_ignore_phy_events(&ap->link)) {
>>                 status &= ~PORT_IRQ_PHYRDY;
>>                 ahci_scr_write(&ap->link, SCR_ERROR, SERR_PHYRDY_CHG);
>>         }
>> */
>>
>> Interestingly, sata_lpm_ignore_phy_events() returns false in my setup. So, as far as
>> I can tell, it is not a question of the ahci_scr_write() being executed. Rather, it
>> is the CPU cycles that are saved by the absence of this section in the interrupt
>> handler. At first it was very hard for me to believe that it was due to commenting
>> out the section, but I have compiled several kernels that differ
>> only in this section: yes, it makes a difference.
> 
> That is very odd. sata_lpm_ignore_phy_events() is only a couple of "if"
> statements and there are no register accesses in there. So if the few CPU cycles
> that takes make a difference, I would suspect that there is something odd going
> on with the marvell adapter interrupts.
> 

I completely agree that this is very strange, but on the NAS440 those few lines make a difference.

There was doubt whether the PCI-MVEBU driver was working correctly, which is why I
created the bug https://bugzilla.kernel.org/show_bug.cgi?id=216094 some time ago.

Unfortunately, no significant progress could be made there. I'm CC-ing 
Bjorn Helgaas and Krzysztof Wilczyński with the kind wish to draw attention to this issue.



>> To summerize, with sata_lpm_ignore_phy_events() commented out:
>>
>> - with kernel 3.x HDDs are recognized (IDENTIFY 0xEC) and one can write large
>>   amounts of data to them without any problems.
>> - for kernel 6.x identifying and writing data works "almost" every time but not
>>   perfectly stable.
> 
> So commenting out that "if (sata_lpm_ignore_phy_events)" hunk is not enough to
> fix your issue then. This hunk may not be directly related to the issue and
> commenting it out simply changes the timing making things better.
> 
>> - for both 3.x and 6.x kernels, when I execute certain special commands
>>   (e.g. "hdparm -I"), the drive connection is reset but usually works afterwards.
>> - with kernel 2.x the hard disks always worked, which is reasonable, because there
>>   the interrupt handler never included a sata_lpm_ignore_phy_events() call.
> 
> But above, you said that things are not completely stable with 6.x. So there is
> likely something else going on.
> 
>> I would be thankful if you could tell me whether and how this problem can be
>> solved sustainably.
> 
> First things first: can you please test with the latest mainline 6.10-rc6 kernel
> and send a dmesg output after boot and any other relevant output showing
> problems when doing IOs ?
> 

I added the full boot log as attachment to the bug report above:
https://bugzilla.kernel.org/attachment.cgi?id=306531&action=edit

Please do not get confused by the number of hard disks: The relevant HDD
is the Gen2 WDC WD5000AADS in slot 1, all other disks are only for double-checking
things (Gen1 HDD for cross-testing in slot 2, slot 3+4 are always working
with sata_mv driver).

Sections in the log:

1. After system boot and "modprobe pci-mvebu" the AHCI driver fails to
detect the Gen2 HDD in slot 1 (id ata3)

2. After "rmmod && insmod"-ing libahci.ko with (only) sata_lpm_ignore_phy_events()
commented out, the Gen2 HDD is detected (id ata6 with 3Gbps).

3. Some interrupt und lspci info.

4. Temporary ata6 connection problem ("qc timeout") but survives, still able to
mount a vfat partition. No more problems after this (at least for ~24 hours).

Please let me know if I can help with other things.

Hajo
