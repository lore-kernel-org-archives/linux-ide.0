Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB092158878
	for <linux-ide@vger.kernel.org>; Tue,  2 Jul 2024 10:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719915668; cv=none; b=ooObMZDoxpWO9QDxM3kzJMYaJCNnxkcBymdPNEsq5xyoYvRhvM7g9zp2xiLcNZtFWH6aCfFhPRvTu3gcLxguNh6+vv4h6+gD9pEBCHtUIT3+4kmu0ZtobKgITIZr88HU9RMgPGd7ap76eKtwt0Ji/vI5NHp0gANvmeiPI1E2X+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719915668; c=relaxed/simple;
	bh=Fx2me8bPO/xJndh6DxXz4L7RU2HwuW5ogn40qSHv3f4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ESw8ZHM/L1UyL+vYNCVXyq/eVyXjItomw2kNqWE0oFkfL4tqZgFUEbhNCPp2Hc0XALbEMs+9ht2rBQuBaURF6QuoUSAP3sQRBX3eKFc3SeO9ye8CbBJnbMIU8b5E1p9O43VPzi1BAXTM7KZ/YTUEl/1bFFMDfhxAmvUTOi9zJFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pu1kGDER; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pu1kGDER"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92F50C4AF0C;
	Tue,  2 Jul 2024 10:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719915668;
	bh=Fx2me8bPO/xJndh6DxXz4L7RU2HwuW5ogn40qSHv3f4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pu1kGDERL8tjvntH9NxyZwZOXh1VoBh0v7U7KVm7sjgE5l09pylo8hBHEgU2zWran
	 4RYrK3Uq0uBhxL7xWmtn9kDbxITm03wRWiE5Ob1T/+AVcYYtovrem2a/3iDnU29+ZW
	 b0QL3Gi0bC6VlsZPZOG3C2fqMFReALJedzweexWjgxle6NTzyBgoTyZ+nObriV01rA
	 JM4HGPby2cpb/GRpBUInT/NGMoh/kdOAKhclGcavULT21rzRYOg89JM/Wa6TnxcEH2
	 ekzRctwxBJv/HlzLagygSWmdWxKewntRMs5t41Kg2NfdlU8qIRFE6gvoOHQ3vHDghP
	 YaYnqO/xmgWzA==
Message-ID: <0d097346-c990-4c48-bab4-ab4259ee242f@kernel.org>
Date: Tue, 2 Jul 2024 19:21:06 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Marvel 88SE6121 fails with SATA-2/3 HDDs
To: Hajo Noerenberg <hajo-linux-ide@noerenberg.de>,
 Damien Le Moal <damien.lemoal@opensource.wdc.com>, linux-ide@vger.kernel.org
Cc: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, risc4all@yahoo.com
References: <db6b48b7-d69a-564b-24f0-75fbd6a9e543@noerenberg.de>
 <930a0685-c741-110e-40c2-660754301e5a@opensource.wdc.com>
 <a248857e-991c-16d7-496c-9dc692186ead@noerenberg.de>
 <b4a515f6-e11c-756b-ff90-114836f919f9@noerenberg.de>
 <341397a1-9da5-466d-a738-cad79e8d2390@opensource.wdc.com>
 <53372f11-1d97-5310-32e7-6368a653115f@noerenberg.de>
 <b02e3814-16a0-9bc6-01be-d53fa81d99c2@opensource.wdc.com>
 <29b60f42-45ba-4c39-9e30-1dd4811b181d@noerenberg.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <29b60f42-45ba-4c39-9e30-1dd4811b181d@noerenberg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/2/24 18:32, Hajo Noerenberg wrote:
