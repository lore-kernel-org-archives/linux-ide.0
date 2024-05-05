Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B42335280
	for <linux-ide@vger.kernel.org>; Sun,  5 May 2024 19:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714938183; cv=none; b=cNqGjzVkgCCVECd0Y14BVz+fJaFEGjn0xWtpoaGgp1dCnjL6n2ZNNCzR39+5ksSlcDxXmftfr/C6KOnUI6dDKAOi4PAKe8nX5gNDRLrcUnA9/7uyo026Ub06HhoJyG5tbz9iK/CgeMbwvvDxj7f+vWa07T8ecWQwTXj9UTxMw9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714938183; c=relaxed/simple;
	bh=4X6+lREUNZljDig+yJsOlfKV/Rb/birnR5zYZZoTkDo=;
	h=From:To:Subject:Cc:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=adscUQmcR4NALjAxa08t8F2Na2ES2E09Oyd0shUyUeyjmjvnJ5tnrFwpqpPwcEaUL/PnJyV7AWsjJ62JVcuaGlj9fIyPBPtiKkKK6zYIkOq6wKCIQnJOoybmOrq2GyfIt/r+NBy/D8olNNI1oolsKDAEi/n1FBnOXrniuHAzNII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: "Conrad Kostecki" <conikost@gentoo.org>
To: "Niklas Cassel" <cassel@kernel.org>
Subject: Re[2]: [PATCH v2] ata: ahci: Add mask_port_map module parameter
Cc: "Damien Le Moal" <dlemoal@kernel.org>, linux-ide@vger.kernel.org, "Szuying
 Chen" <chensiying21@gmail.com>, Jesse1_Chang@asmedia.com.tw,
 Richard_Hsu@asmedia.com.tw, Chloe_Chen@asmedia.com.tw
Date: Sun, 05 May 2024 19:42:55 +0000
Message-Id: <em49d72564-1852-432d-b066-eca899af6c2a@806cd47e.com>
In-Reply-To: <ZiAFEbDnwuqYWaAU@ryzen>
References: <20240405125143.1134539-1-dlemoal@kernel.org>
 <em6045942b-7739-40b7-8c9d-ad047918cdb8@a351f4b0.com> <ZiAFEbDnwuqYWaAU@ryzen>
Reply-To: "Conrad Kostecki" <conikost@gentoo.org>
User-Agent: eM_Client/10.0.1495.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Hello Niklas,
please forgive me, I wasn't able to answer earlier. I have to roll back=20
here :-)
I don't know, what I exactly did wrong, but I did now tested again PATCH=20
v2 and can confirm, it just works as it should.
Tested on 6.8.9 and also 6.9-rc6 (with has PATCH v2 applied).

My ports are being correct masked and DUMMY is being correctly shown.
So all fine and I am happy with the patch as it is now.

Sorry for the noise, I am really not sure, what I did wrong during first=20
testing.

Conrad

Am 17.04.2024 19:21:21, "Niklas Cassel" <cassel@kernel.org> schrieb:

