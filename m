Received: from nick.sneptech.io (nick.sneptech.io [178.62.38.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F2620469D
	for <linux-ide@vger.kernel.org>; Fri, 21 Feb 2025 17:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.38.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740157711; cv=none; b=e4K7q6XDTvpAq7rtU8eyAKZaOlhWCJKKRndDVX7nk153L1seD8Iv2BrI5H2/xu+zrGg6kWEaXGVcVYGWN2LsHeDQWi/vEnuhJArCrpISWf9r2u57y5MGrpey2BAldbVLBP1xuO4pvJZ9TvABCWeLnvGk8fSMi0yK13H5DxU77gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740157711; c=relaxed/simple;
	bh=C3SKdR8Ly+1rN558XPt3iHQ1QEVzGLF/3BslLr0y80s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dowYVgDEP1+AIuyzDG1bL063ftk5QCxmrkaHh1ikoOdLC67oyhphM+JEwA04kNhnZW/MsM+s2RO0Qw/HDop2PDBIxMUUIWfdIBu+Q4i7C5kNlV1+USZrcMO/mPA3GZSGrIdg5aYEDd/UvZNNA033wia2IWUyj4hbDtRlto2DUT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=philpem.me.uk; spf=pass smtp.mailfrom=philpem.me.uk; dkim=pass (1024-bit key) header.d=philpem.me.uk header.i=@philpem.me.uk header.b=x8nC+Nt2; arc=none smtp.client-ip=178.62.38.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=philpem.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=philpem.me.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=philpem.me.uk header.i=@philpem.me.uk header.b="x8nC+Nt2"
Received: from wolf.philpem.me.uk (148.163.187.81.in-addr.arpa [81.187.163.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mailrelay_wolf@philpem.me.uk)
	by nick.sneptech.io (Postfix) with ESMTPSA id 53422BD5E9;
	Fri, 21 Feb 2025 17:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=philpem.me.uk;
	s=mail; t=1740157702;
	bh=C3SKdR8Ly+1rN558XPt3iHQ1QEVzGLF/3BslLr0y80s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=x8nC+Nt2cKGiAoWnuKOTtpsXlm03MdzukTb1W9zpayQTtFw0vkcdgp4b8upNmF9dN
	 Cdrq0jp+JwDkM1B1Mnu+jU40LWTaS3H70Oq59L0n0V33cZ0QNpv5L3/942WBGnJ1c+
	 q/HvTMdc1zE87BVeACB4lg9vaoYnjKoXqRuXD2hU=
Received: from [10.0.0.32] (cheetah.homenet.philpem.me.uk [10.0.0.32])
	by wolf.philpem.me.uk (Postfix) with ESMTPSA id 8519F5FCDB;
	Fri, 21 Feb 2025 17:08:22 +0000 (GMT)
Message-ID: <62cd0608-8089-4c1e-b44d-699f1409dccb@philpem.me.uk>
Date: Fri, 21 Feb 2025 17:08:21 +0000
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
References: <e1985151-c206-4be1-91c1-92eac16f6236@philpem.me.uk>
 <Z3-_dt0m_2UrtKon@ryzen> <e1b79ece-b4b2-42e5-b259-290820324b5e@philpem.me.uk>
 <Z4pdD1Z2mJnF7N3O@ryzen> <2bb1510c-c42f-468b-a8cb-70603bee846b@philpem.me.uk>
 <Z5NlVjIMp6Wo8dQd@ryzen> <9253b1b9-0f92-45ab-8b8a-44064ffa9cd9@philpem.me.uk>
 <Z7X9aPpgBjNln9CJ@ryzen> <Z7YAnqGsrWSzBirf@ryzen>
 <27dbfb0f-2dfb-4f4a-bc5c-bb53a9f1eef5@philpem.me.uk> <Z7fdfX6GD6D98UPp@ryzen>
Content-Language: en-GB
From: Philip Pemberton <lists@philpem.me.uk>
In-Reply-To: <Z7fdfX6GD6D98UPp@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21/02/2025 01:57, Niklas Cassel wrote:
> Please try this patch:
> https://lore.kernel.org/linux-ide/20250221015422.20687-2-cassel@kernel.org/T/#u
> 
> and see if it fixes your problem.
> 
> Please also make sure to check that you can still write and read back what
> you wrote to the device (with the read data matching the written data).

I can confirm the patch works!

I was slightly amused to see this bug appears to be 19 years old: 
https://github.com/torvalds/linux/blame/master/drivers/ata/libata-eh.c#L1546
It's understandable, in May 2006 the Zip drive was probably still around 
in places, but quite obsolete. The ATAPI internal versions were 
uncommon, most would have been external parallel, USB or SCSI.


I'm not sure if the Read Capacity command failing is a problem, it seems 
to succeed on the second attempt. My guess is the drive can't handle 
SCSI commands while it's doing a load or eject (probably updating the 
management data aka z-tracks).

[   79.936649] sd 3:0:0:0: [sdb] Read Capacity(16) failed: Result: 
hostbyte=DID_ERROR driverbyte=DRIVER_OK
[   79.936692] sd 3:0:0:0: [sdb] Sense not available.
[  162.381077] sdb: detected capacity change from 196608 to 0
[  164.969080] sd 3:0:0:0: [sdb] Spinning up disk...
[  166.004048] ..ready
[  167.262210] sd 3:0:0:0: [sdb] Read Capacity(16) failed: Result: 
hostbyte=DID_ERROR driverbyte=DRIVER_OK
[  167.262244] sd 3:0:0:0: [sdb] Sense not available.
[  167.305302] sd 3:0:0:0: [sdb] 196608 512-byte logical blocks: (101 
MB/96.0 MiB)
[  167.349309] sdb: detected capacity change from 0 to 196608
[  167.480724]  sdb: [mac] sdb1 sdb2 sdb3 sdb4 sdb5
[  192.527434] systemd-journald[260]: Failed to set ACL on 
/var/log/journal/44cff3865dce455fac8b3c3db744ba67/user-1000.journal, 
ignoring: Operation not supported
[  204.709301] sd 3:0:0:0: [sdb] Read Capacity(16) failed: Result: 
hostbyte=DID_ERROR driverbyte=DRIVER_OK
[  204.709334] sd 3:0:0:0: [sdb] Sense not available.


It seems to be able to read and write correctly -- I can read the 
contents of the disk, write random data, and read the random data back 
correctly.

Dump the original contents of the disk:
# ddrescue /dev/sdb zip_orig
GNU ddrescue 1.27
Press Ctrl-C to interrupt
      ipos:  100597 kB, non-trimmed:        0 B,  current rate:    589 kB/s
      opos:  100597 kB, non-scraped:        0 B,  average rate:    792 kB/s
non-tried:        0 B,  bad-sector:        0 B,    error rate:       0 B/s
   rescued:  100663 kB,   bad areas:        0,        run time:      2m  6s
pct rescued:  100.00%, read errors:        0,  remaining time:         n/a
                               time since last successful read:         n/a
Copying non-tried blocks... Pass 1 (forwards)
Finished

Create 100MB of randomness, write it to the disk:
# dd if=/dev/urandom of=ziptest bs=512 count=196608
196608+0 records in
196608+0 records out
100663296 bytes (101 MB, 96 MiB) copied, 2.74086 s, 36.7 MB/s
# dd if=ziptest of=/dev/sdb bs=512
196608+0 records in
196608+0 records out
100663296 bytes (101 MB, 96 MiB) copied, 226.022 s, 445 kB/s

Read it back:
# ddrescue /dev/sdb ziptest_read
GNU ddrescue 1.27
Press Ctrl-C to interrupt
      ipos:  100597 kB, non-trimmed:        0 B,  current rate:    196 kB/s
      opos:  100597 kB, non-scraped:        0 B,  average rate:   1059 kB/s
non-tried:        0 B,  bad-sector:        0 B,    error rate:       0 B/s
   rescued:  100663 kB,   bad areas:        0,        run time:      1m 34s
pct rescued:  100.00%, read errors:        0,  remaining time:         n/a
                               time since last successful read:         n/a
Copying non-tried blocks... Pass 1 (forwards)
Finished

Compare:
# md5sum ziptest*
f132f7ad38beef40d45ce9f96a6e9f92  ziptest
f132f7ad38beef40d45ce9f96a6e9f92  ziptest_read

Thanks.
-- 
Phil.
philpem@philpem.me.uk
https://www.philpem.me.uk/
