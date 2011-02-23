From: Damon Lynch <damonlynch@gmail.com>
Subject: Re: ExpressCard compact flash card very slow
Date: Wed, 23 Feb 2011 09:54:58 -0600
Message-ID: <4D652DD2.5080900@gmail.com>
References: <4D645C59.8090406@gmail.com>	<4D649FA2.5010204@gmail.com>	<4D64C446.4050803@gmail.com> <AANLkTime_Rsych048Apawp9K0A+5zYHZfraVU0ZFPpum@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:50988 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754428Ab1BWPzC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 23 Feb 2011 10:55:02 -0500
Received: by vws12 with SMTP id 12so3178906vws.19
        for <linux-ide@vger.kernel.org>; Wed, 23 Feb 2011 07:55:02 -0800 (PST)
In-Reply-To: <AANLkTime_Rsych048Apawp9K0A+5zYHZfraVU0ZFPpum@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: linux-ide@vger.kernel.org

On 02/23/2011 08:41 AM, Robert Hancock wrote:
> On Wed, Feb 23, 2011 at 2:24 AM, Damon Lynch<damonlynch@gmail.com>  wrote:
>> What next? Can the CF reader be whitelisted by libata?
> The CF reader portion itself likely isn't identifiable (it's probably
> mostly just passive circuitry). The PATA adapter portion might be
> identifiable, unless it just has a totally generic JMicron device ID..
> What does lspci -vvnn show for it?
>

05:00.0 IDE interface [0101]: JMicron Technology Corp. JMB368 IDE 
controller [197b:2368] (prog-if 85 [Master SecO PriO])
     Subsystem: JMicron Technology Corp. JMB368 IDE controller [197b:2368]
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Interrupt: pin A routed to IRQ 19
     Region 0: I/O ports at 4020 [size=8]
     Region 1: I/O ports at 4014 [size=4]
     Region 2: I/O ports at 4018 [size=8]
     Region 3: I/O ports at 4010 [size=4]
     Region 4: I/O ports at 4000 [size=16]
     [virtual] Expansion ROM at f2900000 [disabled] [size=64K]
     Capabilities: [68] Power Management version 2
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [50] Express (v1) Legacy Endpoint, MSI 01
         DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s 
<64ns, L1 <1us
             ExtTag- AttnBtn- AttnInd- PwrInd- RBE- FLReset-
         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- 
Unsupported-
             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
             MaxPayload 128 bytes, MaxReadReq 512 bytes
         DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq+ AuxPwr- 
TransPend-
         LnkCap:    Port #1, Speed 2.5GT/s, Width x1, ASPM L0s, Latency 
L0 <1us, L1 <16us
             ClockPM- Surprise- LLActRep- BwNot-
         LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ 
DLActive- BWMgmt- ABWMgmt-
     Capabilities: [70] MSI: Enable- Count=1/1 Maskable- 64bit-
         Address: 00000000  Data: 0000
     Kernel driver in use: pata_jmicron
     Kernel modules: pata_jmicron

