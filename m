From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: ExpressCard compact flash card very slow
Date: Wed, 23 Feb 2011 16:45:51 -0600
Message-ID: <AANLkTi=OcxekLKqDYia6_9MxYFygjgCa2a56MJkHte8n@mail.gmail.com>
References: <4D645C59.8090406@gmail.com>
	<4D649FA2.5010204@gmail.com>
	<4D64C446.4050803@gmail.com>
	<AANLkTime_Rsych048Apawp9K0A+5zYHZfraVU0ZFPpum@mail.gmail.com>
	<4D652DD2.5080900@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:57903 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751186Ab1BWWpw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 23 Feb 2011 17:45:52 -0500
Received: by iyb26 with SMTP id 26so3086123iyb.19
        for <linux-ide@vger.kernel.org>; Wed, 23 Feb 2011 14:45:52 -0800 (PST)
In-Reply-To: <4D652DD2.5080900@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Damon Lynch <damonlynch@gmail.com>
Cc: linux-ide@vger.kernel.org

On Wed, Feb 23, 2011 at 9:54 AM, Damon Lynch <damonlynch@gmail.com> wro=
te:
> On 02/23/2011 08:41 AM, Robert Hancock wrote:
>>
>> On Wed, Feb 23, 2011 at 2:24 AM, Damon Lynch<damonlynch@gmail.com> =A0=
wrote:
>>>
>>> What next? Can the CF reader be whitelisted by libata?
>>
>> The CF reader portion itself likely isn't identifiable (it's probabl=
y
>> mostly just passive circuitry). The PATA adapter portion might be
>> identifiable, unless it just has a totally generic JMicron device ID=
=2E.
>> What does lspci -vvnn show for it?
>>
>
> 05:00.0 IDE interface [0101]: JMicron Technology Corp. JMB368 IDE con=
troller
> [197b:2368] (prog-if 85 [Master SecO PriO])
> =A0 =A0Subsystem: JMicron Technology Corp. JMB368 IDE controller [197=
b:2368]

Yeah, it looks like it just has a generic subsystem/subvendor ID so we
can't tell this thing apart from any other JMicron JMB368 PATA
controller. Not sure there is anything we can do here to detect this
case automatically.

Though, I suppose one other thing we could do is just ignore cable
detection results for CompactFlash devices - it seems like many CF
adapters get this wrong. If the user really connected a fast CF card
with a 40-wire cable, the error handling would probably do the right
thing and lower the transfer mode if errors occurred.

> =A0 =A0Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- Pa=
rErr-
> Stepping- SERR+ FastB2B- DisINTx-
> =A0 =A0Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbor=
t- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
> =A0 =A0Latency: 0, Cache Line Size: 64 bytes
> =A0 =A0Interrupt: pin A routed to IRQ 19
> =A0 =A0Region 0: I/O ports at 4020 [size=3D8]
> =A0 =A0Region 1: I/O ports at 4014 [size=3D4]
> =A0 =A0Region 2: I/O ports at 4018 [size=3D8]
> =A0 =A0Region 3: I/O ports at 4010 [size=3D4]
> =A0 =A0Region 4: I/O ports at 4000 [size=3D16]
> =A0 =A0[virtual] Expansion ROM at f2900000 [disabled] [size=3D64K]
> =A0 =A0Capabilities: [68] Power Management version 2
> =A0 =A0 =A0 =A0Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
> =A0 =A0 =A0 =A0Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 =
PME-
> =A0 =A0Capabilities: [50] Express (v1) Legacy Endpoint, MSI 01
> =A0 =A0 =A0 =A0DevCap: =A0 =A0MaxPayload 128 bytes, PhantFunc 0, Late=
ncy L0s <64ns, L1
> <1us
> =A0 =A0 =A0 =A0 =A0 =A0ExtTag- AttnBtn- AttnInd- PwrInd- RBE- FLReset=
-
> =A0 =A0 =A0 =A0DevCtl: =A0 =A0Report errors: Correctable- Non-Fatal- =
=46atal- Unsupported-
> =A0 =A0 =A0 =A0 =A0 =A0RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> =A0 =A0 =A0 =A0 =A0 =A0MaxPayload 128 bytes, MaxReadReq 512 bytes
> =A0 =A0 =A0 =A0DevSta: =A0 =A0CorrErr- UncorrErr- FatalErr- UnsuppReq=
+ AuxPwr-
> TransPend-
> =A0 =A0 =A0 =A0LnkCap: =A0 =A0Port #1, Speed 2.5GT/s, Width x1, ASPM =
L0s, Latency L0
> <1us, L1 <16us
> =A0 =A0 =A0 =A0 =A0 =A0ClockPM- Surprise- LLActRep- BwNot-
> =A0 =A0 =A0 =A0LnkCtl: =A0 =A0ASPM Disabled; RCB 64 bytes Disabled- R=
etrain- CommClk+
> =A0 =A0 =A0 =A0 =A0 =A0ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> =A0 =A0 =A0 =A0LnkSta: =A0 =A0Speed 2.5GT/s, Width x1, TrErr- Train- =
SlotClk+ DLActive-
> BWMgmt- ABWMgmt-
> =A0 =A0Capabilities: [70] MSI: Enable- Count=3D1/1 Maskable- 64bit-
> =A0 =A0 =A0 =A0Address: 00000000 =A0Data: 0000
> =A0 =A0Kernel driver in use: pata_jmicron
> =A0 =A0Kernel modules: pata_jmicron
>
>
