Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF8E4A1D
	for <linux-ide@vger.kernel.org>; Mon,  8 Apr 2024 02:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712543170; cv=none; b=Y3M61cV7XjeWZOPHlY3OaOiZp6RqZDdX5jfxqPAFZkhI/+bs4L34p4izWqQjhTeOn5Yw46Jzd89MNp3gHHniR1BhSGGofBVdfFBwMLpxsCSYT/fVoQmNIte+H9nDmQAUJTlxSk1O5wILNG5FlB/xUX+EKz4KEO1DleLxRShVJng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712543170; c=relaxed/simple;
	bh=p4nwemK0C4A9du8k7OQhnxtjYpP4doLvVVPIBEz5Ga8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tR4XmEdlpIJE8cjVk7GGx/pjk8kmONp5lsR8DmOVOxNZmkZtThzxTmULk+sA/6GCpPERu6OMfj7ND/Kp2njgpUQvLTI/1/E5mrST9XiKTDhYj7Q3ZM05TjJXogsH3W+Eex7PM+t4RPC3EdaPIc0UJB2eE4RZcRrKxm2eqIfIZGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dQKf0bRx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dQKf0bRx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EA17C433C7;
	Mon,  8 Apr 2024 02:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712543168;
	bh=p4nwemK0C4A9du8k7OQhnxtjYpP4doLvVVPIBEz5Ga8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dQKf0bRxGkDa1Z5PmU0ST8XCQlQh6ffT0HoukAi1yblvX0pN7am1+0vnLCfgjaD5k
	 1+bgX4uXmew15W/XDEXJMaTL7zOegEXxDJnb+Xz0ePQSOrt1DfAuuxeKa3z1PHKhlI
	 /2kMsnZIpRx7oYyF9SsbQoDkDGx4ntQx1KeW2tl03gPrt0ei/uuXpIj9qHpQVY9auG
	 vrR7C5mPqjQLMjdlp6KlWA+6ToIS3i8iyG2Shdrwj5zOUXeKSxzgW2A5xmcEMUx1zO
	 vp0R2dI84vemon9Qez31QeDPxqNUAXm4+8zZcuRNH60v5qb5R0+UREkZXyu+ZrF1ol
	 Vt29EoVTfAdCw==
Message-ID: <33e81fd6-2d0d-4d23-9cab-fed775917bc0@kernel.org>
Date: Mon, 8 Apr 2024 11:26:06 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ata: ahci: Add mask_port_map module parameter
To: Conrad Kostecki <conikost@gentoo.org>, linux-ide@vger.kernel.org,
 Niklas Cassel <cassel@kernel.org>
Cc: Szuying Chen <chensiying21@gmail.com>, Jesse1_Chang@asmedia.com.tw,
 Richard_Hsu@asmedia.com.tw, Chloe_Chen@asmedia.com.tw
References: <20240405125143.1134539-1-dlemoal@kernel.org>
 <em6045942b-7739-40b7-8c9d-ad047918cdb8@a351f4b0.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <em6045942b-7739-40b7-8c9d-ad047918cdb8@a351f4b0.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/6/24 07:53, Conrad Kostecki wrote:
