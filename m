Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0431511CBA
	for <linux-ide@vger.kernel.org>; Sat, 16 Mar 2024 11:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710588852; cv=none; b=U/IrBFirHrCXCjVb9yyMBWJzswtPX/uGh/HoG8VCl/0GIGweeSaKVbDwlfdXie2hbGC6UByW25XTlwP2T53XpRSbOJ9m/Fn3EuzK72ioFoL0QRv2366NBdMBuIT4Pab5J2Xwhdob5JKbyxBMtGoZXpW6vw5GP5ifaf7rRR3MJkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710588852; c=relaxed/simple;
	bh=8gCvAKRNQpgiZcehFWlRBhrMDAovpdMwXHsotKjoOUw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y2J6zz1JAQMvHErvdr8iT2Z+kdaewtC+MhoDwo8ycZZ4rCD+Nq8iWEUDMoK1PCCIokMIW/x/BHI4qCP397fBu1sSnmELslX2R72cOKjJD4h90aqfk5c/VAVJfAjLA6L5moYG53ZADiRH+tzw4y7TPQSH7vqhHMHTxmZD1Qft/nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=hLHq0484; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="hLHq0484"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dbed0710c74so2345403276.1
        for <linux-ide@vger.kernel.org>; Sat, 16 Mar 2024 04:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1710588848; x=1711193648; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XEXjUVU1Yxq5DR9cgNFPWWVFrAoYLHMDG9EsVNHMWVM=;
        b=hLHq0484v6zc6uaPloIaFKJeqWkhLsiJ3pk6ee/8/pyYeC5ewtomBkZJjfc8otMA0u
         heGvs8NF/TECusgJA9yXP/qXHUBL0GdaiJ4mZ/tdiNy8Co+oGfvD9hc0PZEWRtJx9Vhg
         eZTJGXr0GSRwiSykTQ3kl+lUyzzNIXAbW6kt+Zea8sFcwfobg01/EZXB3IT5ojm7gnUP
         02b8sZhaFsYu1KJm4pa5PZ9fEX7djF+z3aFUwvpwmbtTP4e6NvgjXAf8JskGTyJvelOU
         8OtQiVj9W7WscL4bjvhcOeGhONjrwXJrW0NehKzFwqOne3IcAanCHBffp8QApA7k1O+M
         ls/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710588848; x=1711193648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XEXjUVU1Yxq5DR9cgNFPWWVFrAoYLHMDG9EsVNHMWVM=;
        b=Irhteci2RfZ4P/XBJEcJK4y/SX03e7Rn9CsZQxzigi7C/sDrHc77XLwfnbssREDvW4
         7kaAE2HKxBDsp9TBmAokzfUHj3IkJp86e6ufwbkkdVJMC/zuBm5vxJlJ0TY7VA4IWOK0
         D43zSAwl0BXS0XAMATXNazS6+b9M7+PRcOAJQqvGFyfinwsPTWEnh4++N8ckqMmT70dq
         1x+catiPJWsx5LcPt2afm8rlN5ffJOvwyKBc+2ixAp+dR5UJEWLeTTIFXGMrofd2aWyq
         5iiHSrCArKthehwWGPkS9yijHuleBdX6bXWg8FEXPeUGxA/urk85ef/RxQrSL+4zCucA
         coTw==
X-Forwarded-Encrypted: i=1; AJvYcCXaGkJnJ1l8WtI4j41u604ZQXAU2sCJRp/tgxzGWgBR3tDWGB4zC8o+jnD0x7uvT6BVFWe8BESO4VUQ2MWbKC4vNAysyCwiEmq+
X-Gm-Message-State: AOJu0YxG7V+d5cONadAUKbGcokLSr+YOacBTL+2L6SV5scZqUpkcw5Lj
	YWJZSj1pgSOASbCZuNn8t/elicvM03vCrz5Ju47Ul0M6sNQ5s7iI/v3tzRdgt9m7nQSCJse88wp
	WHI/6zgRzSYiskHx5s1HTTb8A6TBlAK171Mc=
