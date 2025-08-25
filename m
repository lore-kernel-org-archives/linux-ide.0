Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8908A2D3EC9
	for <linux-ide@vger.kernel.org>; Mon, 25 Aug 2025 20:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756154529; cv=none; b=DnZk9rx0nqVik+jfDv31OctTBrxV+YNmbpW2KBaOKkSZst46ht/ArA75sN9iazeC1ScI0cco3q+Fqvv67TaA6hcGdQqfX6Pl1rS+hpprZbzT6y562IJBVShp5IdhWJH+eLrrvbw5pmNiwNOLWcSS/rxVNRbWgkS9ULutTRt5w5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756154529; c=relaxed/simple;
	bh=YrQ1+SfKbgqoffiDBVEtjHkpkp4GWhBhhUmSq+uxZro=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=siHvjjw73Tf5OySEa/UOAflJ3tLIsWbSVNpss/lcWDJYICXPTkB07A9w7Y5v412eOYe96TVrOedQxa7fIvS5MpwMQji2FtLUZaKFS4RcsO59A8lff3ekGnfzaOJy150J9sPP6hV/JL93/fs5xX6b8vnlXKvWgbF/BdPuKfGT8F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s5CIAxTq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s5CIAxTq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37AF0C116D0;
	Mon, 25 Aug 2025 20:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756154529;
	bh=YrQ1+SfKbgqoffiDBVEtjHkpkp4GWhBhhUmSq+uxZro=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=s5CIAxTqcI1975kLYsKpyZEJ+ovo95KKV24z5TqL8ZDZothKy3ptV+Dquqw/9Kc+Q
	 5vXxNA9bIhJiMtg5kZb4B/w6WOeiop4ivyMEQ0OfRXSEDOWuYoNjGZscICfdFzb7i0
	 oNzcTmErZzgKPgUcq4OthAu5DrjiOsAklaM6Hwvc3ADUMs7K9yFzGoCXuc1PB5dXQ5
	 jQRCALq1hUFh+q+cb/yTd9N2aoTi5PZDFXDygJ7wKXkPBhA0xGtt+Oer6qlemMm6R0
	 RLczDRT2PWHnOUYIcBpPXK9RKCl+rFcR+wyEGj49RczdMN33qiFU6rINKouJo1WoDu
	 2FNS8516/ZcNg==
Date: Mon, 25 Aug 2025 22:42:08 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Paul Menzel <pmenzel@molgen.mpg.de>,
 Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC: linux-ide@vger.kernel.org
Subject: Re: Warning about DRM functions support logged twice and lpm-pol
User-Agent: Thunderbird for Android
In-Reply-To: <a9a7e87a-d41b-43fb-9e46-ed10ac6ee961@molgen.mpg.de>
References: <a9a7e87a-d41b-43fb-9e46-ed10ac6ee961@molgen.mpg.de>
Message-ID: <6D8A123A-27CD-419C-8ACF-E3B2209B7872@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 25 August 2025 21:51:58 CEST, Paul Menzel <pmenzel@molgen=2Empg=2Ede> wr=
ote:
>Dear Linux folks,
>
>
>On a Dell Precision 3620 with
>
>    $ lspci -nn -s 00:17=2E0
>    00:17=2E0 SATA controller [0106]: Intel Corporation Q170/Q150/B150/H1=
70/H110/Z170/CM236 Chipset SATA Controller [AHCI Mode] [8086:a102] (rev 31)
>
>Linux warns about the ATA device and Samsung SSD 870 EVO 1TB=2E
>
>    $ lsblk -o name,model,serial,rev -S
>    NAME MODEL                   SERIAL           REV
>    sda  Samsung SSD 870 EVO 1TB S6PUNL0T600648F 2B6Q
>    $ dmesg --level warn
>    [    1=2E688558] Transient Scheduler Attacks: MDS CPU bug present and=
 SMT on, data leak possible=2E See https://www=2Ekernel=2Eorg/doc/html/late=
st/admin-guide/hw-vuln/mds=2Ehtml for more details=2E
>    [    1=2E690195] Transient Scheduler Attacks: MMIO Stale Data CPU bug=
 present and SMT on, data leak possible=2E See https://www=2Ekernel=2Eorg/d=
oc/html/latest/admin-guide/hw-vuln/processor_mmio_stale_data=2Ehtml for mor=
e details=2E
>    [    3=2E165214] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
>    [    3=2E254639] ata1=2E00: Model 'Samsung SSD 870 EVO 1TB', rev 'SVT=
02B6Q', applying quirks: noncqtrim zeroaftertrim noncqonati nolpmonati
>    [    3=2E266623] ata1=2E00: supports DRM functions and may not be ful=
ly accessible
>    [    3=2E304432] ata1=2E00: supports DRM functions and may not be ful=
ly accessible
>    [    4=2E195869] wmi_bus wmi_bus-PNP0C14:01: [Firmware Bug]: WQBC dat=
a block query control method not found
>    [  651=2E061135] systemd-journald[164]: File /var/log/journal/9579022=
6b8d0779f4b4797314ca986d4/user-8578=2Ejournal corrupted or uncleanly shut d=
own, renaming and replacing=2E
>    $ dmesg | grep -e 'Linux version' -e 'DMI: Dell' -e lpm
>    [    0=2E000000] Linux version 6=2E12=2E40=2Emx64=2E484 (root@mehrlam=
etta=2Emolgen=2Empg=2Ede) (gcc (GCC) 12=2E5=2E0, GNU ld (GNU Binutils) 2=2E=
41) #1 SMP PREEMPT_DYNAMIC Thu Jul 24 15:14:16 CEST 2025
>    [    0=2E000000] DMI: Dell Inc=2E Precision Tower 3620/0MWYPT, BIOS 2=
=2E23=2E0 09/14/2022
>    [    2=2E892973] ata1: SATA max UDMA/133 abar m2048@0xef14b000 port 0=
xef14b100 irq 124 lpm-pol 0
>    [    2=2E901327] ata2: SATA max UDMA/133 abar m2048@0xef14b000 port 0=
xef14b180 irq 124 lpm-pol 0
>    [    2=2E909685] ata3: SATA max UDMA/133 abar m2048@0xef14b000 port 0=
xef14b200 irq 124 lpm-pol 0
>    [    2=2E918042] ata4: SATA max UDMA/133 abar m2048@0xef14b000 port 0=
xef14b280 irq 124 lpm-pol 0
>    [    3=2E254639] ata1=2E00: Model 'Samsung SSD 870 EVO 1TB', rev 'SVT=
02B6Q', applying quirks: noncqtrim zeroaftertrim noncqonati nolpmonati
>
>I wonder why the DRM warning is logged twice, and why the LPM policy is 0=
=2E (It=E2=80=99s a desktop system, but still=2E)
>
>Is there anything I can do about this?

Hello Paul,

What is your Kconfig CONFIG_SATA_MOBILE_LPM_POLICY
set to?

If it is 0, try building with CONFIG_SATA_MOBILE_LPM_POLICY set to 3,
which is nowadays the default, see:
https://github=2Ecom/torvalds/linux/blob/v6=2E17-rc3/drivers/ata/Kconfig#L=
121

Didn't check about the double prints yet, a bit late here right now=2E


Kind regards,
Niklas

