Received: from mail-24427.protonmail.ch (mail-24427.protonmail.ch [109.224.244.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A439C5111B7
	for <linux-ide@vger.kernel.org>; Thu,  3 Sep 2026 20:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788466398; cv=none; b=Ya8iLA3r/+/aAH1wt5b3YaUkkY+Sae1WgHsp7XtFN7DhNrSk/Jg9km42gF/y4fjzhE+QcdLtoHAC+ymowsdqNOGuyjVva8RdIhMB7yCWJTtPbGTLaKxhY1jliXyYpEduCJehUX+bylbgbDEHx7r+Y6Aqn7wkvCMbKFMPpP8fYpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788466398; c=relaxed/simple;
	bh=LXHjJr+IdbhrkkyqJFRv5MyLW8lrOrhx7fkq0H/K5hc=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=l/HmH13M2WndUPadOp7uYuhSEUQGy4rrwMS47LHHxJTjNKYrzbQeVtSYpqs6coYr8YlXNF+hvSxwOH0atxH7SuP+yw7XGSdm/VCO8yBgsMQIgYOWIgZ4DG1H2ZgrwcQPw4hYHd/MLG8R7VbUUUNGnAVUbkhB9FHG5iqAc9jqgH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=XbporsVL; arc=none smtp.client-ip=109.224.244.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="XbporsVL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1788466381; x=1788725581;
	bh=DX0hZiadBDtqHKQzOVVnh8pL7Hr0j8UUMfOlW+lf5nI=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=XbporsVLFH8Dk7hx6XxO/XjiAUo1nEmR1sizrryQZRvKpccspeGyRl6Vf20DAEIlx
	 TJ2W/ATRCHz4AfixzsUyVw783PNC/OdJ0cWNCY8cpc3zDQ/9sYVsIq1uwYMxWeMq6L
	 eVl/wwdLTAsXlOOcuUS8eqmQ7ojvW7b4FycFnwPcQDcCpwiYlEqR0Bl2aDCJKxYl0Z
	 Po0Fss/sbmqxAnilZoaWBuj5db2dZBMR0Is7jfRZbjI19vB60q00CCO3jYn/ZnSljJ
	 ud+pMGSelD1TwKvZ63syp/oLW4aN2mjix4h6oTbZDpGk+ncqPitFmqGmBO3cFyWr2j
	 ZGhKJaL1/DNLw==
Date: Thu, 03 Sep 2026 20:12:56 +0000
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
From: jhon cadena <jhon_jairo_cadena@protonmail.com>
Cc: "regressions@lists.linux.dev" <regressions@lists.linux.dev>, "linux-pcmcia@lists.infradead.org" <linux-pcmcia@lists.infradead.org>
Subject: [REGRESSION] pata_pcmcia: ~80 second delay after physically removing PC Card CF device
Message-ID: <1zX3C-O2LeyhM2Zkz1FCkoqLUvxXWI_b5CfSB7DfI37xPsH9vIz1YlzPLWxAWUJi4rYcww6jDfuyKWZRBRQrzfUb0aLwkSHQxm9z_OHyMLU=@protonmail.com>
Feedback-ID: 9628936:user:proton
X-Pm-Message-ID: d9590fee390a352da29b1a65e999e0f2b5780017
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello,

I am reporting a possible regression in the PCMCIA/PATA/libata handling of =
a CompactFlash card used through a PC Card adapter.

The same type of PC Card storage worked normally on Debian 9 on my previous=
 Toughbook. After moving to Debian 11 with a newer kernel, physically remov=
ing the card causes an approximately 79-second delay while the kernel conti=
nues trying to access the device before finally disabling it.

The problem is reproducible.

Hardware:

-   Laptop: Panasonic Toughbook CF-31
   =20
-   CardBus controller: Ricoh Co Ltd CardBus bridge [1180:e476], rev 02
   =20
-   Storage: PQI Industrial CF Card
   =20
-   CF card capacity reported by the kernel: 245760 sectors (~120 MiB)
   =20
-   Interface: PC Card/CardBus -> PCMCIA -> PATA -> libata -> SCSI
   =20

Current software:

-   Debian 11
   =20
-   Kernel: 5.10.0-46-amd64
   =20
-   Architecture: amd64
   =20
-   Desktop: MATE
   =20

The device is detected as:

ata20: PATA max PIO0 cmd 0x9100 ctl 0x910e irq 19
ata20.00: ATA-4: PQI Industrial CF Card, ra6h.a01, max UDMA/33
ata20.00: 245760 sectors, multi 0: LBA

It then appears as /dev/sdb.

Reproduction:

1.  Insert the CF card into the PC Card slot.
   =20
2.  Mount the filesystem normally.
   =20
3.  Use Caja's "Eject" operation to unmount the filesystem.
   =20
4.  Physically remove the PC Card.
   =20
5.  The kernel then spends approximately 79 seconds trying to revalidate th=
e ATA device before finally disabling it.
   =20

The relevant messages are:

pcmcia_socket pcmcia_socket0: pccard: card ejected from slot 0
sd 6:0:0:0: [sdb] Stopping disk

Approximately 32 seconds later:

ata20: drained 65536 bytes to clear DRQ

Then:

ata20.00: qc timeout (cmd 0xec)
ata20.00: qc timeout (cmd 0xec)
ata20.00: qc timeout (cmd 0xec)
ata20.00: revalidation failed (errno=3D-5)
ata20.00: disabled

followed by:

sd 6:0:0:0: [sdb] Start/Stop Unit failed
... Not Ready ...
hard reset required

The total time from physical removal to the device being disabled is approx=
imately 79 seconds.

There is an important workaround which also provides a useful comparison:

If I first unmount the filesystem using Caja and then run:

sudo pccardctl eject 0

before physically removing the card, the problem does not occur. The card c=
an then be physically removed and another card inserted immediately, withou=
t the approximately 79-second delay.

This makes me suspect that the physical PCMCIA removal path is not synchron=
izing correctly with the ATA/libata device removal/revalidation path, altho=
ugh I do not know which component is responsible.

Another important observation is that I previously used Debian 9 on a diffe=
rent Panasonic Toughbook and did not experience this delay with PC Card sto=
rage. I do not have the old installation available at the moment, so I cann=
ot currently provide the exact kernel version that worked.

I have also checked:

cat /sys/module/libata/parameters/ata_probe_timeout

which returns:

0

The current kernel command line is:

BOOT_IMAGE=3D/boot/vmlinuz-5.10.0-46-amd64 root=3DUUID=3Df252ab9c-ab0e-4769=
-b123-4bac307fc566 ro quiet

I would appreciate any advice on whether this is a known issue or regressio=
n in pata_pcmcia/libata/PCMCIA handling, and what additional information or=
 testing would be useful.

I can reproduce the problem and run additional tests if needed.

Thank you.



dmesg output:

[58935.824119] =C2=A0sdb: sdb1[58940.922179] pcmcia_socket pcmcia_socket0: =
pccard: card ejected from slot 0
[58940.923642] sd 6:0:0:0: [sdb] Stopping disk
[58971.634659] ata22: drained 65536 bytes to clear DRQ
[58976.801978] ata22.00: qc timeout (cmd 0xec)
[58976.801986] ata22.00: failed to IDENTIFY (I/O error, err_mask=3D0x5)
[58976.801989] ata22.00: revalidation failed (errno=3D-5)
[58987.041967] ata22.00: qc timeout (cmd 0xec)
[58987.041974] ata22.00: failed to IDENTIFY (I/O error, err_mask=3D0x5)
[58987.041977] ata22.00: revalidation failed (errno=3D-5)
[59018.530087] ata22.00: qc timeout (cmd 0xec)
[59018.530094] ata22.00: failed to IDENTIFY (I/O error, err_mask=3D0x5)
[59018.530096] ata22.00: revalidation failed (errno=3D-5)
[59018.530102] ata22.00: disabled
[59018.694228] sd 6:0:0:0: [sdb] Start/Stop Unit failed: Result: hostbyte=
=3DDID_OK driverbyte=3DDRIVER_SENSE
[59018.694239] sd 6:0:0:0: [sdb] Sense Key : Not Ready [current]
[59018.694246] sd 6:0:0:0: [sdb] Add. Sense: Logical unit not ready, hard r=
eset required


J.C. Electric--lifetime warranty--
Jhon Cadena
Cel. 098700-9321
Whatsapp: 0995012430
Av. V=C3=ADctor Cartagena S6-78 y Argentina
Cayambe-Ecuador

Si al finalizar el d=C3=ADa, a=C3=BAn tienes energ=C3=ADa...significa que n=
o hiciste todo lo que pudiste haber hecho....

Enviado desde un correo electr=C3=B3nico seguro de Proton Mail.