X-Google-Smtp-Source: AGHT+IFSjoYociRdA2kQSiKNv75QWet9h8yiiBKKbmat0dsyMEASVVd3mSm+47A+TnXoUUoIrRF/c9Nbd53etwuN2ro=
X-Received: by 2002:a05:6902:389:b0:dc7:4b43:db3f with SMTP id
 f9-20020a056902038900b00dc74b43db3fmr3985704ybs.21.1710588848124; Sat, 16 Mar
 2024 04:34:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFDm6W19R3KHDO09c94Uwry9mdG+whAVy=u4Sdpt30A2MK1KPA@mail.gmail.com>
 <CA+PODjqxYcBMc=R792uOava1u0EYZtrWTOw9HvKUBG4=zYbzcg@mail.gmail.com>
 <CAFDm6W2dWu5+Dz2DiWG_9L-VatM6Wj=pMHM2th74Wh144kvqvg@mail.gmail.com>
 <ZfMerqAmWoyu66/5@x1-carbon> <2e471c2b-8432-4501-b093-4295529a4d38@redhat.com>
In-Reply-To: <2e471c2b-8432-4501-b093-4295529a4d38@redhat.com>
From: Cryptearth <cryptearth@googlemail.com>
Date: Sat, 16 Mar 2024 12:33:57 +0100
Message-ID: <CAFDm6W0zP=Yw_OA9_qJ17Np=px=sR69m9hGF3D96A9gyS5PLTQ@mail.gmail.com>
Subject: Re: ASMedia ASM1166/ASM1064 port restrictions will break cards with port-multipliers
To: Hans de Goede <hdegoede@redhat.com>
Cc: Niklas Cassel <cassel@kernel.org>, Andrey Melnikov <temnota.am@gmail.com>, linux-ide@vger.kernel.org, 
	conikost@gentoo.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

First of all: Thank you to anyone looking into this. From the initial
responses I felt like "Well, bad card - go get some proper stuff".
Second: Sorry for the late reply, for some reason gmail not notified
me about the new mails.

I will try the provided patch to see if this makes any difference
about how the card behaves.

Here're the output from sudo lspci -vvv -nn

04:00.0 SATA controller [0106]: ASMedia Technology Inc. ASM1064 Serial
ATA Controller [1b21:1064] (rev 02) (prog-if 01 [AHCI 1.0])
       Subsystem: ZyDAS Technology Corp. Device [2116:2116]
       Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
       Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
       Latency: 0, Cache Line Size: 64 bytes
       Interrupt: pin A routed to IRQ 41
       IOMMU group: 15
       Region 0: Memory at fcd82000 (32-bit, non-prefetchable) [size=3D8K]
       Region 5: Memory at fcd80000 (32-bit, non-prefetchable) [size=3D8K]
       Expansion ROM at fcd00000 [disabled] [size=3D512K]
       Capabilities: [40] Power Management version 3
               Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
               Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
       Capabilities: [50] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
               Address: 00000000fee00000  Data: 0000
       Capabilities: [80] Express (v2) Endpoint, IntMsgNum 0
               DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s
unlimited, L1 unlimited
                       ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
SlotPowerLimit 26W
               DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
                       RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
                       MaxPayload 128 bytes, MaxReadReq 512 bytes
               DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq-
AuxPwr+ TransPend-
               LnkCap: Port #0, Speed 8GT/s, Width x1, ASPM L0s L1,
Exit Latency L0s <4us, L1 <64us
                       ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
               LnkCtl: ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk+
                       ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
               LnkSta: Speed 8GT/s, Width x1
                       TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
               DevCap2: Completion Timeout: Not Supported, TimeoutDis-
NROPrPrP- LTR-
                        10BitTagComp- 10BitTagReq- OBFF Not Supported,
ExtFmt- EETLPPrefix-
                        EmergencyPowerReduction Not Supported,
EmergencyPowerReductionInit-
                        FRS- TPHComp- ExtTPHComp-
                        AtomicOpsCap: 32bit- 64bit- 128bitCAS-
               DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
                        AtomicOpsCtl: ReqEn-
                        IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
                        10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
               LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink-
Retimer- 2Retimers- DRS-
               LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis=
+
                        Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
                        Compliance Preset/De-emphasis: -6dB
de-emphasis, 0dB preshoot
               LnkSta2: Current De-emphasis Level: -6dB,
EqualizationComplete+ EqualizationPhase1+
                        EqualizationPhase2+ EqualizationPhase3+
LinkEqualizationRequest-
                        Retimer- 2Retimers- CrosslinkRes: unsupported
       Capabilities: [100 v1] Advanced Error Reporting
               UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
               UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
               UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt-
UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
               CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
AdvNonFatalErr-
               CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