> Hi Damien,
> 
> Am 05.04.2024 14:51:43, "Damien Le Moal" <dlemoal@kernel.org> schrieb:
> 
>> <PATCH v2>
> i did run a test on my hardware.
> It seems to work and adjusting the port_map. But I noticed a difference, that
> those virtual hostXY ports are not marked as DUMMY.
> With the previous patch, only six ports reported "ahci" and rest "DUMMY".
> I am not sure, if that should also not happen with your patch?
> Conrad
> [   13.365573] ahci 0000:09:00.0: masking port_map 0xffffff3f -> 0x3f
> [   13.376511] ahci 0000:09:00.0: SSS flag set, parallel bus scan disabled
> [   13.395670] ahci 0000:09:00.0: AHCI 0001.0301 32 slots 32 ports 6 Gbps 0x3f
> impl SATA mode
> [   13.397111] ahci 0000:09:00.0: flags: 64bit ncq sntf stag pm led only pio
> sxs deso sadm sds apst
> [   13.593757] scsi host9: ahci
> [   13.597362] scsi host10: ahci
> [   13.600949] scsi host11: ahci
> [   13.604548] scsi host12: ahci
> [   13.612459] scsi host13: ahci
> [   13.616027] scsi host14: ahci
> [   13.616437] scsi host15: ahci
> [   13.616745] scsi host16: ahci
> [   13.617039] scsi host17: ahci
> [   13.617415] scsi host18: ahci
> [   13.617723] scsi host19: ahci
> [   13.637158] scsi host20: ahci
> [   13.640666] scsi host21: ahci
> [   13.651760] scsi host22: ahci
> [   13.652311] scsi host23: ahci
> [   13.652850] scsi host24: ahci
> [   13.656374] scsi host25: ahci
> [   13.664120] scsi host26: ahci
> [   13.664570] scsi host27: ahci
> [   13.686567] scsi host28: ahci
> [   13.690179] scsi host29: ahci
> [   13.697603] scsi host30: ahci
> [   13.698083] scsi host31: ahci
> [   13.698518] scsi host32: ahci
> [   13.701855] scsi host33: ahci
> [   13.702323] scsi host34: ahci
> [   13.702745] scsi host35: ahci
> [   13.721520] scsi host36: ahci
> [   13.725157] scsi host37: ahci
> [   13.736948] scsi host38: ahci
> [   13.737383] scsi host39: ahci
> [   13.748518] scsi host40: ahci

These messages are normal. ata port stucture which leads to a scsi host are
still created for dummy ports. So seeing all ports here as scsi hosts is
normal. However, after these messages, you should see a "ataX: DUMMY" message.

Example with a qemu VM with a 6-ports AHCI controller:

Using the ahci driver without any port map mask, I get:

[  318.739513] ahci 0000:00:1f.2: AHCI vers 0001.0000, 32 command slots, 1.5
Gbps, SATA mode
[  318.741283] ahci 0000:00:1f.2: 6/6 ports implemented (port mask 0x3f)
[  318.742619] ahci 0000:00:1f.2: flags: 64bit ncq only
[  318.759156] scsi host0: ahci
[  318.764098] scsi host1: ahci
[  318.788722] scsi host2: ahci
[  318.793502] scsi host3: ahci
[  318.797792] scsi host4: ahci
[  318.801843] scsi host5: ahci
[  318.804550] ata13: SATA max UDMA/133 abar m4096@0xfea16000 port 0xfea16100
irq 40 lpm-pol 3
[  318.805753] ata14: SATA max UDMA/133 abar m4096@0xfea16000 port 0xfea16180
irq 40 lpm-pol 3
[  318.807045] ata15: SATA max UDMA/133 abar m4096@0xfea16000 port 0xfea16200
irq 40 lpm-pol 3
[  318.808322] ata16: SATA max UDMA/133 abar m4096@0xfea16000 port 0xfea16280
irq 40 lpm-pol 3
[  318.809595] ata17: SATA max UDMA/133 abar m4096@0xfea16000 port 0xfea16300
irq 40 lpm-pol 3
[  318.810829] ata18: SATA max UDMA/133 abar m4096@0xfea16000 port 0xfea16380
irq 40 lpm-pol 3
...

On the same VM, if I rmmod ahci and modprobe it with mask_port_map=0x1
(enabling only the first port), I get:

[  362.257874] ahci 0000:00:1f.2: masking port_map 0x3f -> 0x1
[  362.260518] ahci 0000:00:1f.2: AHCI vers 0001.0000, 32 command slots, 1.5
Gbps, SATA mode
[  362.262477] ahci 0000:00:1f.2: 1/6 ports implemented (port mask 0x1)
[  362.263917] ahci 0000:00:1f.2: flags: 64bit ncq only
[  362.281765] scsi host0: ahci
[  362.286353] scsi host1: ahci
[  362.290785] scsi host2: ahci
[  362.301082] scsi host3: ahci
[  362.324192] scsi host4: ahci
[  362.329560] scsi host5: ahci
[  362.332692] ata19: SATA max UDMA/133 abar m4096@0xfea16000 port 0xfea16100
irq 40 lpm-pol 3
[  362.335041] ata20: DUMMY
[  362.335872] ata21: DUMMY
[  362.336828] ata22: DUMMY
[  362.337856] ata23: DUMMY
[  362.338660] ata24: DUMMY

So the last 5 ports are now dummies...

Can you confirm that you see this please ? Also, please confirm that boot time
is OK and faster with the port map mask.



-- 
Damien Le Moal
Western Digital Research

