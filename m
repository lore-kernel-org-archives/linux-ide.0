From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: Marvell support in ahci
Date: Mon, 11 Apr 2011 17:52:11 -0600
Message-ID: <4DA3942B.3040105@gmail.com>
References: <BANLkTinXaLRBHhrYgetzgv=u8kBg=SQRpQ@mail.gmail.com> <BANLkTimQ_0D540RoaAF7j-UgnJuyK87VGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:37646 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755953Ab1DKXwO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 11 Apr 2011 19:52:14 -0400
Received: by iwn34 with SMTP id 34so6117391iwn.19
        for <linux-ide@vger.kernel.org>; Mon, 11 Apr 2011 16:52:14 -0700 (PDT)
In-Reply-To: <BANLkTimQ_0D540RoaAF7j-UgnJuyK87VGw@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: arnaud atoch <arnaud.atoch@gmail.com>
Cc: linux-ide@vger.kernel.org

On 04/02/2011 02:09 PM, arnaud atoch wrote:
> 2011/4/2 arnaud atoch<arnaud.atoch@gmail.com>
>>
>> Bonjour,
>>
>> Thank you for your time devoted to maintaining the AHCI sata part of the Linux kernel.
>> I'd like to to ask you to add the Marvell sata device found on various ASUS motherboard like mine : P5WDG2WS Pro.
>>
>> This sata device is listed as :
>> 02:00.0 0106: 11ab:6141 (rev 01)
>> 02:00.0 SATA controller: Marvell Technology Group Ltd. 88SE614x SATA II PCI-E controller (rev 01) (prog-if 81)
>>      Subsystem: ASUSTeK Computer Inc. Device 81d6
>>      Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
>>      Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast>TAbort-<TAbort-<MAbort->SERR-<PERR- INTx-
>>      Latency: 0 (2000ns min), Cache Line Size: 16 bytes
>>      Interrupt: pin A routed to IRQ 10
>>      Region 0: I/O ports at bc00 [size=8]
>>      Region 1: I/O ports at b880 [size=4]
>>      Region 2: I/O ports at b800 [size=64]
>>      Region 4: I/O ports at b480 [size=32]
>>      Region 5: Memory at ebdffc00 (32-bit, non-prefetchable) [size=1K]
>>      Expansion ROM at ebd80000 [disabled] [size=256K]
>>      Capabilities: [48] Power Management version 2
>>          Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0+,D1+,D2-,D3hot+,D3cold-)
>>          Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME+
>>      Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit-
>>          Address: 00000000  Data: 0000
>>      Capabilities: [e0] Express (v1) Legacy Endpoint, MSI 00
>>          DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s unlimited, L1 unlimited
>>              ExtTag- AttnBtn- AttnInd- PwrInd- RBE- FLReset-
>>          DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
>>              RlxdOrd- ExtTag- PhantFunc- AuxPwr+ NoSnoop-
>>              MaxPayload 128 bytes, MaxReadReq 128 bytes
>>          DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq+ AuxPwr- TransPend-
>>          LnkCap:    Port #0, Speed 2.5GT/s, Width x1, ASPM L0s, Latency L0<256ns, L1 unlimited
>>              ClockPM- Surprise- LLActRep- BwNot-
>>          LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
>>              ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>>          LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
>>      Capabilities: [100 v1] Advanced Error Reporting
>>          UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>>          UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>>          UESvrt:    DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP+ ECRC- UnsupReq- ACSViol-
>>          CESta:    RxErr+ BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
>>          CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
>>          AERCap:    First Error Pointer: 1f, GenCap- CGenEn- ChkCap- ChkEn-
>>
>>
>> There is a modified kernel source (2.6.12.3) n the ASUS site but according to Alan Cox changes are limited to the addition of the device PCI id.
>> Could you please add this device to the list of managed devices in ahci.c ?

Have you tested a recent kernel with this device? It looks like it 
should have the proper class code so the AHCI driver can load without 
that specific device ID. Adding specific device IDs should only be 
needed for devices that don't do this (like those that identify as RAID 
or legacy IDE classes).
