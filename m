From: "Fajun Chen" <fajunchen@gmail.com>
Subject: Re: Libata EH False Alarm (2.6.18-rc2)?
Date: Thu, 24 Aug 2006 15:28:07 -0600
Message-ID: <8202f4270608241428o3cce6fa3nb280ed05e8935e85@mail.gmail.com>
References: <8202f4270608241242i7a4d2d0anc3f607dad7df0129@mail.gmail.com>
	 <44EE0561.1030007@gmail.com>
	 <8202f4270608241305n2e0d3e80q2bd377ae85d841bb@mail.gmail.com>
	 <44EE0A42.4070104@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.179]:64785 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1422664AbWHXV2I (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 24 Aug 2006 17:28:08 -0400
Received: by py-out-1112.google.com with SMTP id n25so900960pyg
        for <linux-ide@vger.kernel.org>; Thu, 24 Aug 2006 14:28:07 -0700 (PDT)
In-Reply-To: <44EE0A42.4070104@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com

On 8/24/06, Tejun Heo <htejun@gmail.com> wrote:
> Fajun Chen wrote:
> > Sil3124. That's the only chipset we use.
>
> >> > [30540.003174] ata1: exception Emask 0x10 SAct 0x0 SErr 0x80000 action
> >> > 0x2 frozen
> >> > [30540.003259] ata1: (irq_stat 0x01100010, PHY RDY changed)
>
> Yeap, this message from sata_sil24.  You're not getting any phy status
> changes bits in SError although the device is reporting phy rdy changed
> event.  However, your 3124 is reporting 8b/10b decoding error threshold
> exceeded error interrupt.  That could be related to the phyrdy status
> changed event.  This happens only under heavy IO, right?  How often does
> it occur in units of times per megabytes transferred?
>
> 8b/10b error is a recoverable FIS reception error.  The interrupt bit
> (bit 24 of irq_stat) is only turned on if threshold count is exceeded,
> which is initialized to 0x8000 at the moment.  This indicates that there
> are quite some number of transmission failures.
>

Hi Tejun,

Yes, these happened under heavy IO.  Based on printk timing, it seems
when the problem happened, it was pretty frequent. Please see the snap
shot of timed printk log below. However,  when the system calms down,
nothing printed for many hours. I don't know the direct cause yet.

Thanks,
Fajun

[28143.903371] ata1: EH complete
[28216.484097] ata1: exception Emask 0x10 SAct 0x0 SErr 0x80000 action
0x2 frozen
[28216.484192] ata1: (irq_stat 0x01100010, PHY RDY changed)
[28217.030009] ata1: waiting for device to spin up (8 secs)
[28225.201609] ata1: soft resetting port
[28225.302587] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[28225.305382] ata1.00: configured for UDMA/100
[28225.305430] ata1: EH complete
[28293.634777] ata1: exception Emask 0x10 SAct 0x0 SErr 0x80000 action
0x2 frozen
[28293.634864] ata1: (irq_stat 0x01100010, PHY RDY changed)
[28294.180322] ata1: waiting for device to spin up (8 secs)
[28302.352922] ata1: soft resetting port
[28302.464898] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[28302.467587] ata1.00: configured for UDMA/100
[28302.467632] ata1: EH complete
[29311.442808] ata1: exception Emask 0x10 SAct 0x0 SErr 0x80000 action
0x2 frozen
[29311.442898] ata1: (irq_stat 0x01100010, PHY RDY changed)
[29311.988038] ata1: waiting for device to spin up (8 secs)
[29320.160639] ata1: soft resetting port
[29320.272614] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[29320.275362] ata1.00: configured for UDMA/100
[29320.275408] ata1: EH complete
[29324.778511] ata1: exception Emask 0x10 SAct 0x0 SErr 0x80000 action
0x2 frozen
[29324.778595] ata1: (irq_stat 0x01100010, PHY RDY changed)
[29325.324117] ata1: waiting for device to spin up (8 secs)
[29333.496716] ata1: soft resetting port
[29333.608692] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[29333.611426] ata1.00: configured for UDMA/100
[29333.611472] ata1: EH complete
[29401.940767] ata1: exception Emask 0x10 SAct 0x0 SErr 0x80000 action
0x2 frozen
[29401.940850] ata1: (irq_stat 0x01100010, PHY RDY changed)
[29402.486428] ata1: waiting for device to spin up (8 secs)
[29410.659027] ata1: soft resetting port
[29410.760006] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[29410.762878] ata1.00: configured for UDMA/100
[29410.762926] ata1: EH complete
[29436.860583] ata1: exception Emask 0x10 SAct 0x0 SErr 0x80000 action
0x2 frozen
[29436.860666] ata1: (irq_stat 0x01100010, PHY RDY changed)
[29437.406160] ata1: waiting for device to spin up (8 secs)
[29445.578759] ata1: soft resetting port
[29445.690740] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[29445.693501] ata1.00: configured for UDMA/100
[29445.693548] ata1: EH complete
[29471.655324] ata1: exception Emask 0x10 SAct 0x0 SErr 0x80000 action
0x2 frozen
[29471.655406] ata1: (irq_stat 0x01100010, PHY RDY changed)
[29472.200932] ata1: waiting for device to spin up (8 secs)
[29480.373529] ata1: soft resetting port
[29480.474507] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[29480.477348] ata1.00: configured for UDMA/100
[29480.477395] ata1: EH complete
[29875.996417] ata1: exception Emask 0x10 SAct 0x0 SErr 0x80000 action
0x2 frozen
[29875.996501] ata1: (irq_stat 0x01100010, PHY RDY changed)
[29876.542033] ata1: waiting for device to spin up (8 secs)
[29884.714634] ata1: soft resetting port
[29884.815612] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[29884.818411] ata1.00: configured for UDMA/100
[29884.818458] ata1: EH complete
[29927.771105] ata1: exception Emask 0x10 SAct 0x0 SErr 0x80000 action
0x2 frozen
[29927.771187] ata1: (irq_stat 0x01100010, PHY RDY changed)
[29928.316809] ata1: waiting for device to spin up (8 secs)
[29936.489409] ata1: soft resetting port
[29936.590387] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[29936.593166] ata1.00: configured for UDMA/100
[29936.593215] ata1: EH complete
[29962.657966] ata1: exception Emask 0x10 SAct 0x0 SErr 0x80000 action
0x2 frozen
[29962.658051] ata1: (irq_stat 0x01100010, PHY RDY changed)
[29963.203550] ata1: waiting for device to spin up (8 secs)
[29971.376151] ata1: soft resetting port
[29971.488126] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[29971.491138] ata1.00: configured for UDMA/100
[29971.491188] ata1: EH complete
[29997.454772] ata1: exception Emask 0x10 SAct 0x0 SErr 0x80000 action
0x2 frozen
[29997.454860] ata1: (irq_stat 0x01100010, PHY RDY changed)
[29998.000319] ata1: waiting for device to spin up (8 secs)
[30006.172918] ata1: soft resetting port
[30006.284894] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[30006.287658] ata1.00: configured for UDMA/100
[30006.287705] ata1: EH complete
[30032.953233] ata1: exception Emask 0x10 SAct 0x0 SErr 0x80000 action
0x2 frozen
[30032.953318] ata1: (irq_stat 0x01100010, PHY RDY changed)
[30033.498880] ata1: waiting for device to spin up (8 secs)
[30041.671478] ata1: soft resetting port
[30041.783459] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[30041.786204] ata1.00: configured for UDMA/100
[30041.786253] ata1: EH complete
[30068.484787] ata1: exception Emask 0x10 SAct 0x0 SErr 0x80000 action
0x2 frozen
[30068.484869] ata1: (irq_stat 0x01100010, PHY RDY changed)
[30069.030432] ata1: waiting for device to spin up (8 secs)
[30077.203034] ata1: soft resetting port
[30077.304012] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[30077.306761] ata1.00: configured for UDMA/100
[30077.306810] ata1: EH complete
[30309.781820] ata1: exception Emask 0x10 SAct 0x0 SErr 0x80000 action
0x2 frozen
[30309.781906] ata1: (irq_stat 0x01100010, PHY RDY changed)
[30310.327479] ata1: waiting for device to spin up (8 secs)
[30318.500082] ata1: soft resetting port
[30318.601059] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[30318.603940] ata1.00: configured for UDMA/100
[30318.603988] ata1: EH complete
[30540.003174] ata1: exception Emask 0x10 SAct 0x0 SErr 0x80000 action
0x2 frozen
[30540.003259] ata1: (irq_stat 0x01100010, PHY RDY changed)
[30540.548784] ata1: waiting for device to spin up (8 secs)
[30548.721383] ata1: soft resetting port
[30548.822362] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[30548.825201] ata1.00: configured for UDMA/100
[30548.825248] ata1: EH complete
[30575.399747] ata1: exception Emask 0x10 SAct 0x0 SErr 0x80000 action
0x2 frozen
[30575.399833] ata1: (irq_stat 0x01100010, PHY RDY changed)
[30575.945375] ata1: waiting for device to spin up (8 secs)
[30584.117974] ata1: soft resetting port
[30584.229951] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[30584.232735] ata1.00: configured for UDMA/100
[30584.232782] ata1: EH complete
[30610.554411] ata1: exception Emask 0x10 SAct 0x0 SErr 0x80000 action
0x2 frozen
[30610.554496] ata1: (irq_stat 0x01100010, PHY RDY changed)
[30611.100038] ata1: waiting for device to spin up (8 secs)
[30619.272638] ata1: soft resetting port
[30619.373617] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[30619.376389] ata1.00: configured for UDMA/100
[30619.376439] ata1: EH complete
[30626.649269] ata1: exception Emask 0x10 SAct 0x0 SErr 0x80000 action
0x2 frozen
[30626.649353] ata1: (irq_stat 0x01100010, PHY RDY changed)
[30627.194306] ata1: waiting for device to spin up (8 secs)
[30635.366907] ata1: soft resetting port
[30635.467886] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[30635.470648] ata1.00: configured for UDMA/100
[30635.470694] ata1: EH complete
[31100.947327] ata1: exception Emask 0x10 SAct 0x0 SErr 0x80000 action
0x2 frozen
[31100.947409] ata1: (irq_stat 0x01100010, PHY RDY changed)
[31101.492839] ata1: waiting for device to spin up (8 secs)
[31109.665441] ata1: soft resetting port
[31109.766420] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[31109.769259] ata1.00: configured for UDMA/100
[31109.769305] ata1: EH complete
[31344.375653] ata1: exception Emask 0x10 SAct 0x0 SErr 0x80000 action
0x2 frozen
[31344.375740] ata1: (irq_stat 0x01100010, PHY RDY changed)
[31344.921260] ata1: waiting for device to spin up (8 secs)
[31353.093860] ata1: soft resetting port
[31353.194839] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[31353.197665] ata1.00: configured for UDMA/100
[31353.197712] ata1: EH complete
[31610.265816] ata1: exception Emask 0x10 SAct 0x0 SErr 0x80000 action
0x2 frozen
[31610.265901] ata1: (irq_stat 0x01100010, PHY RDY changed)
[31610.811076] ata1: waiting for device to spin up (8 secs)
[31618.983675] ata1: soft resetting port
[31619.095652] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[31619.098363] ata1.00: configured for UDMA/100
[31619.098410] ata1: EH complete
[31623.600365] ata1: exception Emask 0x10 SAct 0x0 SErr 0x80000 action
0x2 frozen
[31623.600450] ata1: (irq_stat 0x01100010, PHY RDY changed)
[31624.146155] ata1: waiting for device to spin up (8 secs)
[31632.318756] ata1: soft resetting port
[31632.419733] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[31632.422564] ata1.00: configured for UDMA/100
[31632.422611] ata1: EH complete
[31700.777772] ata1: exception Emask 0x10 SAct 0x0 SErr 0x80000 action
0x2 frozen
[31700.777860] ata1: (irq_stat 0x01100010, PHY RDY changed)
[31701.323461] ata1: waiting for device to spin up (8 secs)
[31709.496064] ata1: soft resetting port
[31709.597041] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[31709.599857] ata1.00: configured for UDMA/100
[31709.599906] ata1: EH complete
[31944.217310] ata1: exception Emask 0x10 SAct 0x0 SErr 0x80000 action
0x2 frozen
[31944.217391] ata1: (irq_stat 0x01100010, PHY RDY changed)
[31944.762878] ata1: waiting for device to spin up (8 secs)
[31952.935477] ata1: soft resetting port
[31953.047454] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[31953.050157] ata1.00: configured for UDMA/100
[31953.050203] ata1: EH complete
[32034.091806] ata1: exception Emask 0x10 SAct 0x0 SErr 0x80000 action
0x2 frozen
[32034.091889] ata1: (irq_stat 0x01100010, PHY RDY changed)
[32034.637450] ata1: waiting for device to spin up (8 secs)
[32042.810051] ata1: soft resetting port
[32042.922027] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[32042.924751] ata1.00: configured for UDMA/100
[32042.924798] ata1: EH complete
[32115.516844] ata1: exception Emask 0x10 SAct 0x0 SErr 0x80000 action
0x2 frozen
[32115.516929] ata1: (irq_stat 0x01100010, PHY RDY changed)
[32116.062510] ata1: waiting for device to spin up (8 secs)
[32124.235108] ata1: soft resetting port
[32124.347084] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[32124.349879] ata1.00: configured for UDMA/100
[32124.349927] ata1: EH complete
[32192.660105] ata1: exception Emask 0x10 SAct 0x0 SErr 0x80000 action
0x2 frozen
[32192.660190] ata1: (irq_stat 0x01100010, PHY RDY changed)
[32193.205824] ata1: waiting for device to spin up (8 secs)
[32201.378423] ata1: soft resetting port
[32201.490400] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[32201.493189] ata1.00: configured for UDMA/100
[32201.493235] ata1: EH complete
[33213.144571] ata1: exception Emask 0x10 SAct 0x0 SErr 0x80000 action
0x2 frozen
[33213.144660] ata1: (irq_stat 0x01100010, PHY RDY changed)
[33213.689755] ata1: waiting for device to spin up (8 secs)
[33221.862352] ata1: soft resetting port
[33221.963332] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[33221.966204] ata1.00: configured for UDMA/100
[33221.966251] ata1: EH complete
[33226.479118] ata1: exception Emask 0x10 SAct 0x0 SErr 0x80000 action
0x2 frozen
[33226.479203] ata1: (irq_stat 0x01100010, PHY RDY changed)
[33227.024832] ata1: waiting for device to spin up (8 secs)
[33235.197430] ata1: soft resetting port
[33235.298411] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[33235.301294] ata1.00: configured for UDMA/100
[33235.301341] ata1: EH complete
[33303.608605] ata1: exception Emask 0x10 SAct 0x0 SErr 0x80000 action
0x2 frozen
[33303.608693] ata1: (irq_stat 0x01100010, PHY RDY changed)
[33304.154152] ata1: waiting for device to spin up (8 secs)
[33312.326753] ata1: soft resetting port
[33312.427731] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[33312.430512] ata1.00: configured for UDMA/100
[33312.430557] ata1: EH complete
[33338.528219] ata1: exception Emask 0x10 SAct 0x0 SErr 0x80000 action
0x2 frozen
[33338.528301] ata1: (irq_stat 0x01100010, PHY RDY changed)
[33339.073885] ata1: waiting for device to spin up (8 secs)
[33347.246484] ata1: soft resetting port
[33347.347463] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[33347.350215] ata1.00: configured for UDMA/100
[33347.350264] ata1: EH complete
[33373.332079] ata1: exception Emask 0x10 SAct 0x0 SErr 0x80000 action
0x2 frozen
[33373.332167] ata1: (irq_stat 0x01100010, PHY RDY changed)
[33373.877651] ata1: waiting for device to spin up (8 secs)
[33382.050251] ata1: soft resetting port
[33382.162226] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[33382.165255] ata1.00: configured for UDMA/100
[33382.165301] ata1: EH complete
[33777.968017] ata1: exception Emask 0x10 SAct 0x0 SErr 0x80000 action
0x2 frozen
[33777.968102] ata1: (irq_stat 0x01100010, PHY RDY changed)
[33778.513668] ata1: waiting for device to spin up (8 secs)
[33786.686268] ata1: soft resetting port
[33786.798245] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[33786.801038] ata1.00: configured for UDMA/100
[33786.801086] ata1: EH complete
[33829.722919] ata1: exception Emask 0x10 SAct 0x0 SErr 0x80000 action
0x2 frozen
[33829.723000] ata1: (irq_stat 0x01100010, PHY RDY changed)
[33830.268451] ata1: waiting for device to spin up (8 secs)
[33838.441052] ata1: soft resetting port
[33838.542029] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[33838.544844] ata1.00: configured for UDMA/100
[33838.544893] ata1: EH complete
[33864.622635] ata1: exception Emask 0x10 SAct 0x0 SErr 0x80000 action
0x2 frozen
[33864.622723] ata1: (irq_stat 0x01100010, PHY RDY changed)
[33865.168188] ata1: waiting for device to spin up (8 secs)
[33873.340790] ata1: soft resetting port
[33873.441767] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[33873.444581] ata1.00: configured for UDMA/100
[33873.444628] ata1: EH complete
[33899.404288] ata1: exception Emask 0x10 SAct 0x0 SErr 0x80000 action
0x2 frozen
[33899.404375] ata1: (irq_stat 0x01100010, PHY RDY changed)
[33899.949960] ata1: waiting for device to spin up (8 secs)
[33908.122560] ata1: soft resetting port
[33908.223540] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[33908.226384] ata1.00: configured for UDMA/100
[33908.226431] ata1: EH complete
[33934.886888] ata1: exception Emask 0x10 SAct 0x0 SErr 0x80000 action
0x2 frozen
[33934.886976] ata1: (irq_stat 0x01100010, PHY RDY changed)
[33935.432527] ata1: waiting for device to spin up (8 secs)
[33943.605128] ata1: soft resetting port
[33943.717103] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[33943.719871] ata1.00: configured for UDMA/100
[33943.719921] ata1: EH complete
[33970.392444] ata1: exception Emask 0x10 SAct 0x0 SErr 0x80000 action
0x2 frozen
[33970.392525] ata1: (irq_stat 0x01100010, PHY RDY changed)
[33970.938087] ata1: waiting for device to spin up (8 secs)
[33979.110685] ata1: soft resetting port
[33979.222663] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[33979.225410] ata1.00: configured for UDMA/100
[33979.225460] ata1: EH complete
[34024.082151] ata1: exception Emask 0x10 SAct 0x0 SErr 0x80000 action
0x2 frozen
[34024.082239] ata1: (irq_stat 0x01100010, PHY RDY changed)
[34024.627299] ata1: waiting for device to spin up (8 secs)
[34032.799898] ata1: soft resetting port
[34032.911876] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[34032.914608] ata1.00: configured for UDMA/100