AdvNonFatalErr+
               AERCap: First Error Pointer: 00, ECRCGenCap- ECRCGenEn-
ECRCChkCap- ECRCChkEn-
                       MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
               HeaderLog: 00000000 00000000 00000000 00000000
       Capabilities: [130 v1] Secondary PCI Express
               LnkCtl3: LnkEquIntrruptEn- PerformEqu-
               LaneErrStat: 0
       Kernel driver in use: ahci

The card I use is one like these: https://www.ebay.com/itm/204230341609
When you search for "20 port sata" you will quite a list of such cards
- there're even ones with more than 20 ports, like this massive 24
port card: https://www.ebay.com/itm/394640351214
The subsystem IDs don't lead to anywhere - from a quick google search
it seems they use it on any of the cards no matter if it's a ASM1064
or ASM1166. So, using it as a filter likely doesn't cut it for
something like auto-detection. A manual override is likely the best
way to go - however it ends up implemented.

I'm not sure exactly - but here's as how I understand it: Some (likely
chinese) oem just get some ASMedia chips as base controllers along
with some sata port multiplier like the JMicron JMB575 and create such
abominations as the cards linked. From what I can tell: Each chip has
its own eeprom flash and they're just directly connected: One JMB575
multiplier at each of the ASM1064 upstream ports.
btw: the JMB575 is a 1-to-5 multiplier.
When I first used that card I already noted that it lists 24 ports -
but I thought that this could be some kind of "masking" the 4 upstream
ports as they get faned out by the multipliers. This is also the
behaviour on Windows: It shows 24 ports in sequence with 4 of them
somewhere in the middle just unuseable. According to windows this card
is even supposed to support hot plug - although I haven't tested that
yet.
It also supports power-up-in-standby of the my drives, although that
massively increases my boot time from about 30 seconds when all drives
start up on power up (my PSU can handle it - although I plan on expand
my pool hence I have such a HBA) to about 2 minutes when each drive is
spun up one at a time.

As these cards are so common and in such wide varieties my guss is
that there's some generic firmware which was written once and in a way
to work on all of these cards - and hence just reports up to 32 ports.
It could be that it was done in a way "to just work with the least
amount of effort" and hence can cause side effects.

I still hassle with the initial report: I couldn't tell any time lost
or gained. For me the probe of an unused port only takes roughly 0.3
seconds. Even multiplying by 128 I only get about 40 seconds. How
would someone end up with 3-4 minutes? On the other hand: When a drive
is connected and has to be initialized this does take more time - for
me roughly 1 second per drive. But even then a jbod with 128 drives
would take only 2 minutes or so. Is there something I just don't get
because I don't know or don't understand properly?

Anyway, have a nice weekend.
I'll report back when I tested the patch.

Greetings from Germany

Matt

