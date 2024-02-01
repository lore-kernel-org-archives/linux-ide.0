Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399D0157E90
	for <linux-ide@vger.kernel.org>; Thu,  1 Feb 2024 07:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706771427; cv=none; b=g1toxITgle9uM/d98lFTFLlJ8nctl53rycwFoF+SbWbulhPQBAcvu9o0XERewrR2WtSCTARoRVKkg4zInyECgVyu4qShwCyOC0u+8fciny6NrEI1q5xxCQWGbh5y+NiXkoOskjby0ejaa1QAaUbUe9ROgAcgXUahF50wXp3V/ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706771427; c=relaxed/simple;
	bh=Z926UnVPbjZgOABNNSPnWEFAtlThfiF60q83P3IppOk=;
	h=MIME-Version:Message-ID:From:To:Subject:Content-Type:Date:
	 In-Reply-To:References; b=RPcn4Sf8yGMoGiU4+zxuD3A48q1PW8Xg1tbU13Rr8CdvcENoZUtv25BoC+lpE7VCy9yS9ZEtu46eghId+MWNmKnEaKgTT9mNDg7aEy1wQAMAHqc1Ore914i2i+imevOfjarj43kkxQojw6PNOz40VZGudYnB5fFWiVRfBJiKUV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=dmummenschanz@web.de header.b=UdcOB28Z; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=dmummenschanz@web.de header.b="UdcOB28Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1706771411; x=1707376211; i=dmummenschanz@web.de;
	bh=Z926UnVPbjZgOABNNSPnWEFAtlThfiF60q83P3IppOk=;
	h=X-UI-Sender-Class:From:To:Subject:Date:In-Reply-To:References;
	b=UdcOB28ZsSNUesrmWdDD3AMLW4hbGZNMze4MQdquVNQj9AgYwVPU59rDMki2RoMa
	 zyKKP3bOzjShh6qCBRG6o1NMiFZrZsyQbHd80lVYMSpA3HOLkUADmpXGxQue25GjJ
	 qogj0bMAVOATjtYKTP/kjcBiKnOviT1tfFqfsIgdgz6ajFECj4hfn7fwc07qDjYHT
	 Jfj8CvGFOVPo0CTM2alJ+4iwFDjEAURn9WhWcbGTbd2pwMB1tDMI/5PoeryiGv7Ev
	 U3GynHY+4FIXsaU1pd3yGSXJaR1W3Jw1v8l9RssmmdrNyOa1+Y24lFsCmeqfZQWhP
	 f8xL2ynyabU1TQdmAg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [45.130.105.48] ([45.130.105.48]) by web-mail.web.de
 (3c-app-webde-bs18.server.lan [172.19.170.18]) (via HTTP); Thu, 1 Feb 2024
 08:10:11 +0100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-61f604a0-1db3-4b6e-a316-fc7e609f38f4-1706771411065@3c-app-webde-bs18>
From: Dieter Mummenschanz <dmummenschanz@web.de>
To: Niklas Cassel <cassel@kernel.org>, linux-ide@vger.kernel.org
Subject: Aw: Re:  Re: Re: [PATCH 0/2] Power management fixes
Content-Type: text/plain; charset=UTF-8
Date: Thu, 1 Feb 2024 08:10:11 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <ZboztvrqKKdLQ1mt@x1-carbon>
References: <20240111115123.1258422-1-dlemoal@kernel.org>
 <DU0P251MB082515FC8FE77424231B475CF4682@DU0P251MB0825.EURP251.PROD.OUTLOOK.COM>
 <345be856-8959-4148-bcae-00b3fbcd0d08@kernel.org>
 <trinity-0be6e8a8-e6d3-4d60-be0d-59592a9edd65-1706010022623@3c-app-webde-bap10>
 <a72daedd-48c4-4eaf-9a77-a34679636a8c@kernel.org>
 <trinity-0df92d73-be55-433c-bdb2-4387f7ea590b-1706686178879@3c-app-webde-bap43>
 <3f7cef2a-5ba4-465b-a1f5-77e2bcc50ddb@kernel.org>
 <ZboztvrqKKdLQ1mt@x1-carbon>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:JQG5gQ7q07DcXcI4LCdeFraawqBWteI7Mp2SsSV+/mnSKIKlt1GSYRxzfdMw5e9iRDJGA
 uoPGEYlBBoYJvpQZyjWO+D8RbeB5anHJqPW7vBma4GeMSh7YigSHLouSAA1PATO+IPDtaBPwWQEF
 DG1Ag7FXD5WHTJJzz+x999oswsn7tkIHRM0Pyg5hoJ7ZFHhMl+lB85M+OFwozUneV5pzHUk23Sp2
 6/foBL6uj8SAdBBKW7M1qGepzzfIdenZWYIEDHST2tgxR6dN6Ikr7YVSBP3Hz3VlY/kuC6mpvkpb
 7E=
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:y0A1FsU3jlI=;cQr5ef/Al9Ic8rtQBxm0xOf27zO
 lQLb1D8n3mEm78OBmCoslRI+x4lcq9nwLaRSopT4+vupi8E8ah048IQxeihSOkv/AGXTX5L/b
 cnKuXptmigyBsbQqtD7ZkkmjTAGHTIzxjoJwAt7coIHgQLWecR0B8wxRqHNpWlXcvutdlOAJZ
 KGlsryfkInhMBlcBSf3wnMfoioqCxie3jLQVePgFGB1zZKgWJGCawLsPeAYD6AHSMomPWHY4r
 MgfJrmvGo0GLgUCzp6Fk0Gfpa5IEhcKRBsKAiKNmXSD9rCrT1rHz7DXpPmUZFQHaU5bv/taLB
 PwTVWZB6ujdsQJ9C9EpyuyeNgqIKJ1AYDJNYZ1dDnEyz/CaP9K8I652kXshEDaBMhq0H9sPpf
 wA97m/nno2j3J1765RV5sm52Lf6DDPWcIbAgAUsk1UMQJQ4GdlOTh4SCOiCx9I/1MmJYfqqsq
 mqtKkaMmMmjVPKdj8BKkJgliNrUVaX1gYk0ghVOLa+MeZbtYeVET60R01iEzVN8w/4lvUtUyX
 vEbLmrCoqWPxuv0xfzIlIXkmcaJLKre5PMHt+afZ4rdbRniJdwpkCjbVhIabVSR1xAbFocoXq
 cs7RGIZSDPHhJmTyWN1ozM628k+k6CZxrRUFV062qTb+MY85E1TEV0zE+Pg+Vg3xvm/tkwH+K
 zM2EP1dGTfcBjarO8M6hRNdo0PcHmeMN3W8zD10jP/ZKoXSPZsxyPdg5dx77TLY=

Hi Niklas,

> Just to confirm,
> while testing Damien's patch on top of 6.8-rc2,
> did you still do:

> for foo in /sys/class/scsi_host/host*/link_power_management_policy;
> do echo med_power_with_dipm > $foo;
> done

YES! This I always have to do this on this laptop in order to get transitions.

> It should be needed until we add (or modify the existing entry, if any)
> your PCI vendor and device id to use "board_ahci_low_power" instead of
> "board_ahci", see e.g.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/ata/ahci.c?> id=b8b8b4e0c052b2c06e1c4820a8001f4e0f77900f

Not sure I understand. So this CAN be fined inside the Kernel?


Kind regards,
Dieter
