Received: from pasta.tip.net.au (mx1.tip.net.au [203.10.76.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CF7322C97
	for <linux-ide@vger.kernel.org>; Mon, 22 Dec 2025 05:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.10.76.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766383042; cv=none; b=XMHjTikdX3OGMbHyfjuFEPgV26OBMkkX++6Xl5SvKW7lqaXFGXEduWronlp1XLZVWn3ezFulPrYQ0LL20nFktW5xJDgKqAZuioq6lzXkoqQvDSUlp37BEcks1hcPdIO1VosZG9Ovbj6KVwFjjPqsTh3LSpYSA25cS01v/cMbqLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766383042; c=relaxed/simple;
	bh=J7lH7JSr5n39W5F8OWE1VUxsWNfSLHxSjrceoPxIELY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z8H+5yt7CV67wnufuCvqGWV3u+T9BrXjBBvJp7CJXNu1v+TJ7mBlvY/4AmqnqISRg4KF3KUYWBLl+Cf4K3ciR+f3xyEKOSGLJ0igeD39D1rLYv0ZdcY+SxPoLcQBWiOarFGH5LHb6AqFulSFpgQZqZhzK0bF72Zh1XzrlzNqBAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eyal.emu.id.au; spf=pass smtp.mailfrom=eyal.emu.id.au; arc=none smtp.client-ip=203.10.76.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eyal.emu.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eyal.emu.id.au
Received: from [192.168.2.7] (unknown [101.115.78.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mailhost.tip.net.au (Postfix) with ESMTPSA id 4dZS8Y0P0sz8sm2;
	Mon, 22 Dec 2025 16:57:17 +1100 (AEDT)
Message-ID: <f6665313-7b26-40e5-9185-ada5e63c41b0@eyal.emu.id.au>
Date: Mon, 22 Dec 2025 16:57:09 +1100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: eyal@eyal.emu.id.au
Subject: Re: ata timeout exceptions
To: Damien Le Moal <dlemoal@kernel.org>,
 list linux-ide <linux-ide@vger.kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>
References: <acf2fa9f-f98d-4eb0-b18b-a04aa123201b@eyal.emu.id.au>
 <080383fe-63cf-4198-966a-b32d798bea06@eyal.emu.id.au>
 <13bf2e98-1774-4444-bc56-38a39d539d8e@kernel.org>
 <79fcb2f0-d09b-4649-bda0-55f309b20985@eyal.emu.id.au>
 <746FB9BB-5945-415F-915F-3F05D8A6B063@kernel.org>
 <582e748c-3e29-4f21-af7c-c799fb457e59@eyal.emu.id.au>
 <3d476e67-31a9-4e7d-b8cc-5bb298a6d62f@kernel.org>
 <9933af72-944e-4bb3-bab9-fdbd4fb0fad0@eyal.emu.id.au>
 <3e81e6ae-1ef0-454c-935f-eee2bba91176@eyal.emu.id.au>
 <cda2a663-10a5-4212-8725-8c780a2c291d@kernel.org>
 <0239be44-cfc7-4c99-b245-636e376df037@eyal.emu.id.au>
 <9d5644a9-8365-4dce-833a-5e26e2d79684@kernel.org>
Content-Language: en-US
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
In-Reply-To: <9d5644a9-8365-4dce-833a-5e26e2d79684@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/12/25 14:43, Damien Le Moal wrote:
> On 12/22/25 11:10, Eyal Lebedinsky wrote:
>> On 22/12/25 10:14, Damien Le Moal wrote:
>>> Can you try with NCQ enabled and a max sectors of 2048 (1 MiB
>>> commands max) ? I suspect this should work. Otherwise, if NCQ also causes
>>> issues, we can quirk both NCQ and max sectors for this drive.
>>
>> To be clear, set "max_sectors_kb=1024"? This always worked, no pause (or timeout).
>> 	"this should work" meaning "no trouble" or "will reproduce the problem"?

This is how it is now set.

> Yes, I meant to say that you should not see any timeout/long pause with NCQ for
> a max command size of 1MiB. The reason I say that is that most drive managed SMR
> implementation are based on some form of logging of random writes. Logging small
> writes is fast and relatively easy to handle (even if the log is full, a small
> portion of it can be recovered with just a few IOs). But if the writes are
> large, things can get ugly as freeing up enough space in that log can be very
> costly. That of course all depend on the vendor/model implementation of device
> managed SMR FW...
> 
>> With ncq enabled, I had the same numbers of timeouts, with the difference being that the disk
>> logged many errors (one for each tag) and also registered a Command_Timeout which it did not otherwise.
> 
> My point was to try NCQ combined with a small max sectors quirk to see if that
> works well or not.
> 
>>
>> Question: will setting
>> 	$ sudo sh -c 'echo 32 >/sys/block/sda/device/queue_depth'
>> be the same as booting without
>> 	libata.force=2.00:noncq
>> or do I actually need to reboot?
> 
> You will need to reboot without libata.force=noncq. Otherwise,
> ata_dev_config_ncq() will always do nothing for the drive and NCQ will not be
> seen as supported.

I discovered that I need to reboot, which I did.

> Once you confirm if we really need to maintain NCQ off or not with a small max
> sectors limit, we can write a proper quirk for this drive.

I am leaving it this way. It runs the usual workload (rsync in) every 2 hours. I will report back in a few days.

The recent run with these settings was smooth:

16:07:56 sda          0.00     0.00       0.00       0.00
16:08:06 sda        921.57    55.70   51331.45  513314.49
16:08:16 sda        972.67   130.90  127322.50 1273225.03
16:08:26 sda        952.22   141.00  134263.02 1342630.20
16:08:36 sda        968.10   128.50  124400.85 1244008.50
16:08:46 sda        916.85   144.60  132576.51 1325765.10
16:08:56 sda        978.13   128.20  125396.27 1253962.66
16:09:06 sda        937.33   139.00  130288.87 1302888.70
16:09:16 sda        857.16   136.10  116659.48 1166594.76
16:09:26 sda        971.57   123.40  119891.74 1198917.38
16:09:36 sda        969.15   136.80  132579.72 1325797.20
16:09:46 sda        969.75   105.40  102211.65 1022116.50
16:09:56 sda        914.09   129.30  118191.84 1181918.37
16:10:06 sda        931.91   123.50  115090.88 1150908.85
16:10:16 sda        947.24   123.30  116794.69 1167946.92
16:10:26 sda        921.27   136.50  125753.35 1257533.55
16:10:36 sda        964.06   128.30  123688.90 1236888.98
16:10:46 sda        955.16   137.30  131143.47 1311434.68
16:10:56 sda        954.25   104.50   99719.12  997191.25
16:11:06 sda        663.10    29.20   19362.52  193625.20
16:11:16 sda          0.00     0.00       0.00       0.00
16:11:26 sda          0.00     0.00       0.00       0.00
16:11:26 2025-12-22
16:11:36 Device   wareq-sz      w/s     kB_w/s       kB_w

BTW, I did a quick try with "max_sectors_kb=4096" and a fast dd:
	$ dd if=/dev/zero of=/data2/tmp/zero.dd bs=4M count=$((21500/4)) status=progress
and it worked without an issue:

15:34:46 sda          0.00     0.00       0.00       0.00
15:34:56 sda       4096.00    15.10   61849.60  618496.00
15:35:06 sda       3959.49    26.90  106510.28 1065102.81
15:35:16 sda       4007.07    27.50  110194.43 1101944.25
15:35:26 sda       4020.03    26.80  107736.80 1077368.04
15:35:36 sda       4035.55    26.90  108556.29 1085562.95
15:35:46 sda       4032.27    25.60  103226.11 1032261.12
15:35:56 sda       4020.59    27.00  108555.93 1085559.30
15:36:06 sda       3974.66    26.90  106918.35 1069183.54
15:36:16 sda       4030.60    24.90  100361.94 1003619.40
15:36:26 sda       4004.95    26.90  107733.15 1077331.55
15:36:26 2025-12-22
15:36:36 Device   wareq-sz      w/s     kB_w/s       kB_w
15:36:36 sda       3991.85    27.40  109376.69 1093766.90
15:36:46 sda       4045.15    24.00   97083.60  970836.00
15:36:56 sda       4017.98    26.10  104869.28 1048692.78
15:37:06 sda       4017.81    26.10  104864.84 1048648.41
15:37:16 sda       4000.09    25.50  102002.29 1020022.95
15:37:26 sda       3990.31    27.00  107738.37 1077383.70
15:37:36 sda       4048.90    25.90  104866.51 1048665.10
15:37:46 sda       4003.07    26.30  105280.74 1052807.41
15:37:56 sda       4051.49    27.50  111415.97 1114159.75
15:38:06 sda       4033.31    26.00  104866.06 1048660.60
15:38:16 sda       4036.07    27.20  109781.10 1097811.04
15:38:26 sda       3340.74     5.40   18040.00  180399.96
15:38:36 sda          0.00     0.00       0.00       0.00

This is unlike my usual workload which writes about 250 files, some a few GB and some rather small.

Eyal

-- 
Eyal at Home (eyal@eyal.emu.id.au)
