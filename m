Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920991448F3
	for <linux-ide@vger.kernel.org>; Fri, 23 Feb 2024 21:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708722301; cv=none; b=t6KK0j/5FApuJmCqPSRqO2yfwI2TGHcN3sIQn0p124TSX+GrIdH1AIR0b3V/16IlvIas7S/i+THlMldY7+szOrWuuqKtdjZsQ9uS5jh7tAnX4H/Mcrt9T/4xLLv4Nn5yH8WxsuIyq2MpwKMihkPQu2yuWqYddUBxVQcGpqfsIWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708722301; c=relaxed/simple;
	bh=mN9U+m14cQbqJCzI+H2nYWvVrW6bcBc4g8/2fgFJBNc=;
	h=From:Subject:To:CC:References:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=KRa8rWP8pcY5srFr56P5bsYVC1zFjBMCRiP9wg6UpXx8+Fd+P2IrQQQKi10Q6JeUh4zFO93KR4Cet0XvkytXJpAC/PoVRrWYb9iEK/lQVO+U+kDSnkCHtVDKNKJUjOnpXAGpd1twVcXkc6uQB7OAjUB6eo2nKdqERElgLQTUM9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.1.105] (31.173.87.240) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Sat, 24 Feb
 2024 00:04:47 +0300
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: Re: [PATCH 2/2] ata: libata-core: Revert "ata: libata-core: Fix
 ata_pci_shutdown_one()"
To: Niklas Cassel <cassel@kernel.org>
CC: Damien Le Moal <dlemoal@kernel.org>, <linux-ide@vger.kernel.org>, Dieter
 Mummenschanz <dmummenschanz@web.de>, Wang Zhihao <wangzhihao9@hotmail.com>,
	linux-regressions <regressions@lists.linux.dev>
References: <20240111115123.1258422-1-dlemoal@kernel.org>
 <20240111115123.1258422-3-dlemoal@kernel.org>
 <d63a7b93-d1a3-726e-355c-b4a4608626f4@gmail.com> <ZdNzvAdKKsQapx8a@x1-carbon>
