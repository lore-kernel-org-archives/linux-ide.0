Received: from nick.sneptech.io (nick.sneptech.io [178.62.38.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16ADE1B85E2
	for <linux-ide@vger.kernel.org>; Wed, 19 Feb 2025 20:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.38.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739995501; cv=none; b=M1tvsafnTcqyM6gnxkHdioFdLHEflCSAlyV0C6BGrjAr7HasxPyKWRhvFRHqMch/nBphkY7UdICs2yHotaY4WQpwJ5PElIv58v/IXNKUkTSlRB1I+shJIdxzt/B65QPwzphz8x2rFvtUIPwRcbNjr4Bf6oOaF8RvVZatSpEkSJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739995501; c=relaxed/simple;
	bh=b31DO/mYbw9l//or2Ubel/0Q8kbd1gUXMbO2ml5QC+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H3TUBG+cL2D1m1QQo6i9N0dKHU29KmVPW2vH4p9WmP9gq0EVi1fPrGwraIgwCT2DRF7g36jKiMRVoqxOIMYb6ndnkRi7igXi2zRhKhLFmmX0eJR1zE3L7sOEvbevwduoYUX0PCs5fPMTDHS82rNFeeoW9r+CsdeES6+PBOjIvpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=philpem.me.uk; spf=pass smtp.mailfrom=philpem.me.uk; dkim=pass (1024-bit key) header.d=philpem.me.uk header.i=@philpem.me.uk header.b=NHAhbng5; arc=none smtp.client-ip=178.62.38.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=philpem.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=philpem.me.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=philpem.me.uk header.i=@philpem.me.uk header.b="NHAhbng5"
Received: from wolf.philpem.me.uk (148.163.187.81.in-addr.arpa [81.187.163.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mailrelay_wolf@philpem.me.uk)
	by nick.sneptech.io (Postfix) with ESMTPSA id 37146BD45F;
	Wed, 19 Feb 2025 20:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=philpem.me.uk;
	s=mail; t=1739995491;
	bh=b31DO/mYbw9l//or2Ubel/0Q8kbd1gUXMbO2ml5QC+w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NHAhbng5vXW/TkXjqp0jyyf78/y8RpqzCITRtcIQjuXoT3VSr8oEqRTDQR/c8n33R
	 pmT27cakb8vKRCyBOIOMgohSMDAFIpWKBvk1m11qjqcZLwFdk1ZYPW94sQrRNmaGlo
	 922f/TOrmta9yTNsXAt2wEn9m5aZYSj3/zeqrCF4=
Received: from [10.0.0.32] (cheetah.homenet.philpem.me.uk [10.0.0.32])
	by wolf.philpem.me.uk (Postfix) with ESMTPSA id CC8F45FCD9;
	Wed, 19 Feb 2025 20:04:50 +0000 (GMT)
Message-ID: <27dbfb0f-2dfb-4f4a-bc5c-bb53a9f1eef5@philpem.me.uk>
Date: Wed, 19 Feb 2025 20:04:50 +0000
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
 <Z5NlVjIMp6Wo8dQd@ryzen> <9253b1b9-0f92-45ab-8b8a-44064ffa9cd9@philpem.me.uk>
 <Z7X9aPpgBjNln9CJ@ryzen> <Z7YAnqGsrWSzBirf@ryzen>
Content-Language: en-GB
From: Philip Pemberton <lists@philpem.me.uk>
In-Reply-To: <Z7YAnqGsrWSzBirf@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Niklas,

On 19/02/2025 16:02, Niklas Cassel wrote:
> On Wed, Feb 19, 2025 at 04:48:56PM +0100, Niklas Cassel wrote:
>>
>> Perhaps your could try with something like:
>>
(snip)
>> +       if (0) {
>>                  tf.protocol = ATAPI_PROT_DMA;
>>                  tf.feature |= ATAPI_PKT_DMA;

I tried the "little hammer". It works!

[    4.274698] ata4.00: ATAPI: IOMEGA  ZIP 100       ATAPI, 12.A, max 
PIO3, CDB intr
[    4.274825] ata4.00: applying bridge limits
[    4.274880] ata4.00: direction 3 dmadir 0
[    4.275166] ata4.00: direction 2 dmadir 0
[    4.281768] ata4.00: configured for PIO3
[    4.281874] ata4.00: About to do TEST UNIT READY
(snip cdb)
[    4.282715] ata4.00: direction 3 dmadir 0
[    4.283285] ata4.00: TEST UNIT READY err_mask=1 sense_key=6
(snip cdb)
[    4.284181] ata4.00: direction 2 dmadir 0
[    4.285265] ata4.00: REQUEST SENSE err_mask=0 sense_key=6
[    4.285319] ata4.00: About to do TEST UNIT READY
(snip cdb)
[    4.286214] ata4.00: direction 3 dmadir 0
[    4.286841] ata4.00: TEST UNIT READY err_mask=1 sense_key=2
[    4.291043] scsi 3:0:0:0: Direct-Access     IOMEGA   ZIP 100 
12.A PQ: 0 ANSI: 5
(snip cdb)
[    4.329969] ata4.00: direction 2 dmadir 0

And smartctl can talk to it:

root@localhost:~# smartctl -i /dev/sdb
smartctl 7.3 2022-02-28 r5338 [i686-linux-6.10.11] (local build)
Copyright (C) 2002-22, Bruce Allen, Christian Franke, www.smartmontools.org

=== START OF INFORMATION SECTION ===
Vendor:               IOMEGA
Product:              ZIP 100
Revision:             12.A
Compliance:           SPC-3
Device type:          disk
Local Time is:        Wed Feb 19 19:47:42 2025 UTC
SMART support is:     Unavailable - device lacks SMART capability.

I've been able to get a good read of a disk with ddrescue:

GNU ddrescue 1.27
Press Ctrl-C to interrupt
      ipos:  100597 kB, non-trimmed:        0 B,  current rate:    720 kB/s
      opos:  100597 kB, non-scraped:        0 B,  average rate:   1070 kB/s
non-tried:        0 B,  bad-sector:        0 B,    error rate:       0 B/s
   rescued:  100663 kB,   bad areas:        0,        run time:      1m 33s
pct rescued:  100.00%, read errors:        0,  remaining time:         n/a
                               time since last successful read:         n/a
Copying non-tried blocks... Pass 1 (forwards)
Finished

I'm pretty chuffed with the data rate, 1MB/sec is far more than the 
externals manage.

I guess the question now is, how to fix this properly?

Thanks,
-- 
Phil.
philpem@philpem.me.uk
https://www.philpem.me.uk/
