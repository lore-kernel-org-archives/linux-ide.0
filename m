Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5653E182B4
	for <linux-ide@vger.kernel.org>; Tue,  6 May 2025 11:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746530990; cv=none; b=teSLAhpVx3lNjwuTp68s+0HXxV2SWKUBFAg3QfqO3PEzLttE1Un7ChUzHD08xnQOC9hyeGnIa+aQY3MQts4BYOgoZMCzBEdzKAMY/2CeoHQ280ujETAtIg93C959DlHMwYT1sH4m9Z7WI11QqGcVgFAQeQ9B0c+TCa3gOaDGwcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746530990; c=relaxed/simple;
	bh=HiafSWVKm2a7XlnRJ7MqGdKM86q78YzjIkBdc3QdC10=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OROmwM32N+UaUvnBx0VYRoNSd/PCmO4HfZa1OqOgeufCoSMF4nhKMKJ04SAEEM07W1O3QuhwQpumHVYYhXxuOn+ouseN1V9V6M336AwbWl73hH9y+Jsvw64gXS6meeBQd+9Wcz1vzOxP69IfLLtOkwMJKrdlOwjPpMxb5kHb9hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bmVa6vOj; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bmVa6vOj"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e63a159525bso4475304276.2
        for <linux-ide@vger.kernel.org>; Tue, 06 May 2025 04:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746530987; x=1747135787; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=smazbsRwJxBfnZqh7dq0NLDVandt0jW6/jjHwR26WrM=;
        b=bmVa6vOj8VYZhNx4vYVWGt7URS85IbyBRffUCK9SeP1aLxRJfw/TQx+EtiZecaVYic
         SA/xwK2hn8zcJmRKFbr9IMe/jn1W51SCN3r9dS8FgrPucCZB5TozUMsnCRRxYLyvDdFr
         zh4n+cBBKwns4QWI33Xu6zZ4NuxQTrhJuzzgEdH/FXghEsmI/lT2ca+gnrcYdmjEXWL3
         xv/TMuahyTZxm4KnXg4qlBCihP5Hbjt2KWkit3sad4ddl7kK4BUPHGrLWqNNqtmUGP8i
         IbLltr00+F5qRnTXhvivxj0BBbnoJJNwHC2/HtSkd8kE1Zff6vm+c0K2YKy9fyg952sS
         +XhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746530987; x=1747135787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=smazbsRwJxBfnZqh7dq0NLDVandt0jW6/jjHwR26WrM=;
        b=RqdCbd3kgo1Somr9oNxKddimFthaW/AMO/OyVFyQWO/othMxQufZLwx1TgNyRUUY2b
         QnraoV2ruPW3kmin458RquFJdMT4gMPRQIYzah08IXFESQsBW9FC/zHDRZTv2C4d+l3t
         Qb9ED8sT6Ob9N3KisjUfy2ahlT2bLwmmLE9K1jCxIUrhitzhIIj3arkeWWLPykLCFAbb
         yCfb0nfE3un07J50Pj7u9uiSxYGwLk1xSZ7WNw8KY+pemE9gxfAYNeo5LGIwq9O8dJKP
         t5AQjA4NOcSo1WRvc+GD+BPKIsspSIfLflnfbIz5pjDt/NbV44e2WvwW0b0NnL2BgAm+
         nXJw==
X-Gm-Message-State: AOJu0YyasJLLVqehGlr3gmJ+QjTOBZp7x4y6GteMpgNZKyRnCuBzJhGs
	3j8sD5laH4xS8GSPW/ODmHt0dK08Yf15kIhaHNmYgNI2hAwvc6MRAZt2wV8hoslc7YRmsOQb3MP
	r/lh+YNSDWxqTIoJQ5TRCUR2vlpw=
X-Gm-Gg: ASbGncvwxAhAaAzsBYnF1PtkAo//noMEvCTpEDJOKqEQ8+/TRUL4oV4LuV82wN2nk/P
	IBCabx3eFApLjsP0OWcu58OYIq9xPgdfzLdGZFMfujo1rhaSkJNLGO5anThtDQRcQuHDXSB6MPq
	fkmT2FCvGqmv3IHNSQ2JID6jU=