> On 13.02.2023 at 02:28 Damien Le Moal wrote:
>> On 2/1/23 19:02, Hajo Noerenberg wrote:
>>> Am 31.01.2023 um 03:34 schrieb Damien Le Moal:
>>>> On 1/30/23 22:40, Hajo Noerenberg wrote
>>>>> Summary: With U-Boot and kernels <3.16 the drives work, even without jumper.
>>>>> I wonder if there is a way to get the drives working with up to date kernels.
>>>>> This would have the benefit of a.) no need to set jumpers and b.) getting
>>>>> bigger/newer drives like the WD30EFRX to work which probably do not have a
>>>>> downgrade-jumper.
>>>>
> 
> Sorry to reactivate this old thread, but it took me a really long time to
> find out anything of substance.
> 
> Just to summerize again: Gen2/3 HDDs only work with the 88SE6121 controller
> in the Seagate Blackarmor NAS 440 [1] if they are jumpered to Gen1 (1.5 Gbit/s).
> This is unsatisfactory because they correctly work with the U-Boot bootloader
> without any jumpers at Gen2 speed (3 Gbit/s).
> 
> 
>>> I forgot to mention the main benefit: Without the "downgrade-jumper" the drives are able to run at SATA-2 speed (the 88SE6121 is a SATA-2 controller). At least with kernel 2.6.x (ahci module) one can see the ST3500418AS running at 3Gbps:
>>>
>>> [  151.957573] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
>>> [  151.958713] ata1.00: ATA-8: ST3500418AS, CC38, max UDMA/133
>>> [  151.958726] ata1.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 0/32)
>>> [  151.960062] ata1.00: configured for UDMA/133
>>> [  151.960397] scsi 0:0:0:0: Direct-Access     ATA      ST3500418AS      CC38 PQ: 0 ANSI: 5
>>>
>>> And with kernel 2.6.x even the SATA-3 WD30EFRX runs at 3Gbps as well (no jumper, no kernel option) and has full 3TB accessible:
>>>
>>> [  100.497589] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
>>> [  100.498145] ata1.00: HPA detected: current 5860531055, native 5860533168
>>> [  100.498165] ata1.00: ATA-9: WDC WD30EFRX-68EUZN0, 80.00A80, max UDMA/133
>>> [  100.498177] ata1.00: 5860531055 sectors, multi 0: LBA48 NCQ (depth 0/32)
>>> [  100.498853] ata1.00: configured for UDMA/133
>>> [  100.499187] scsi 0:0:0:0: Direct-Access     ATA      WDC WD30EFRX-68E 80.0 PQ: 0 ANSI: 5
>>>
>>>> Can you try with libata.force=nolpm ? A lot of old WD drives have broken LPM.
>>>>
>>>
>>> libata.force=nolpm slightly changes the kernel log: the drive is basically detected (the model name and drive geometry show up), but in the end it fails:
>>>
> 
> After many many tests I can say that no kernel option I tried (e.g. libata.force with
> nolpm, noncq, nodma, 1.5Gbps and almost all others) helps to mitigate the problem.
> 
> By chance I saw an old Debian kernel patch [2], which, when applied make Gen2
> HDDs reproducibly work with 3.x kernels. After some more investigation
> I figured out that similarly commenting out some lines in the interrupt handler in
> libahci.c causes them to be recognized with kernel 6.x as well:
> 
> /*      if (sata_lpm_ignore_phy_events(&ap->link)) {
>                 status &= ~PORT_IRQ_PHYRDY;
>                 ahci_scr_write(&ap->link, SCR_ERROR, SERR_PHYRDY_CHG);
>         }
> */
> 
> Interestingly, sata_lpm_ignore_phy_events() returns false in my setup. So, as far as
> I can tell, it is not a question of the ahci_scr_write() being executed. Rather, it
> is the CPU cycles that are saved by the absence of this section in the interrupt
> handler. At first it was very hard for me to believe that it was due to commenting
> out the section, but I have compiled several kernels that differ
> only in this section: yes, it makes a difference.

That is very odd. sata_lpm_ignore_phy_events() is only a couple of "if"
statements and there are no register accesses in there. So if the few CPU cycles
that takes make a difference, I would suspect that there is something odd going
on with the marvell adapter interrupts.

> To summerize, with sata_lpm_ignore_phy_events() commented out:
> 
> - with kernel 3.x HDDs are recognized (IDENTIFY 0xEC) and one can write large
>   amounts of data to them without any problems.
> - for kernel 6.x identifying and writing data works "almost" every time but not
>   perfectly stable.

So commenting out that "if (sata_lpm_ignore_phy_events)" hunk is not enough to
fix your issue then. This hunk may not be directly related to the issue and
commenting it out simply changes the timing making things better.

> - for both 3.x and 6.x kernels, when I execute certain special commands
>   (e.g. "hdparm -I"), the drive connection is reset but usually works afterwards.
> - with kernel 2.x the hard disks always worked, which is reasonable, because there
>   the interrupt handler never included a sata_lpm_ignore_phy_events() call.

But above, you said that things are not completely stable with 6.x. So there is
likely something else going on.

> I would be thankful if you could tell me whether and how this problem can be
> solved sustainably.

First things first: can you please test with the latest mainline 6.10-rc6 kernel
and send a dmesg output after boot and any other relevant output showing
problems when doing IOs ?

> 
> Hajo
> 
> 
> [1] https://github.com/hn/seagate-blackarmor-nas?tab=readme-ov-file#nas-440-patch-details
> [2] https://salsa.debian.org/kernel-team/linux/-/blob/debian/3.16.39-1_bpo70+1/debian/patches/debian/revert-libata-ignore-spurious-phy-event-on-lpm-polic.patch?ref_type=tags
> 
> 

-- 
Damien Le Moal
Western Digital Research

