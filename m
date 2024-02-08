Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50DC76412
	for <linux-ide@vger.kernel.org>; Thu,  8 Feb 2024 14:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707403090; cv=none; b=mug6qzqKs/o7NXDnFoCTevUWUU7zhY/LIeCTKZhx6Xr8ejPidNa+kRaI+hWHn/7p4clA9ZX5aLTHSJFDdglNo0+RS3uNEOu1g32YDM+0J50vJJlzHiBKmnJPZF0pHXbvPpwVVgahnj+wYp98eUu72DZuPNx2KOlfsKwVPkO5Lvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707403090; c=relaxed/simple;
	bh=pTYlkiVuMVcCEj8oWInse55yAQt4wuql3uqmrHaDnbU=;
	h=MIME-Version:Message-ID:From:To:Cc:Subject:Content-Type:Date:
	 In-Reply-To:References; b=YvMlL07nHJ611RPvtuPnXYzvuj1dQyB4HrpzhdO4TBJUvL58uabFvGeI6xuTBKsOinFIaVI/yZF6lZKa9f18rQrUXPlZ4QOCx9i8NbzsjfKkz1ENjnWaULtdW1m55UpvcCPaWi6xlE/VziXN/hUWiOSIyoHnLLuVQ6sj2b5w/94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=dmummenschanz@web.de header.b=c3lOL7dT; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=dmummenschanz@web.de header.b="c3lOL7dT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1707403068; x=1708007868; i=dmummenschanz@web.de;
	bh=pTYlkiVuMVcCEj8oWInse55yAQt4wuql3uqmrHaDnbU=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=c3lOL7dT8w+7AKS9XJol0VJLTdve7I4JdFiTnjDf1xJCxXLBIOqq0gokR9lnmOjc
	 n48pUcwHeKJ8j57GOqjwHqvbBAyUcyjzswY140hTY2DBFxlvTAuiH+aWPSqA9/yrd
	 DKcLmeJAekMxC/s16qahndKv9FO3jBJThOBZnOVZPlyXvHtDlSst47982f6A9+2VS
	 99oW5UjuKLjcFZ/vK2XURs0FNpH34njx56FLLBC7/aF5P7m7BSoqIBXA0/QeMDeQK
	 ZcWJtMQ81Yqf9BibAE/t5HfchvZiLcUmdWgHk4rPFnTaW3TRw/mmuwQ6KPaZ1la9B
	 Qw3gMnSPc3C8CyOG8Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [213.109.200.100] ([213.109.200.100]) by web-mail.web.de
 (3c-app-webde-bap33.server.lan [172.19.172.33]) (via HTTP); Thu, 8 Feb 2024
 15:37:48 +0100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-65caccf7-138b-4625-8e2e-afac802dd2da-1707403068697@3c-app-webde-bap33>