Am Fr., 15. M=C3=A4rz 2024 um 16:01 Uhr schrieb Hans de Goede <hdegoede@red=
hat.com>:
>
> Hi Niklas,
>
> On 3/14/24 4:58 PM, Niklas Cassel wrote:
> > Hello Matt,
> >
> > On Wed, Mar 13, 2024 at 06:37:56PM +0100, Cryptearth wrote:
> >>
> >> As for why the ASM chips report 30+ ports: A wild guess in the blue:
> >> They were designed with port multipliers in mind and likely report the
> >> max number of drives they can handle when combined with multipliers.
> >> From what I get the "fix" is supposed to reduce boot time - well, from
> >> my logs I see it's not the enumeration of the empty ports which takes
> >> time but of course the initialization of the detected drives.
> >> To me the initial report that lead to this changed just should had
> >> been marked as won't fix or even as invalid - as looking thru the
> >> history of ahci.c litterally noone seem to have bothered about it
> >> since the ASM IDs were added.
> >
> > Well, that is simply not how PMP works.
>
> Did you see my analysis of this problem here:
>
> https://lore.kernel.org/linux-ide/066b051d-f092-4ba2-9a26-1c73f3df4252@re=
dhat.com/
>
> It seems that the ASM1166/ASM1064 sata controllers transparently handle
> attached PMP-s of up to 4 ports per PMP which is why the 4 port ASM1064
> advertises 16 (4x4) extra "virtual" ports and the 6 port advertises
> 24 (6x4) extra "virtual" ports.
>
> When a PMP is attached then this is handled inside the controller and
> the attached disks show up on the extra port numbers 8-23 / 8 - 31
> (and nothing shows on the actual port numbers 0-3 / 0-5).
>
> So the "fix" to get the boards with PMP to work again is to drop
> the quirk restricting the number of ports to the number of physical
> ports, so that Linux probes the virtual-ports again and then everything
> works again as before, with the downside of probing the virtual ports
> slowing down the boot.
>
>
>
>
>
>
> >
> > For PMP to be supported the HBA needs to set CAP.SPM (Supports Port Mul=
iplier).
> > (This also implies Command-based switching is supported.)
> >
> > The HBA can additionally set CAP.FBSS (FIS-based Switching Supported),
> > if CAP.SPM is set.
> >
> > If CAP.SPM is set, you can plug in a PMP to each of the ports.
> > Each PMP can support a max of 15 ports.
> >
> > If PMP is enabled, you fill in the port number behind the port when
> > queuing the command:
> > https://github.com/torvalds/linux/blob/v6.8/drivers/ata/libahci.c#L1424
> > https://github.com/torvalds/linux/blob/v6.8/drivers/ata/libata-sata.c#L=
154
> >
> >
> > Looking at your SATA HBA:
> >> [    0.608537] ahci 0000:04:00.0: AHCI 0001.0301 32 slots 24 ports 6 G=
bps 0xffff0f impl SATA mode
> >> [    0.608540] ahci 0000:04:00.0: flags: 64bit ncq sntf stag pm led on=
ly pio sxs deso sadm sds apst
> >
> > We can see that it does not support PMP at all.
> > There is no "pmp" in print, which means that CAP.SPM was not set.
> >
> > So your HBA does not support PMP, sorry.
> >
> >
> > Yes, we can see that it claims that it has 24 ports from the print, so =
it
> > appears that they have implemented their own version of PMP that is not
> > compatible with AHCI. Lovely :)
> >
> >
> >
> > I think this brings more questions than answers...
> >
> > What is the PCI device and vendor ID for this device?
> >
> > You said that this is a PCIe card with a ASM1064 and two port multiplie=
rs
> > on the same PCIe card?
> >
> > From what we've heard before, a ASMedia card with 4 physical slots,
> > like this card:
> > https://www.newegg.com/p/17Z-0061-000B5
> >
> > Has PCIe device and vendor ID:
> > { PCI_VDEVICE(ASMEDIA, 0x1064), board_ahci },   /* ASM1064 */
> >
> > But you have a PCIe card with the same device and vendor ID,
> > but your card also has 2 port multipliers with 4 ports each?
> >
> > Well, I guess it should be fine to use the PCI device and vendor ID
> > for the underlying HBA... considering that devices connected to the
> > ports are supposed to be discoverable...
> >
> > If they only claimed that the HBA supported PMP, the Linux device
> > driver would try to enumerate the devices behind the PMP according
> > to the standard.
> >
> > See AHCI 1.3.1, section 9.2 Port Multiplier Enumeration.
> > Or
> > SATA-IO - Port Multiplier 1.0, 7.4.2 Device Enumeration.
> >
> > The PMP standard also describes how you read the device and vendor
> > ID of the PMP.
> >
> >
> > Right now, they AMedia? seem to have their own home-made PMP implementa=
tion.
>
> Ah, ok so I think you did see my reply? Checking if we can ignore
> the builtin PMP support and uses Linux PMP support instead is
> indeed an option.
>
> I think we should still merge the revert / dropping of the quirk
> while we figure this out though, because not finding people's disks
> anymore is a clear regression.
>
> Regards,
>
> Hans
>
>
>
>
>
>
>
> > Could you try the attached patch on top of v6.8, to see if Linux
> > can detect the devices behind the two JMB575 PMPs?
> >
> > If that works, we could still support PMP (according to the standard),
> > and people with a ASM1064 PCIe card that does not have any port multipl=
iers
> > on the PCIe card would not suffer from significantly increased boot tim=
es.
> >
> > I guess a second step would be to see if ASM1064 also supports
> > FIS-based switching.
> >
> > https://www.asmedia.com.tw/product/A58yQC9Sp5qg6TrF/58dYQ8bxZ4UR9wG5
> >
> > Simply says "Supported port multiplier command based switching",
> > it doesn't seem to mention FIS-based switching... so I guess not?
> > (If it did, libata already has a AHCI_HFLAG_YES_FBS for other broken HB=
As.)
> >
> >
> > Kind regards,
> > Niklas
>