X-Google-Smtp-Source: AGHT+IFCQ5myS9oxZ0eRzIp1QfMi/gv0euZC2JXcEWoJsI9LR1sHxTL4/DQOKPAw6QSJPIioOF8jMqx7MyrYcguv7Hg=
X-Received: by 2002:a05:6902:2004:b0:e73:11a5:bcb8 with SMTP id
 3f1490d57ef6-e75c08f6eb9mr3169708276.18.1746530987066; Tue, 06 May 2025
 04:29:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADUzMVaY_nv1tjFtSuuPiNE6=_h2LABaDAjuOhK=FUdDB-LsrQ@mail.gmail.com>
In-Reply-To: <CADUzMVaY_nv1tjFtSuuPiNE6=_h2LABaDAjuOhK=FUdDB-LsrQ@mail.gmail.com>
From: Mikko Juhani Korhonen <mjkorhon@gmail.com>
Date: Tue, 6 May 2025 14:29:11 +0300
X-Gm-Features: ATxdqUH4hkMDdXxtLTuA9YDINdspOufpZVuSTwTg69lWPF3TJPILmRKLZxfAdO0
Message-ID: <CAAZ0mTd_jc4E-s6JzjR-DB4m7Ds__YezU_AGKhXnXyL1JDeAkw@mail.gmail.com>
Subject: Re: [PATCH v4] ata: libata: disable LPM for WDC WD20EFAX-68FB5N0 hard drives
To: Ioannis Barkas <jnyb.de@gmail.com>, Niklas Cassel <Niklas.Cassel@wdc.com>, 
	Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

ma 5.5.2025 klo 22.41 Ioannis Barkas (jnyb.de@gmail.com) kirjoitti:
> Please run a short test to each one to ensure that everything is OK
> after working for 10K+ hours and share their health log again.
The tests were ok, see below.

> expected following that initial event. You just leave the PC on and
> then you get that event on both?
Yes, and forgot to mention that it happens usually very soon (see the
time stamps in the kernel log I sent earlier),  and consistently every
time I have tried.

> retest. The controller-disk combo should work fine. Just to clarify
> things, upon turning off LPM, you get no error at all?
Yes, zero errors with either with ATA_QUIRK_NO_LPM or 6.8.x.

> Except the short form of lspci, let's get the fulll dump for SATA
> controller to see its active PCI settings with:
> sudo lspci -nnnnvvvvxxxxks 01:00.1
> You can get it before touching anything and then with 3621 fw if you
> update your board. This will pinpoint if anything has been modified
I upgraded from 3611 to 3621 and the lspci output didn't change.

Regards,
Mikko
------------------------------

mjkorhon@taavi:~$ cat lspci-3611
01:00.1 SATA controller [0106]: Advanced Micro Devices, Inc. [AMD] 500
Series Chipset SATA Controller [1022:43eb] (prog-if 01 [AHCI 1.0])
       Subsystem: ASMedia Technology Inc. ASM1062 Serial ATA
Controller [1b21:1062]
       Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
       Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
       Latency: 0, Cache Line Size: 64 bytes
       Interrupt: pin B routed to IRQ 42
       IOMMU group: 14
       Region 5: Memory at fc580000 (32-bit, non-prefetchable) [size=3D128K=
]
       Expansion ROM at fc500000 [disabled] [size=3D512K]
       Capabilities: [50] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
               Address: 00000000fee00000  Data: 0000
       Capabilities: [78] Power Management version 3
               Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D55mA
PME(D0-,D1-,D2-,D3hot+,D3cold+)
               Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
       Capabilities: [80] Express (v2) Legacy Endpoint, IntMsgNum 0
               DevCap: MaxPayload 512 bytes, PhantFunc 0, Latency L0s
<64ns, L1 <64us
                       ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset- TEE-=
IO-
               DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
                       RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
                       MaxPayload 128 bytes, MaxReadReq 512 bytes
               DevSta: CorrErr+ NonFatalErr- FatalErr- UnsupReq+
AuxPwr+ TransPend-
               LnkCap: Port #0, Speed 8GT/s, Width x4, ASPM L0s L1,