From: Dieter Mummenschanz <dmummenschanz@web.de>
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>
Subject: Aw: Re: Re: Re: Re:  Re: Re: [PATCH 0/2] Power management fixes
Content-Type: text/plain; charset=UTF-8
Date: Thu, 8 Feb 2024 15:37:48 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <ZcKopITjwjKYNM9C@x1-carbon>
References: <trinity-0be6e8a8-e6d3-4d60-be0d-59592a9edd65-1706010022623@3c-app-webde-bap10>
 <a72daedd-48c4-4eaf-9a77-a34679636a8c@kernel.org>
 <trinity-0df92d73-be55-433c-bdb2-4387f7ea590b-1706686178879@3c-app-webde-bap43>
 <3f7cef2a-5ba4-465b-a1f5-77e2bcc50ddb@kernel.org>
 <ZboztvrqKKdLQ1mt@x1-carbon>
 <trinity-61f604a0-1db3-4b6e-a316-fc7e609f38f4-1706771411065@3c-app-webde-bs18>
 <Zbt3qD8dMSqGYl8Q@x1-carbon>
 <trinity-78c294c6-cd07-4a27-befa-3f3fc9bd79da-1706885616508@3c-app-webde-bs04>
 <ZcEwa4fOzMif8lCd@x1-carbon>
 <trinity-0bc8e6ea-7808-4508-af3a-be22281abf24-1707231996854@3c-app-webde-bs42>
 <ZcKopITjwjKYNM9C@x1-carbon>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:RG5yF/QqWqI6pXxxX9MkjJrsDbQi3XemwOOuyWh9G7AAXdJRyiWT1Mk0lZc8s3+UAplEb
 iQ090ilnBO0iN9q4vQ73OryywMMdXLZBMzIxapuXtAe8eFWNNZImmtL9kP6ebjU4EQ7qbiASW99j
 MMXmZ6bo2bWj0WyVcSo8Js9Oge3UieWIJqUsR3qPaw335NiXhH69T4N3b6rCamumtzmU8Lca5e5d
 hJ6bQBOT13Itr94FlkgqCqdtWjMfehRG4vMu2tLrMWoRd8odwT53rYU5PhRzc/BIXZpu3tlECAXM
 ns=
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5RUBDHHxJ+E=;wQ0mFiydA0pyeLmWSL0jHP05MP+
 Nk9AbLFD2y4wEr9c+dTRU1/geR+4uBGnfDR83zLX7LgnHkTd9VvVx8YG9KHOm7loePa98sT+/
 rk5Pa7ce090UnSZH/nEjbEhakxKehfEsWzlFkHiZYQVNp3XbiHTvEXvJWjCX7358bR+6k/uIB
 1K0RCKrYGQnz/1Tg0MnJFQeDSfoGHpA80tkJc+wFPPiKYBkra9jaHHXyuVZORs4I1vy65yxaG
 ME1li2XuwaQEetBRbvro8ZNZTYXNrGkaEpTBdDRCitN7dhEPw5bfQNARZuvtlsp9pbGZ20Td/
 gx78LAjhKFGBEidTATQXdRA4413DmnJHnKM76QNLkW5OxfO5LIG1yaftvWqQiOY9uaqUCQPE+
 nVE/Dw0FQdS/fLSfgXQjJA3L/YJXZO3VwzKZPofW/ID0OG49d8GxMLaqx3DhNFOytGEGMLooy
 h5eKbHUp82Zqemumu85t+BThiOQ49EcW03xvNx0rgbpusBag0+d6G7WzKKzwNVHpzlEFO89q3
 irTYCRRIDjq0JRQCfiqlQHUchSUQa3lfr7T5Ba2WZT50+Ra/hf3qPn3YXcfGcajIXbcdoC9KA
 WofcqGjfY6GnWkXeMf7fUQJ6RdmlCq6AWpHKchpNrTl+mmVLumwzpKHbsVUPBD3P8fxOVRfs9
 Hd42k2TvSy8MUCD9If6CCtCvPThxVLkVKywnJmTX0pBVtQuL8T/Fxqx6HRVEkMM=

Hello Niklas,


> It should be ready for testing:
> https://github.com/floatious/linux/tree/external-port-v2[https://github.com/floatious/linux/tree/external-port-v2]

> With this, you should no longer need:
> for foo in /sys/class/scsi_host/host*/link_power_management_policy;
> do echo med_power_with_dipm > $foo;
> done

> (Assuming you have compiled your kernel with CONFIG_SATA_MOBILE_LPM_POLICY=3).

Oh sweet! Will give it a spin over the weekend if I find the time.


> You shouldn't need to do:
> $ hdparm -Y

> As that bypasses some of the internal logic in libata.

> I assume that you didn't need this on v6.6 and older?

> (Instead libata should put the device to standby or sleep itself,
> it shouldn't need to be done explicitly by the user.)

I'm at a loss either. No idea why this is actually working. When I encountered the low-power issue I searched the web and stumbled upon hdparm -Y and gave it a shot.

> How certain are you that v6.6 works?

Let's put it this way: I've installed most 6.6-rc's so I had it running for several weeks and I always have an eye on conky showing me the c-states in 5 second interval. And during all that time and several suspends it never occured.

It definately started with the first 6.7 -rc I've installed (don't recall wich one first). There were no hardware changes and no BIOS updates during that time. If I find some spare time, I'm gonna give the latest 6.6 from kernel.org a spin to verify.

> Could it be the same problem there, that it works sometimes and doesn't
> work sometimes?

Again I've never encountered this issue with 6.6 or any other kernel before. I would have remembered that.

> The reason why I'm asking is that Damien's major changes got included
> in v6.6-rc4:
> https://lore.kernel.org/linux-ide/20230929133324.164211-1-dlemoal@kernel.org/[https://lore.kernel.org/linux-> ide/20230929133324.164211-1-dlemoal@kernel.org/]

> So I would be less surprised if you said that you can enter pc8 on every
> boot on v6.5, but on v6.6 it only works occasionally.

To be sure I would have to switch back to 6.6. If I find the time I'll give it a shot.

> But if you can enter pc8 on every boot on v6.6, but not on v6.7,
> then it is probably easier to figure out which commit that broke
> things, as there were not that many suspend/resume related changes
> added in v6.7.

Maybe you could point them out so I can try to bisect?

Kind regards,
Dieter

