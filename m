From: Artem Bokhan <aptem@ngs.ru>
Subject: Re: sata_mv, io stucks
Date: Thu, 23 Oct 2008 15:53:48 +0700
Message-ID: <49003B9C.1010303@ngs.ru>
References: <48F88449.1000704@ngs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtpout1.ngs.ru ([195.93.186.195]:34422 "EHLO smtpout1.ngs.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751670AbYJWIvs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 23 Oct 2008 04:51:48 -0400
In-Reply-To: <48F88449.1000704@ngs.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Artem Bokhan <aptem@ngs.ru>
Cc: linux-ide@vger.kernel.org

Any thought?

Artem Bokhan =D0=C9=DB=C5=D4:
> I try to simulate random reads  with "sysbench --test=3Dfileio=20
> --num-threads=3D16 --max-requests=3D9999999 --max-time=3D60 --init-rn=
g=3Don=20
> --file-num=3D16 --file-fsync-freq=3D0 --file-test-mode=3Drndrd=20
> --file-total-size=3D30G run"
>
> Two marvell controllers, 16 disks, software raid10, IO stucks on=20
> different disks, kernel 2.6.26.5.
> With default ubuntu's 8.04 2.6.24 kernel the problem can not be repea=
ted
>
>
> [  289.851609] ata11.00: exception Emask 0x0 SAct 0x1 SErr 0x0 action=
=20
> 0x6 frozen
> [  289.851695] ata11.00: cmd 61/08:00:60:1e:bf/00:00:01:00:00/40 tag =
0=20
> ncq 4096 out
> [  289.851697]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask=
=20
> 0x4 (timeout)
> [  289.851774] ata11.00: status: { DRDY }
> [  289.851834] ata11: hard resetting link
> [  290.649259] ata11: SATA link up 3.0 Gbps (SStatus 123 SControl 300=
)
> [  290.749239] ata11.00: max_sectors limited to 256 for NCQ
> [  290.809189] ata11.00: max_sectors limited to 256 for NCQ
> [  290.809194] ata11.00: configured for UDMA/133
> [  290.809200] ata11: EH complete
> [  290.809242] sd 10:0:0:0: [sdk] 1953525168 512-byte hardware sector=
s=20
> (1000205 MB)
> [  290.809258] sd 10:0:0:0: [sdk] Write Protect is off
> [  290.809263] sd 10:0:0:0: [sdk] Mode Sense: 00 3a 00 00
> [  290.809286] sd 10:0:0:0: [sdk] Write cache: enabled, read cache:=20
> enabled, doesn't support DPO or FUA
>
>
> lspci:
>
> 05:01.0 SCSI storage controller: Marvell Technology Group Ltd.=20
> MV88SX6081 8-port SATA II PCI-X Controller (rev 09)
>        Subsystem: Marvell Technology Group Ltd. Unknown device 11ab
>        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-=20
> ParErr+ Stepping- SERR+ FastB2B+
>        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium=20
> >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>        Latency: 32, Cache Line Size: 32 bytes
>        Interrupt: pin A routed to IRQ 24
>        Region 0: Memory at d8200000 (64-bit, non-prefetchable) [size=3D=
1M]
>        Region 2: I/O ports at 3000 [size=3D256]
>        Capabilities: [40] Power Management version 2
>                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA=20
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
>        Capabilities: [50] Message Signalled Interrupts: Mask- 64bit+=20
> Queue=3D0/0 Enable-
>                Address: 0000000000000000  Data: 0000
>        Capabilities: [60] PCI-X non-bridge device
>                Command: DPERE- ERO- RBC=3D512 OST=3D4
>                Status: Dev=3D05:01.0 64bit+ 133MHz+ SCD- USC- DC=3Dsi=
mple=20
> DMMRBC=3D512 DMOST=3D4 DMCRS=3D8 RSCEM- 266MHz- 533MHz-
>
> 05:02.0 SCSI storage controller: Marvell Technology Group Ltd.=20
> MV88SX6081 8-port SATA II PCI-X Controller (rev 09)
>        Subsystem: Marvell Technology Group Ltd. Unknown device 11ab
>        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-=20
> ParErr+ Stepping- SERR+ FastB2B+
>        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium=20
> >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>        Latency: 32, Cache Line Size: 32 bytes
>        Interrupt: pin A routed to IRQ 28
>        Region 0: Memory at d8300000 (64-bit, non-prefetchable) [size=3D=
1M]
>        Region 2: I/O ports at 3400 [size=3D256]
>        Region 3: [virtual] Memory at d8800000 (32-bit,=20
> non-prefetchable) [size=3D4M]
>        [virtual] Expansion ROM at d9000000 [disabled] [size=3D4M]
>        Capabilities: [40] Power Management version 2
>                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA=20
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
>        Capabilities: [50] Message Signalled Interrupts: Mask- 64bit+=20
> Queue=3D0/0 Enable-
>                Address: 0000000000000000  Data: 0000
>        Capabilities: [60] PCI-X non-bridge device
>                Command: DPERE- ERO- RBC=3D512 OST=3D4
>                Status: Dev=3D05:02.0 64bit+ 133MHz+ SCD- USC- DC=3Dsi=
mple=20
> DMMRBC=3D512 DMOST=3D4 DMCRS=3D8 RSCEM- 266MHz- 533MHz-
>
> --=20
> To unsubscribe from this list: send the line "unsubscribe linux-ide" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

