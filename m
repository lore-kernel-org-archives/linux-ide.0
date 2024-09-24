Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C7F1B85CF;
	Tue, 24 Sep 2024 05:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727155237; cv=none; b=fdXreM179vo1gs0gzG4CaavD1iwrqyVg++IqQubIOEohxrLPRRo6JYcYQHqVM7e1pHirN/t3cxq3waMiFiKB+mKL4rl3dTpJfSuaXWtflj1Fp63x4Kq/XcMYHRrrE+IuBbZfRBbf3XBNc7TQUvbQra2tE8KYCGMLWivNtCaO4cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727155237; c=relaxed/simple;
	bh=qaxWFSqojc82zNC5SsBIiIltRN50Y4vwVF3nQiDcXbQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=BTXPD81Ku1RkMQ1BqcXuVZlPUQM7gDd736d9kA1s2ewNQ4EU4v6gWLCMshyU3AGuy/XvU7fWg7RF2favSCCKIEqis7g53oynlIWKbZ0Puiqb4tmgAT+xMBitjgq8GT2M+GlcksADCCntgraLvuK+PYAn1VOJ2xsCj9jcsfxCrwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=BF/V/ncz; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="BF/V/ncz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:Cc:From:References:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=Grfeh0/tMAkAdNYdDpqqeD6RRa9Yw/7HrCpjzQgrC4s=;
	t=1727155235; x=1727587235; b=BF/V/nczRNEO/+KfDwDTLP40r/Vy55DtXSYRkjpo6JixvFF
	8TKbdfuyCIHR19MHA6SR1VDNKqvbpBeJLxSODQ/7VSgLpdq6Z2UsKBMU5r/KBKiZZ5lQ+12aVvRh1
	3FyhLYrKeuoV9AIrI7BpI/zqc5LjCGL+EjnawOthejBZGNmsiRSkjLdzg5o1OyNkA9zNPrGljgRXs
	piYqPp+b+r+kVssWj5K1OG1YLZqi3+EIiLdjjeXNhVb62Dd3dUowThr7B5LpClOpz7KT6xAf7hb8c
	pB2Lt5FJExtZocBl+gaWXtRZKomZH2SOLm+s6Je260gpMTpkSjSiaCQamCFUWlNg==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1ssxyN-0001bu-2c; Tue, 24 Sep 2024 07:20:27 +0200
Message-ID: <c4f1c690-6e97-44de-985f-dc9eadd18d23@leemhuis.info>
Date: Tue, 24 Sep 2024 07:20:26 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: libahci driver and power switching HDD on newer kernels
To: W <linuxcdeveloper@gmail.com>
References: <7882faa8-d5ec-4868-b158-0b942b669cc0@gmail.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Cc: linux-ide@vger.kernel.org,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <7882faa8-d5ec-4868-b158-0b942b669cc0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1727155235;df77543b;
X-HE-SMSGID: 1ssxyN-0001bu-2c

Hi!

On 15.09.24 14:44, W wrote:
> 
> I've got some problems with newer kernels during hibernation and
> waking up from hibernation.
> The symptom of the issue is that there is HDD power switching executed
> after I run pm-hibernate command and the same HDD power switching
> during the wake up process from hibernation.

Thx for the report. I CCed Damien and Niklas (and the regressions list),
maybe they have an idea. If they do not reply you most likely need to
perform a bisection to raise interest in your report.

And FWIW, there is one important info that afaics is missing from your
report: If the latest mainline kernel (e.g. 6.11) still affected?

Ciao, Thorsten

> As the HDD power switch process I mean: powering off my HDD and
> immediately after that powering on the HDD. This process in my case
> takes about 1 second.
> 
> Here there are more details about both operations: hibernation and
> waking up:
> 
> Hibernation process:
> 1. in shell I type: "pm-hibernate"
> 2. kernel is preparing system to hibernation
> 3. hdd is powered off and immediately powered on - it takes about one
> second or less to do the power switch
> 4. kernel is saving mem image to swap partition with printing progress
> in percentage
> 5. PC and HDD are powered off
> 
> Waking up process:
> 1. my PC and HDD are powered off, I'm pressing any key on my keyboard
> so it is powering up my PC
> 2. kernel is starting, recognizes that there is mem image on swap and
> starting to load it - printing progress percentage
> 3. hdd is powered off and immediately powered on - it takes about one
> second or less to do the power switch
> 4. system is ready to use and working fine
> 
> So to sum up - in both processes described above the problematic step
> is the step 3.
> 
> I noticed this issue when I switched kernel 6.4.12 to 6.7.5. So far I
> haven't used git bisect yet to find the exact offending commit so the
> change might be introduced somewhere between 6.4.12 and 6.7.5.
> In 6.4.12 I have not such an issues with HDD power switching. The
> issues exist in 6.7.5 and newer ones and probably somewhere between
> 6.4.12 and 6.7.5.
> 
> I noticed some errors in dmesg coming from ahci driver like these:
> Sep 11 15:49:30 localhost kernel: ahci 0000:00:17.0: port does not
> support device sleep
> 
> and ACPI BIOS errors like these:
> Sep 11 15:49:30 localhost kernel: ACPI BIOS Error (bug): Could not
> resolve symbol [\_SB.PCI0.SAT0.PRT0._GTF.DSSP], AE_NOT_FOUND
> (20240322/psargs-330)
> 
> Please take a look at included dmesg in the attachment.
> 
> The mainboard I use is: Gigabyte Z370 HD3P with the newest available
> BIOS update.
> 
> I'd like to ask if this is known issue and if yes how could I fix it?
> I'm not quite sure where exactly is the issue: in kernel or in my
> Gigabyte BIOS?

