Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5877F3C0C
	for <linux-ide@vger.kernel.org>; Mon,  8 Jul 2024 03:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720409398; cv=none; b=G4nJB/ppeJhb4slPJ8KUwLZP9r9twTQ8L9zFu8CuURYr1ZW7/6V2uSxJR1ULtfnTL0aH/CbIqiMuA3kBWzYW2STwReFcPMZUaA/IhYqD9GIxlFo1I8F89P8pvXxEefNEf+WBwvxOSILVniCR2QdheXRvALTNgCpO07wKcE1PxZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720409398; c=relaxed/simple;
	bh=R2QvOQvU8G3EgeR62WeJyOiap34lM//HAqGTmyjhAiE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tAEVjH3vQGFUbdeAxGtUe44/ZP6zU0NNM6OtZG972hWT7DAwYKppz7FdWfhG3st4xD8pRKOs6yd8va01EdIMAc1Nz52PJr9/yzV37Zer+cifKgFvo/yzi+3J+QJnsh7m5kf4AaOEXdoX8cdIiWlgf5CE6BgBpfvJsFYXC3pOAYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hi/Q6zNU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hi/Q6zNU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4920C3277B;
	Mon,  8 Jul 2024 03:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720409397;
	bh=R2QvOQvU8G3EgeR62WeJyOiap34lM//HAqGTmyjhAiE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Hi/Q6zNUVYRmorGqQllMr/rVyprcTrcyaP9EOP+HV4jmxZPt6UkiNeZwYrKS3PBzY
	 w/TBb1VEFrmduPE5bu1TSD9W8LE+5YIuboU0U0ORGeWsLNrg2WlCgcC0KAfIBSViRU
	 Y+58ABBwOCdPUlCIaodSABCxqPOQXCSstbF4+oY+Qfzms9t5IFDAEijCwh7vfaAoCX
	 /GGMAOmWXL/uB4az8PU3vukD72Vv6tvxYMAU7Mmsk1pXQlscZVX6FGE2Go6SeqPVNg
	 4XcHycD4uEYLycLW13soD4it8lpJEFzMnocXA/VaP+akAX2oYDdShRH3Khy+VVj8ct
	 exeCjMErbf0yw==
Message-ID: <4a378f93-7f4e-4787-adaf-0012bb78f029@kernel.org>
Date: Mon, 8 Jul 2024 12:29:55 +0900
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
 <e0d05674-d894-4a38-ac36-5a0ad3fcb3c8@noerenberg.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <e0d05674-d894-4a38-ac36-5a0ad3fcb3c8@noerenberg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/5/24 21:02, Hajo Noerenberg wrote:
> Am 02.07.2024 um 12:21 schrieb Damien Le Moal:
>>>
>>> Just to summerize again: Gen2/3 HDDs only work with the 88SE6121 controller
>>> in the Seagate Blackarmor NAS 440 [1] if they are jumpered to Gen1 (1.5 Gbit/s).
>>> This is unsatisfactory because they correctly work with the U-Boot bootloader
>>> without any jumpers at Gen2 speed (3 Gbit/s).
>>>
>>>
>>>>>> Can you try with libata.force=nolpm ? A lot of old WD drives have broken LPM.
>>>>>>
>>>>>
>>>>> libata.force=nolpm slightly changes the kernel log: the drive is basically detected (the model name and drive geometry show up), but in the end it fails:
>>>>>
>>>
>>> After many many tests I can say that no kernel option I tried (e.g. libata.force with
>>> nolpm, noncq, nodma, 1.5Gbps and almost all others) helps to mitigate the problem.
>>>
>>> By chance I saw an old Debian kernel patch [2], which, when applied make Gen2
>>> HDDs reproducibly work with 3.x kernels. After some more investigation
>>> I figured out that similarly commenting out some lines in the interrupt handler in
>>> libahci.c causes them to be recognized with kernel 6.x as well:
>>>
>>> /*      if (sata_lpm_ignore_phy_events(&ap->link)) {
>>>                 status &= ~PORT_IRQ_PHYRDY;
>>>                 ahci_scr_write(&ap->link, SCR_ERROR, SERR_PHYRDY_CHG);
>>>         }
>>> */
>>>
>>> Interestingly, sata_lpm_ignore_phy_events() returns false in my setup. So, as far as
>>> I can tell, it is not a question of the ahci_scr_write() being executed. Rather, it
>>> is the CPU cycles that are saved by the absence of this section in the interrupt
>>> handler. At first it was very hard for me to believe that it was due to commenting
>>> out the section, but I have compiled several kernels that differ
>>> only in this section: yes, it makes a difference.
>>
>> That is very odd. sata_lpm_ignore_phy_events() is only a couple of "if"
>> statements and there are no register accesses in there. So if the few CPU cycles
>> that takes make a difference, I would suspect that there is something odd going
>> on with the marvell adapter interrupts.
>>
> 
> I completely agree that this is very strange, but on the NAS440 those few lines make a difference.
> 
> There was doubt whether the PCI-MVEBU driver was working correctly, which is why I
> created the bug https://bugzilla.kernel.org/show_bug.cgi?id=216094 some time ago.
> 
> Unfortunately, no significant progress could be made there. I'm CC-ing 
> Bjorn Helgaas and Krzysztof Wilczyński with the kind wish to draw attention to this issue.
> 
> 
> 
>>> To summerize, with sata_lpm_ignore_phy_events() commented out:
>>>
>>> - with kernel 3.x HDDs are recognized (IDENTIFY 0xEC) and one can write large
>>>   amounts of data to them without any problems.
>>> - for kernel 6.x identifying and writing data works "almost" every time but not
>>>   perfectly stable.
>>
>> So commenting out that "if (sata_lpm_ignore_phy_events)" hunk is not enough to
>> fix your issue then. This hunk may not be directly related to the issue and
>> commenting it out simply changes the timing making things better.
>>
>>> - for both 3.x and 6.x kernels, when I execute certain special commands
>>>   (e.g. "hdparm -I"), the drive connection is reset but usually works afterwards.
>>> - with kernel 2.x the hard disks always worked, which is reasonable, because there
>>>   the interrupt handler never included a sata_lpm_ignore_phy_events() call.
>>
>> But above, you said that things are not completely stable with 6.x. So there is
>> likely something else going on.
>>
>>> I would be thankful if you could tell me whether and how this problem can be
>>> solved sustainably.
>>
>> First things first: can you please test with the latest mainline 6.10-rc6 kernel
>> and send a dmesg output after boot and any other relevant output showing
>> problems when doing IOs ?
>>
> 
> I added the full boot log as attachment to the bug report above:
> https://bugzilla.kernel.org/attachment.cgi?id=306531&action=edit
> 
> Please do not get confused by the number of hard disks: The relevant HDD
> is the Gen2 WDC WD5000AADS in slot 1, all other disks are only for double-checking
> things (Gen1 HDD for cross-testing in slot 2, slot 3+4 are always working
> with sata_mv driver).
> 
> Sections in the log:
> 
> 1. After system boot and "modprobe pci-mvebu" the AHCI driver fails to
> detect the Gen2 HDD in slot 1 (id ata3)