Exit Latency L0s <2us, L1 <32us
                       ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
               LnkCtl: ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk+
                       ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
               LnkSta: Speed 8GT/s, Width x4
                       TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
               DevCap2: Completion Timeout: Not Supported, TimeoutDis-
NROPrPrP- LTR+
                        10BitTagComp- 10BitTagReq- OBFF Not Supported,
ExtFmt+ EETLPPrefix-
                        EmergencyPowerReduction Not Supported,
EmergencyPowerReductionInit-
                        FRS-
                        AtomicOpsCap: 32bit- 64bit- 128bitCAS-
               DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
                        AtomicOpsCtl: ReqEn-
                        IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
                        10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
               LnkSta2: Current De-emphasis Level: -6dB,
EqualizationComplete- EqualizationPhase1-
                        EqualizationPhase2- EqualizationPhase3-
LinkEqualizationRequest-
                        Retimer- 2Retimers- CrosslinkRes: unsupported
       Capabilities: [100 v1] Advanced Error Reporting
               UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
UnxCmplt- RxOF- MalfTLP-
                       ECRC- UnsupReq- ACSViol- UncorrIntErr-
BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
                       PoisonTLPBlocked- DMWrReqBlocked- IDECheck-
MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
               UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
UnxCmplt- RxOF- MalfTLP-
                       ECRC- UnsupReq- ACSViol- UncorrIntErr-
BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
                       PoisonTLPBlocked- DMWrReqBlocked- IDECheck-
MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
               UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt-
UnxCmplt- RxOF+ MalfTLP+
                       ECRC- UnsupReq- ACSViol- UncorrIntErr-
BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
                       PoisonTLPBlocked- DMWrReqBlocked- IDECheck-
MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
               CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
AdvNonFatalErr+ CorrIntErr- HeaderOF-
               CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
AdvNonFatalErr+ CorrIntErr- HeaderOF-
               AERCap: First Error Pointer: 00, ECRCGenCap+ ECRCGenEn-
ECRCChkCap- ECRCChkEn-
                       MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
               HeaderLog: 00000000 00000000 00000000 00000000
       Kernel driver in use: ahci
       Kernel modules: ahci
00: 22 10 eb 43 06 04 10 00 00 01 06 01 10 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 58 fc 00 00 00 00 21 1b 62 10
30: 00 00 50 fc 50 00 00 00 00 00 00 00 0a 02 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 05 78 81 00 00 00 e0 fe 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 11 78 07 00 00 20 00 00
70: 80 20 00 00 00 00 00 00 01 80 43 c0 08 00 00 00
80: 10 00 12 00 22 8c 2c 01 1f 29 19 00 43 dc 42 00
90: 40 00 43 10 00 00 00 00 00 00 40 00 00 00 00 00
a0: 00 00 00 00 00 08 10 00 00 00 00 00 0e 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 21 1b 01 02 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: cc 0d 00 00 01 01 01 01 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
100: 01 00 01 00 00 00 00 00 00 00 00 00 31 20 06 00
110: 00 20 00 00 00 20 00 00 20 00 00 00 00 00 00 00
120: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
130: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
140: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
150: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
160: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
170: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
180: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
190: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
1a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
1b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
1c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
1d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
1e0: cc 0d 00 00 01 01 01 01 00 00 00 00 00 00 00 00
1f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
200: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
210: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
220: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
230: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
240: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
250: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
260: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
270: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
280: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
290: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
2a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
2b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
2c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
2d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
2e0: cc 0d 00 00 01 01 01 01 00 00 00 00 00 00 00 00
2f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
300: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
310: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
320: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
330: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
340: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
350: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
360: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
370: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
380: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
390: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
3a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
3b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
3c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
3d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
3e0: cc 0d 00 00 01 01 01 01 00 00 00 00 00 00 00 00
3f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
400: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
410: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
420: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
430: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
440: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
450: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
460: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
470: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
480: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
490: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
4a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
4b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
4c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
4d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
4e0: cc 0d 00 00 01 01 01 01 00 00 00 00 00 00 00 00
4f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
500: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
510: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
520: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
530: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
540: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
550: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
560: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
570: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
580: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
590: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
5a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
5b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
5c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
5d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
5e0: cc 0d 00 00 01 01 01 01 00 00 00 00 00 00 00 00
5f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
600: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
610: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
620: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
630: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
640: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
650: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
660: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
670: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
680: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
690: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
6a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
6b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
6c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
6d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
6e0: cc 0d 00 00 01 01 01 01 00 00 00 00 00 00 00 00
6f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
700: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
710: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
720: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
730: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
740: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
750: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
760: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
770: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
780: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
790: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
7a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
7b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
7c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
7d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
7e0: cc 0d 00 00 01 01 01 01 00 00 00 00 00 00 00 00
7f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
800: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
810: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
820: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
830: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
840: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
850: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
860: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
870: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
880: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
890: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
8a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
8b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
8c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
8d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
8e0: cc 0d 00 00 01 01 01 01 00 00 00 00 00 00 00 00
8f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
900: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
910: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
920: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
930: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
940: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
950: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
960: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
970: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
980: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
990: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
9a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
9b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
9c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
9d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
9e0: cc 0d 00 00 01 01 01 01 00 00 00 00 00 00 00 00
9f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
aa0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ab0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ac0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ad0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ae0: cc 0d 00 00 01 01 01 01 00 00 00 00 00 00 00 00
af0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ba0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
bb0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
bc0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
bd0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
be0: cc 0d 00 00 01 01 01 01 00 00 00 00 00 00 00 00
bf0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ca0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
cb0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
cc0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
cd0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ce0: cc 0d 00 00 01 01 01 01 00 00 00 00 00 00 00 00
cf0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
da0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
db0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
dc0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
dd0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
de0: cc 0d 00 00 01 01 01 01 00 00 00 00 00 00 00 00
df0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ea0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
eb0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ec0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ed0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ee0: cc 0d 00 00 01 01 01 01 00 00 00 00 00 00 00 00
ef0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fa0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fb0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fc0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fd0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
fe0: cc 0d 00 00 01 01 01 01 00 00 00 00 00 00 00 00
ff0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00



