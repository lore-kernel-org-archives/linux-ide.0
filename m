Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941BD80C1C;
	Tue, 24 Sep 2024 07:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727163064; cv=none; b=FyRRGD04eVdT2DiW1qiP/iqDvecHZyg6encqkFJDXruDo6ZcFp09UaPm7JrO957mRuD7FhERBbgNgkxmW/uFHthKlCbU7Kpw80WMEj42KhXtcMiWP+NTrm5oGrulQbLKtnv0FXX1sjP9zOeTtwZBBC91GjC/W5CYghPT6AN+fwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727163064; c=relaxed/simple;
	bh=EyklxDSHWsqQihh1ANwWlaC/jZPy1ZDYp8EVJWLOXVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VaCK0erjjUxtMWbkls3Gae/+72ZGarEYHNm8VZUZ54cslJY/3onZdAAcuOWPEHdRk4u83WajHKW26acoYNmM3mKpnGfhkI5/2pMLrd6FwT8xgH5RO0r1ALJyDPpgI8+MQ5xgyVAFdTfkz43HlKb70Aofw4Nor5vklcEeR1QeSdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kzP+hQVW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kzP+hQVW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3175FC4CEC4;
	Tue, 24 Sep 2024 07:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727163064;
	bh=EyklxDSHWsqQihh1ANwWlaC/jZPy1ZDYp8EVJWLOXVc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kzP+hQVWRxfKO1OE8zemwAj3BYsmuVXecUfAZ9j1A4q6us9R5xZyB4L2vZhTTj3hV
	 mW6B4wk+Qk8K5BMxV4ypbPE04ryI8iHtmF+mZnAjWJ5t5EO6Yd+A0Vv/18QDhJy+XJ
	 hIya32WbfX4yxPD3/Hb1DRo218CTV22fnHyKIOSG14iZFzPU1agBXnDm2yA8+eZ4ll
	 N2vbd2ieJpOaZ5hoAa+V7AhqQfp9HNz6qI6zuBSiZLa6PwIcBCZcPwIAf/VVcQPYxY
	 eNpggIsx4VcVRxbssERIcgbaqWfCierOfkC3FXrWZR6/GJ5+D09NU8sWvATIRx0RLU
	 DfdYHPvuwhhxQ==
Message-ID: <c7880a6f-04d4-4572-9255-1575f6668b4e@kernel.org>
Date: Tue, 24 Sep 2024 09:31:02 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: libahci driver and power switching HDD on newer kernels
To: Linux regressions mailing list <regressions@lists.linux.dev>,
 W <linuxcdeveloper@gmail.com>
Cc: linux-ide@vger.kernel.org, Niklas Cassel <cassel@kernel.org>
References: <7882faa8-d5ec-4868-b158-0b942b669cc0@gmail.com>
 <c4f1c690-6e97-44de-985f-dc9eadd18d23@leemhuis.info>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <c4f1c690-6e97-44de-985f-dc9eadd18d23@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/09/24 7:20, Linux regression tracking (Thorsten Leemhuis) wrote:
> Hi!
> 
> On 15.09.24 14:44, W wrote:
>>
>> I've got some problems with newer kernels during hibernation and
>> waking up from hibernation.
>> The symptom of the issue is that there is HDD power switching executed
>> after I run pm-hibernate command and the same HDD power switching
>> during the wake up process from hibernation.
> 
> Thx for the report. I CCed Damien and Niklas (and the regressions list),
> maybe they have an idea. If they do not reply you most likely need to
> perform a bisection to raise interest in your report.

Thanks for that. Niklas and I will look at this (I thought we already had fixed
that issue...). However, this week may be difficult as Niklas and I are
attending a conference and we may not have time to do much. But this will be our
highest priority next week.

> 
> And FWIW, there is one important info that afaics is missing from your
> report: If the latest mainline kernel (e.g. 6.11) still affected?

Yes, please check that.

> 
> Ciao, Thorsten
> 
>> As the HDD power switch process I mean: powering off my HDD and
>> immediately after that powering on the HDD. This process in my case
>> takes about 1 second.
>>
>> Here there are more details about both operations: hibernation and
>> waking up:
>>
>> Hibernation process:
>> 1. in shell I type: "pm-hibernate"
>> 2. kernel is preparing system to hibernation
>> 3. hdd is powered off and immediately powered on - it takes about one
>> second or less to do the power switch

I think that the issue is that this HDD power-off is done way too early as the
mem image saving generates IOs which wake up the drive again. The 1s it takes
for this is because the HDD started spinning down and needs to be spun up again.

This is likely because the mem image must be prepared with the devices already
suspended so that when restoring the image, the restarts sees the devices
suspended (as they should be). For this case, libata (or scsi SD PM code, not
sure which one) should suspend the device logically but not spin down the
physical HDD...

>> 4. kernel is saving mem image to swap partition with printing progress
>> in percentage
>> 5. PC and HDD are powered off

... and the power off of the HDD should happen here.

>>
>> Waking up process:
>> 1. my PC and HDD are powered off, I'm pressing any key on my keyboard
>> so it is powering up my PC
>> 2. kernel is starting, recognizes that there is mem image on swap and
>> starting to load it - printing progress percentage
>> 3. hdd is powered off and immediately powered on - it takes about one
>> second or less to do the power switch

That is a weird one, but again I think due to the IO activity that loading the
mem image generates. Similarly, I think this is a mishandling of the device
logical state vs physical power state...

>> 4. system is ready to use and working fine
>>
>> So to sum up - in both processes described above the problematic step
>> is the step 3.
>>
>> I noticed this issue when I switched kernel 6.4.12 to 6.7.5. So far I
>> haven't used git bisect yet to find the exact offending commit so the
>> change might be introduced somewhere between 6.4.12 and 6.7.5.

It would really be helpful if you could bisect this !

>> In 6.4.12 I have not such an issues with HDD power switching. The
>> issues exist in 6.7.5 and newer ones and probably somewhere between
>> 6.4.12 and 6.7.5.
>>
>> I noticed some errors in dmesg coming from ahci driver like these:
>> Sep 11 15:49:30 localhost kernel: ahci 0000:00:17.0: port does not
>> support device sleep

This is relevant. This is not really an error but rather a statement that your
device does not support sleep. This could be the reason for the behavior. (hence
my request that if you could test with a different device, it would be help).

>> and ACPI BIOS errors like these:
>> Sep 11 15:49:30 localhost kernel: ACPI BIOS Error (bug): Could not
>> resolve symbol [\_SB.PCI0.SAT0.PRT0._GTF.DSSP], AE_NOT_FOUND
>> (20240322/psargs-330)

Yeah... I see these all the time on different machines. That comes from the BIOS
not being great :) Not sure if that one relates to SATA though ?

>> Please take a look at included dmesg in the attachment.
>>
>> The mainboard I use is: Gigabyte Z370 HD3P with the newest available
>> BIOS update.
>>
>> I'd like to ask if this is known issue and if yes how could I fix it?
>> I'm not quite sure where exactly is the issue: in kernel or in my
>> Gigabyte BIOS?

Given that you had 6.4.12 working OK, it is likely some commit that introduced a
regression. If you can git bisect it, we will have a better idea how to remove
the regression.

Best regards.

-- 
Damien Le Moal
Western Digital Research
