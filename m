Received: from mx.bauer-kirch.de (mx.bauer-kirch.de [89.238.71.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843B21514E3
	for <linux-ide@vger.kernel.org>; Tue,  2 Jul 2024 09:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.238.71.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719913956; cv=none; b=KYmB84Jdo7mY7If9Td7qb5LppcoKb7D7YpsdjyKIazB3uvqliJ1sBxidheM9KUlJyFaSVJyxkxojCywxwQeJnZSq8Ruo7ST5wEdO81hCUdchtdAni/N37Fset1QcUzBJCnM4Pma6L5pIopaC+vaX2wKbN4HFO/hgrHmrxxrWcjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719913956; c=relaxed/simple;
	bh=OTrmjTfUAM7mg5JqmG+0hXlK9L/PVrqd3zDbaLrbIdg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o7ByrnD8tV2JSPfHdEQBZ4CX6GRUOwgqAwvfHRCGH18Px8gCQ49X5eKPnkXNA7nmtJoYY0k87CqA1p9ynMAEWNG9D60xLyqDh+Z3z6pnNBHZyWHoz+AsRF4puMc/ykeDuzJlw2uAQ2+RgmJxHM5143u9okcOdYFPuscU58NRBlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=noerenberg.de; spf=pass smtp.mailfrom=noerenberg.de; arc=none smtp.client-ip=89.238.71.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=noerenberg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=noerenberg.de
Received: by mail.bauer-kirch.de with ESMTPSA id 1sOZwr-00000007w6V-0djW
	authenticated id <420001312>
	(TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128);
	Tue, 02 Jul 2024 11:37:17 +0200
Message-ID: <29b60f42-45ba-4c39-9e30-1dd4811b181d@noerenberg.de>
Date: Tue, 2 Jul 2024 11:32:21 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Marvel 88SE6121 fails with SATA-2/3 HDDs
To: Damien Le Moal <damien.lemoal@opensource.wdc.com>,
 linux-ide@vger.kernel.org
Cc: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, risc4all@yahoo.com
References: <db6b48b7-d69a-564b-24f0-75fbd6a9e543@noerenberg.de>
 <930a0685-c741-110e-40c2-660754301e5a@opensource.wdc.com>
 <a248857e-991c-16d7-496c-9dc692186ead@noerenberg.de>
 <b4a515f6-e11c-756b-ff90-114836f919f9@noerenberg.de>
 <341397a1-9da5-466d-a738-cad79e8d2390@opensource.wdc.com>
 <53372f11-1d97-5310-32e7-6368a653115f@noerenberg.de>
 <b02e3814-16a0-9bc6-01be-d53fa81d99c2@opensource.wdc.com>
From: Hajo Noerenberg <hajo-linux-ide@noerenberg.de>
In-Reply-To: <b02e3814-16a0-9bc6-01be-d53fa81d99c2@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13.02.2023 at 02:28 Damien Le Moal wrote:
> On 2/1/23 19:02, Hajo Noerenberg wrote:
>> Am 31.01.2023 um 03:34 schrieb Damien Le Moal:
>>> On 1/30/23 22:40, Hajo Noerenberg wrote
>>>> Summary: With U-Boot and kernels <3.16 the drives work, even without jumper.
>>>> I wonder if there is a way to get the drives working with up to date kernels.
>>>> This would have the benefit of a.) no need to set jumpers and b.) getting
>>>> bigger/newer drives like the WD30EFRX to work which probably do not have a
>>>> downgrade-jumper.
>>>

Sorry to reactivate this old thread, but it took me a really long time to
find out anything of substance.

Just to summerize again: Gen2/3 HDDs only work with the 88SE6121 controller
in the Seagate Blackarmor NAS 440 [1] if they are jumpered to Gen1 (1.5 Gbit/s).
This is unsatisfactory because they correctly work with the U-Boot bootloader
without any jumpers at Gen2 speed (3 Gbit/s).


>> I forgot to mention the main benefit: Without the "downgrade-jumper" the drives are able to run at SATA-2 speed (the 88SE6121 is a SATA-2 controller). At least with kernel 2.6.x (ahci module) one can see the ST3500418AS running at 3Gbps:
>>
>> [  151.957573] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
>> [  151.958713] ata1.00: ATA-8: ST3500418AS, CC38, max UDMA/133
>> [  151.958726] ata1.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 0/32)
>> [  151.960062] ata1.00: configured for UDMA/133
>> [  151.960397] scsi 0:0:0:0: Direct-Access     ATA      ST3500418AS      CC38 PQ: 0 ANSI: 5
>>
>> And with kernel 2.6.x even the SATA-3 WD30EFRX runs at 3Gbps as well (no jumper, no kernel option) and has full 3TB accessible:
>>
>> [  100.497589] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
>> [  100.498145] ata1.00: HPA detected: current 5860531055, native 5860533168
>> [  100.498165] ata1.00: ATA-9: WDC WD30EFRX-68EUZN0, 80.00A80, max UDMA/133
>> [  100.498177] ata1.00: 5860531055 sectors, multi 0: LBA48 NCQ (depth 0/32)
>> [  100.498853] ata1.00: configured for UDMA/133
>> [  100.499187] scsi 0:0:0:0: Direct-Access     ATA      WDC WD30EFRX-68E 80.0 PQ: 0 ANSI: 5
>>
>>> Can you try with libata.force=nolpm ? A lot of old WD drives have broken LPM.
>>>
>>
>> libata.force=nolpm slightly changes the kernel log: the drive is basically detected (the model name and drive geometry show up), but in the end it fails:
>>

After many many tests I can say that no kernel option I tried (e.g. libata.force with
nolpm, noncq, nodma, 1.5Gbps and almost all others) helps to mitigate the problem.

By chance I saw an old Debian kernel patch [2], which, when applied make Gen2
HDDs reproducibly work with 3.x kernels. After some more investigation
I figured out that similarly commenting out some lines in the interrupt handler in
libahci.c causes them to be recognized with kernel 6.x as well:

/*      if (sata_lpm_ignore_phy_events(&ap->link)) {
                status &= ~PORT_IRQ_PHYRDY;
                ahci_scr_write(&ap->link, SCR_ERROR, SERR_PHYRDY_CHG);
        }
*/

Interestingly, sata_lpm_ignore_phy_events() returns false in my setup. So, as far as
I can tell, it is not a question of the ahci_scr_write() being executed. Rather, it
is the CPU cycles that are saved by the absence of this section in the interrupt
handler. At first it was very hard for me to believe that it was due to commenting
out the section, but I have compiled several kernels that differ
only in this section: yes, it makes a difference.

To summerize, with sata_lpm_ignore_phy_events() commented out:

- with kernel 3.x HDDs are recognized (IDENTIFY 0xEC) and one can write large
  amounts of data to them without any problems.
- for kernel 6.x identifying and writing data works "almost" every time but not
  perfectly stable.
- for both 3.x and 6.x kernels, when I execute certain special commands
  (e.g. "hdparm -I"), the drive connection is reset but usually works afterwards.
- with kernel 2.x the hard disks always worked, which is reasonable, because there
  the interrupt handler never included a sata_lpm_ignore_phy_events() call.


I would be thankful if you could tell me whether and how this problem can be
solved sustainably.

Hajo


[1] https://github.com/hn/seagate-blackarmor-nas?tab=readme-ov-file#nas-440-patch-details
[2] https://salsa.debian.org/kernel-team/linux/-/blob/debian/3.16.39-1_bpo70+1/debian/patches/debian/revert-libata-ignore-spurious-phy-event-on-lpm-polic.patch?ref_type=tags