>Hello Conrad,
>
>On Fri, Apr 05, 2024 at 10:53:55PM +0000, Conrad Kostecki wrote:
>>  Hi Damien,
>>
>>  Am 05.04.2024 14:51:43, "Damien Le Moal" <dlemoal@kernel.org> schrieb:
>>
>>  > <PATCH v2>
>>  i did run a test on my hardware.
>>  It seems to work and adjusting the port_map. But I noticed a difference=
,
>>  that those virtual hostXY ports are not marked as DUMMY.
>>  With the previous patch, only six ports reported "ahci" and rest "DUMMY=
".
>>  I am not sure, if that should also not happen with your patch?
>>  Conrad
>>  [   13.365573] ahci 0000:09:00.0: masking port_map 0xffffff3f -> 0x3f
>>  [   13.376511] ahci 0000:09:00.0: SSS flag set, parallel bus scan disab=
led
>>  [   13.395670] ahci 0000:09:00.0: AHCI 0001.0301 32 slots 32 ports 6 Gb=
ps
>>  0x3f impl SATA mode
>
>This print above suggests that you are testing on a v6.8 based kernel.
>(The print has been improved in v6.9)
>
>I do not understand why things are not working for you.
>
>
>Could you please test with v6.9-rc4 + the attached debug patch.
>
>Please make sure that you don't have any other changes on top of v6.9-rc4
>other than the debug patch. (mask_port_map is already included in v6.9-rc4=
.)
>
>
>
>Here is a how v6.9-rc4 + the attached debug patch looks for me with
>ahci.mask_port_map=3D0000:00:03.0=3D0xf
>added to the kernel command line.
>
>(If you use a /etc/modprobe.d/ahci.conf file instead, I assume that should
>look something like:
>options ahci mask_port_map=3D0000:00:03.0=3D0xf
>)
>
>
>[    0.538102] ahci 0000:00:03.0: masking port_map 0x3f -> 0xf
>[    0.539063] ahci 0000:00:03.0: port 1/6 is implemented (port_map 0xf)
>[    0.539933] ahci 0000:00:03.0: port 2/6 is implemented (port_map 0xf)
>[    0.540750] ahci 0000:00:03.0: port 3/6 is implemented (port_map 0xf)
>[    0.541663] ahci 0000:00:03.0: port 4/6 is implemented (port_map 0xf)
>[    0.542990] ahci 0000:00:03.0: port 5/6 not implemented, mark as dummy=
 (port_map 0xf)
>[    0.544121] ahci 0000:00:03.0: port 6/6 not implemented, mark as dummy=
 (port_map 0xf)
>[    0.545766] ahci 0000:00:03.0: port 1/6 is implemented, calling init (p=
ort_map 0xf)
>[    0.546718] ahci 0000:00:03.0: port 2/6 is implemented, calling init (p=
ort_map 0xf)
>[    0.547642] ahci 0000:00:03.0: port 3/6 is implemented, calling init (p=
ort_map 0xf)
>[    0.548399] ahci 0000:00:03.0: port 4/6 is implemented, calling init (p=
ort_map 0xf)
>[    0.549418] ahci 0000:00:03.0: port 5/6 is not implemented, skipping in=
it (port_map 0xf)
>[    0.550650] ahci 0000:00:03.0: port 6/6 is not implemented, skipping in=
it (port_map 0xf)
>[    0.551306] ahci 0000:00:03.0: AHCI vers 0001.0000, 32 command slots, 1=
.5 Gbps, SATA mode
>[    0.551947] ahci 0000:00:03.0: 4/6 ports implemented (port mask 0xf)
>[    0.552444] ahci 0000:00:03.0: flags: 64bit ncq only
>[    0.553652] scsi host0: ahci
>[    0.554138] scsi host1: ahci
>[    0.554535] scsi host2: ahci
>[    0.555332] scsi host3: ahci
>[    0.555806] scsi host4: ahci
>[    0.556212] scsi host5: ahci
>[    0.556502] ata1: SATA max UDMA/133 abar m4096@0xfebd1000 port 0xfebd11=
00 irq 43 lpm-pol 3
>[    0.557146] ata2: SATA max UDMA/133 abar m4096@0xfebd1000 port 0xfebd11=
80 irq 43 lpm-pol 3
>[    0.557791] ata3: SATA max UDMA/133 abar m4096@0xfebd1000 port 0xfebd12=
00 irq 43 lpm-pol 3
>[    0.558429] ata4: SATA max UDMA/133 abar m4096@0xfebd1000 port 0xfebd12=
80 irq 43 lpm-pol 3
>[    0.559064] ata5: DUMMY
>[    0.559260] ata6: DUMMY
>
>Please post your whole log, including both lines prefixed with "scsi" and
>"ata".
>
>As you can see, you should see, with your configuration,
>32 "scsi: hostX: ahci" prints,
>6  "ataX: SATA max ..." prints,
>26 "ataX: DUMMY" prints.
>
>
>If your operating system is using systemd (considering your gentoo address=
,
>this is not a given), you could run:
>
>$ systemd-analyze
>
>both with and without the kernel module option.
>
>You should be able to see a difference.
>
>Or if you don't have systemd, please just upload the full dmesg with and
>without the kernel module option, so that we can look at the timestamps.
>
>
>Kind regards,
>Niklas