Organization: Open Mobile Platform
Message-ID: <d5b331ba-dc2a-f212-e2b2-f5485cff5801@omp.ru>
Date: Sat, 24 Feb 2024 00:04:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZdNzvAdKKsQapx8a@x1-carbon>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 02/23/2024 20:48:52
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 183695 [Feb 23 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.3
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info:
	d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;omp.ru:7.1.1;git.kernel.org:7.1.1
X-KSE-AntiSpam-Info: ApMailHostAddress: 31.173.87.240
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 02/23/2024 20:53:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 2/23/2024 5:40:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

On 2/19/24 6:29 PM, Niklas Cassel wrote:
[...]

>>> This reverts commit fd3a6837d8e18cb7be80dcca1283276290336a7a.
>>>
>>> Several users have signaled issues with commit fd3a6837d8e1 ("ata:
>>> libata-core: Fix ata_pci_shutdown_one()") which causes failure of the
>>> system SoC to go to a low power state. The reason for this problem
>>> is not well understood but given that this patch is harmless with the
>>> improvements to ata_dev_power_set_standby(), restore it to allow system
>>> lower power state transitions.
>>>
>>> For regular system shutdown, ata_dev_power_set_standby() will be
>>> executed twice: once the scsi device is removed and another when
>>> ata_pci_shutdown_one() executes and EH completes unloading the devices.
>>> Make the second call to ata_dev_power_set_standby() do nothing by using
>>> ata_dev_power_is_active() and return if the device is already in
>>> standby.
>>>
>>> Fixes: fd3a6837d8e1 ("ata: libata-core: Fix ata_pci_shutdown_one()")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
>>> ---
>>>  drivers/ata/libata-core.c | 75 +++++++++++++++++++++++----------------
>>>  1 file changed, 45 insertions(+), 30 deletions(-)
>>>
>>> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
>>> index d9f80f4f70f5..20a366942626 100644
>>> --- a/drivers/ata/libata-core.c
>>> +++ b/drivers/ata/libata-core.c
>>> @@ -2001,6 +2001,33 @@ bool ata_dev_power_init_tf(struct ata_device *dev, struct ata_taskfile *tf,
>>>  	return true;
>>>  }
>>>  
>>> +static bool ata_dev_power_is_active(struct ata_device *dev)
>>> +{
>>> +	struct ata_taskfile tf;
>>> +	unsigned int err_mask;
>>> +
>>> +	ata_tf_init(dev, &tf);
>>> +	tf.flags |= ATA_TFLAG_DEVICE | ATA_TFLAG_ISADDR;
>>
>>    Why set ATA_TFLAG_ISADDR, BTW? This command doesn't use any taskfile
>> regs but the device/head reg. Material for a fix, I guess... :-)
>>
>>> +	tf.protocol = ATA_PROT_NODATA;
>>> +	tf.command = ATA_CMD_CHK_POWER;
>>> +
>> [...]
> 
> Looking at the definition of the flag:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/libata.h?h=v6.8-rc5#n76
> 
> "enable r/w to nsect/lba regs"

   I'm afraid this comment doesn't reflect the reality in its r/w part --
if you look at e.g. ata_sff_tf_read(), you'll see that it always reads 
all the legacy taskfile and only checks ATA_TFLAG_LBA48 in order to
determine whether it should read the HOBs as well...

> This function does read from the nsect reg:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/ata/libata-core.c?h=v6.8-rc5#n2069
> 
> So I would prefer to keep it as it.

   IMO, it doesn't make much sense -- unless you assume that the device
could leave that reg unset as a result of this command...

> Basically the whole motto for libata right now:
> "If it ain't broke, don't fix it."

   Do you realize that each taskfile reg access takes e.g. 900-990 ns on
the Intel PIIX/ICH (the part # was 82371/82801) IDE controllers (with 33
MHz PCI bus)? Luckily, we just have to write (almost?) whole taskfile on
the read/write commands anyway...

> Sure, if we look at:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/ata/libata-sff.c?h=v6.8-rc5#n343
> 
> it seems that flags ATA_TFLAG_ISADDR, ATA_TFLAG_LBA48, and ATA_TFLAG_DEVICE
> is used to "guard" if these regs should be written to the TF.
> 
> 
> However, if we look at:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/ata/libata-sff.c?h=v6.8-rc5#n392
> 
> is seems that only flag ATA_TFLAG_LBA48 is used to "guard" if the regs should
> be read from the TF.

   Luckily, we have to read back the whole taskfile only on the read/write
errors...

> So it looks like the intention was that these flags should be used
> to guard if certain TF regs should be written or read, but in reality,
> only some of the flags are actually for guarding reads.
> (While all of the flags are used for guarding writes.)

   So you're seeing that inconsistency (I mentioned) yourself... :-)

> Personally, I don't really see the point of using flags to guard writes
> to the host controller. Why would we want to skip writing certain TF regs?
> 
> The struct ata_taskfile should be zero-initialized before filling it with

   TBH, I generally hate how libata implemented the taskfile accessors
and I hate how *struct* ata_taskfile looks too... :-)

> a command, so why not always write all TF regs and remove these flags?

   To stop wasting a good microsecond per a reg R/W cycle, perhaps? :-)
   Anyway, the ATA standards clearly describe what the regs are used by
each command and what to expect on a normal/erratic command completion...

   In drivers/ide/ we finanally ended up with 8-bit reg validity flags,
each bit corresponding to an individual taskfile reg:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=60f85019c6c8c1aebf3485a313e0da094bc95d07

> Anyway, why touch it now and risk introducing regressions on some old PATA
> hardware?

   Do you realize that drivers/ide/ wasn't writing out the whole taskfile
when issuing this particular command since:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d364c7f50b3bb6dc77259974038567b821e2cf0a

   If there were regressions, we would have seen them a long time ago,
no? :-)

> Kind regards,
> Niklas

MBR, Sergey