-------------------------
mjkorhon@taavi:~$ sudo smartctl -a /dev/sda
smartctl 7.4 2023-08-01 r5530 [x86_64-linux-6.14.3mk] (local build)
Copyright (C) 2002-23, Bruce Allen, Christian Franke, www.smartmontools.org

=3D=3D=3D START OF INFORMATION SECTION =3D=3D=3D
Model Family:     Western Digital Red (SMR)
Device Model:     WDC WD20EFAX-68FB5N0
Serial Number:    WD-WXR1A893J1A3
LU WWN Device Id: 5 0014ee 267192206
Firmware Version: 82.00A82
User Capacity:    2=E2=80=AF000=E2=80=AF398=E2=80=AF934=E2=80=AF016 bytes [=
2,00 TB]
Sector Sizes:     512 bytes logical, 4096 bytes physical
Rotation Rate:    5400 rpm
Form Factor:      3.5 inches
TRIM Command:     Available
Device is:        In smartctl database 7.3/5528
ATA Version is:   ACS-3 T13/2161-D revision 5
SATA Version is:  SATA 3.1, 6.0 Gb/s (current: 6.0 Gb/s)
Local Time is:    Tue May  6 14:22:36 2025 EEST
SMART support is: Available - device has SMART capability.
SMART support is: Enabled

=3D=3D=3D START OF READ SMART DATA SECTION =3D=3D=3D
SMART overall-health self-assessment test result: PASSED

General SMART Values:
Offline data collection status:  (0x00) Offline data collection activity
                                       was never started.
                                       Auto Offline Data Collection: Disabl=
ed.
Self-test execution status:      (   0) The previous self-test routine comp=
leted
                                       without error or no self-test has ev=
er
                                       been run.
Total time to complete Offline
data collection:                (  224) seconds.
Offline data collection
capabilities:                    (0x7b) SMART execute Offline immediate.
                                       Auto Offline data collection
on/off support.
                                       Suspend Offline collection upon new
                                       command.
                                       Offline surface scan supported.
                                       Self-test supported.
                                       Conveyance Self-test supported.
                                       Selective Self-test supported.
SMART capabilities:            (0x0003) Saves SMART data before entering
                                       power-saving mode.
                                       Supports SMART auto save timer.