I am super confused now... The system boots fine and 2 disks (sda and sdb) are
properly detected and initialized using the sata_mv driver. This is a PCI driver
which supports these devices:

static const struct pci_device_id mv_pci_tbl[] = {
        { PCI_VDEVICE(MARVELL, 0x5040), chip_504x },
        { PCI_VDEVICE(MARVELL, 0x5041), chip_504x },
        { PCI_VDEVICE(MARVELL, 0x5080), chip_5080 },
        { PCI_VDEVICE(MARVELL, 0x5081), chip_508x },
        /* RocketRAID 1720/174x have different identifiers */
        { PCI_VDEVICE(TTI, 0x1720), chip_6042 },
        { PCI_VDEVICE(TTI, 0x1740), chip_6042 },
        { PCI_VDEVICE(TTI, 0x1742), chip_6042 },

        { PCI_VDEVICE(MARVELL, 0x6040), chip_604x },
        { PCI_VDEVICE(MARVELL, 0x6041), chip_604x },
        { PCI_VDEVICE(MARVELL, 0x6042), chip_6042 },
        { PCI_VDEVICE(MARVELL, 0x6080), chip_608x },
        { PCI_VDEVICE(MARVELL, 0x6081), chip_608x },

        { PCI_VDEVICE(ADAPTEC2, 0x0241), chip_604x },

        /* Adaptec 1430SA */
        { PCI_VDEVICE(ADAPTEC2, 0x0243), chip_7042 },

        /* Marvell 7042 support */
        { PCI_VDEVICE(MARVELL, 0x7042), chip_7042 },

        /* Highpoint RocketRAID PCIe series */
        { PCI_VDEVICE(TTI, 0x2300), chip_7042 },
        { PCI_VDEVICE(TTI, 0x2310), chip_7042 },

        { }                     /* terminate list */
};

Given that sata_mv is a PCI device, I fail to see how this can even work before
you load pci-mvebu, which if I am not mistaken is the PCI controller driver for
Marvell SoCs.

> 2. After "rmmod && insmod"-ing libahci.ko with (only) sata_lpm_ignore_phy_events()
> commented out, the Gen2 HDD is detected (id ata6 with 3Gbps).

sata_mv is NOT an ahci driver... So I suspect that doing the "modprobe
pci-mvebu" loaded another ata driver, which uses libahci or is the generic ahci
driver. And we also have the pata_marvell driver which handles the pata port,
but I assume that you do not have that one compiled, right ?

> 3. Some interrupt und lspci info.

I did not see lspci information in the bugzilla, and I wanted to look at it to
understand the ATA adapters present. What you attached is the output of (ls
/sys/bus/pci/devices/*/). Can you please send the output of "lspci" and "lspci -n" ?

> 4. Temporary ata6 connection problem ("qc timeout") but survives, still able to
> mount a vfat partition. No more problems after this (at least for ~24 hours).

It looks like 2 drivers are conflicting trying to manage the same thing... But I
need first to better understand the hardware setup. Can you also send the
relevant source pieces of the nas440.dtb device tree ?

-- 
Damien Le Moal
Western Digital Research