Error logging capability:        (0x01) Error logging supported.
                                       General Purpose Logging supported.
Short self-test routine
recommended polling time:        (   2) minutes.
Extended self-test routine
recommended polling time:        ( 243) minutes.
Conveyance self-test routine
recommended polling time:        (   2) minutes.
SCT capabilities:              (0x303d) SCT Status supported.
                                       SCT Error Recovery Control supported=
.
                                       SCT Feature Control supported.
                                       SCT Data Table supported.

SMART Attributes Data Structure revision number: 16
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE
UPDATED  WHEN_FAILED RAW_VALUE
 1 Raw_Read_Error_Rate     0x002f   200   200   051    Pre-fail
Always       -       0
 3 Spin_Up_Time            0x0027   173   168   021    Pre-fail
Always       -       2325
 4 Start_Stop_Count        0x0032   095   095   000    Old_age
Always       -       5051
 5 Reallocated_Sector_Ct   0x0033   200   200   140    Pre-fail
Always       -       0
 7 Seek_Error_Rate         0x002e   200   200   000    Old_age
Always       -       0
 9 Power_On_Hours          0x0032   082   082   000    Old_age
Always       -       13383
10 Spin_Retry_Count        0x0032   100   100   000    Old_age
Always       -       0
11 Calibration_Retry_Count 0x0032   100   100   000    Old_age
Always       -       0
12 Power_Cycle_Count       0x0032   096   096   000    Old_age
Always       -       4554
192 Power-Off_Retract_Count 0x0032   200   200   000    Old_age
Always       -       254
193 Load_Cycle_Count        0x0032   199   199   000    Old_age
Always       -       4799
194 Temperature_Celsius     0x0022   110   101   000    Old_age
Always       -       33
196 Reallocated_Event_Count 0x0032   200   200   000    Old_age
Always       -       0
197 Current_Pending_Sector  0x0032   200   200   000    Old_age
Always       -       0
198 Offline_Uncorrectable   0x0030   100   253   000    Old_age
Offline      -       0
199 UDMA_CRC_Error_Count    0x0032   200   200   000    Old_age
Always       -       123
200 Multi_Zone_Error_Rate   0x0008   100   253   000    Old_age
Offline      -       0

SMART Error Log Version: 1
No Errors Logged

SMART Self-test log structure revision number 1
Num  Test_Description    Status                  Remaining
LifeTime(hours)  LBA_of_first_error
# 1  Short offline       Completed without error       00%     13380       =
  -

SMART Selective self-test log data structure revision number 1
SPAN  MIN_LBA  MAX_LBA  CURRENT_TEST_STATUS
   1        0        0  Not_testing
   2        0        0  Not_testing
   3        0        0  Not_testing
   4        0        0  Not_testing
   5        0        0  Not_testing
Selective self-test flags (0x0):
 After scanning selected spans, do NOT read-scan remainder of disk.
If Selective self-test is pending on power-up, resume after 0 minute delay.

The above only provides legacy SMART information - try 'smartctl -x' for mo=
re

---------------------------------------------------
mjkorhon@taavi:~$ sudo smartctl -a /dev/sdb
smartctl 7.4 2023-08-01 r5530 [x86_64-linux-6.14.3mk] (local build)
Copyright (C) 2002-23, Bruce Allen, Christian Franke, www.smartmontools.org

=3D=3D=3D START OF INFORMATION SECTION =3D=3D=3D
Model Family:     Western Digital Red (SMR)
Device Model:     WDC WD20EFAX-68FB5N0
Serial Number:    WD-WXR1A893J2TN
LU WWN Device Id: 5 0014ee 2bc6eea22
Firmware Version: 82.00A82
User Capacity:    2=E2=80=AF000=E2=80=AF398=E2=80=AF934=E2=80=AF016 bytes [=
2,00 TB]
Sector Sizes:     512 bytes logical, 4096 bytes physical
Rotation Rate:    5400 rpm
Form Factor:      3.5 inches
TRIM Command:     Available
Device is:        In smartctl database 7.3/5528
ATA Version is:   ACS-3 T13/2161-D revision 5
SATA Version is:  SATA 3.1, 6.0 Gb/s (current: 6.0 Gb/s)
Local Time is:    Tue May  6 14:23:32 2025 EEST
SMART support is: Available - device has SMART capability.
SMART support is: Enabled

=3D=3D=3D START OF READ SMART DATA SECTION =3D=3D=3D
SMART overall-health self-assessment test result: PASSED

General SMART Values:
Offline data collection status:  (0x00) Offline data collection activity
                                       was never started.
                                       Auto Offline Data Collection: Disabl=
ed.
Self-test execution status:      (   0) The previous self-test routine comp=
leted
                                       without error or no self-test has ev=
er
                                       been run.
Total time to complete Offline
data collection:                (63840) seconds.
Offline data collection
capabilities:                    (0x7b) SMART execute Offline immediate.
                                       Auto Offline data collection
on/off support.
                                       Suspend Offline collection upon new
                                       command.
                                       Offline surface scan supported.
                                       Self-test supported.
                                       Conveyance Self-test supported.
                                       Selective Self-test supported.
SMART capabilities:            (0x0003) Saves SMART data before entering
                                       power-saving mode.
                                       Supports SMART auto save timer.
Error logging capability:        (0x01) Error logging supported.
                                       General Purpose Logging supported.
Short self-test routine
recommended polling time:        (   2) minutes.
Extended self-test routine
recommended polling time:        ( 250) minutes.
Conveyance self-test routine
recommended polling time:        (   2) minutes.
SCT capabilities:              (0x303d) SCT Status supported.
                                       SCT Error Recovery Control supported=
.
                                       SCT Feature Control supported.
                                       SCT Data Table supported.

SMART Attributes Data Structure revision number: 16
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE
UPDATED  WHEN_FAILED RAW_VALUE
 1 Raw_Read_Error_Rate     0x002f   200   200   051    Pre-fail
Always       -       0
 3 Spin_Up_Time            0x0027   172   168   021    Pre-fail
Always       -       2366
 4 Start_Stop_Count        0x0032   095   095   000    Old_age
Always       -       5051
 5 Reallocated_Sector_Ct   0x0033   200   200   140    Pre-fail
Always       -       0
 7 Seek_Error_Rate         0x002e   200   200   000    Old_age
Always       -       0
 9 Power_On_Hours          0x0032   082   082   000    Old_age
Always       -       13383
10 Spin_Retry_Count        0x0032   100   100   000    Old_age
Always       -       0
11 Calibration_Retry_Count 0x0032   100   100   000    Old_age
Always       -       0
12 Power_Cycle_Count       0x0032   096   096   000    Old_age
Always       -       4553
192 Power-Off_Retract_Count 0x0032   200   200   000    Old_age
Always       -       254
193 Load_Cycle_Count        0x0032   199   199   000    Old_age
Always       -       4800
194 Temperature_Celsius     0x0022   110   103   000    Old_age
Always       -       33
196 Reallocated_Event_Count 0x0032   200   200   000    Old_age
Always       -       0
197 Current_Pending_Sector  0x0032   200   200   000    Old_age
Always       -       0
198 Offline_Uncorrectable   0x0030   100   253   000    Old_age
Offline      -       0
199 UDMA_CRC_Error_Count    0x0032   200   200   000    Old_age
Always       -       0
200 Multi_Zone_Error_Rate   0x0008   100   253   000    Old_age
Offline      -       0

SMART Error Log Version: 1
No Errors Logged

SMART Self-test log structure revision number 1
Num  Test_Description    Status                  Remaining
LifeTime(hours)  LBA_of_first_error
# 1  Short offline       Completed without error       00%     13380       =
  -

SMART Selective self-test log data structure revision number 1
SPAN  MIN_LBA  MAX_LBA  CURRENT_TEST_STATUS
   1        0        0  Not_testing
   2        0        0  Not_testing
   3        0        0  Not_testing
   4        0        0  Not_testing
   5        0        0  Not_testing
Selective self-test flags (0x0):
 After scanning selected spans, do NOT read-scan remainder of disk.
If Selective self-test is pending on power-up, resume after 0 minute delay.

The above only provides legacy SMART information - try 'smartctl -x' for mo=
re
