From: YUP <yupadmin@gmail.com>
Subject: Re: libata: CD and dvd devices not recognized
Date: Mon, 19 Mar 2007 20:35:07 +0100
Message-ID: <45FEE5EB.9020909@gmail.com>
References: <45F873AC.6010204@gmail.com> <200703172107.42107.bzolnier@gmail.com> <45FD0F68.7090207@gmail.com> <200703181610.33714.bzolnier@gmail.com> <45FE7DCC.3000507@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.187]:47255 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752724AbXCSTf0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Mar 2007 15:35:26 -0400
Received: by mu-out-0910.google.com with SMTP id g7so1926061muf
        for <linux-ide@vger.kernel.org>; Mon, 19 Mar 2007 12:35:24 -0700 (PDT)
In-Reply-To: <45FE7DCC.3000507@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, albertl@mail.com, linux-ide@vger.kernel.org

Hi Sergei, Albert and Bartek,

Thanks for the patch. If you dealt with it, could you please apply this 
patch to 2.6.20.3 kernel and send me diff? I'm just afraid that I 
couldn't do it right.

Albert and Bartek,

please find latest dmsg output with Albert's patch. I quoted here only 
output after the first "qc timeout" as Albert requested (see below). 
Hope it will help you.

Regards,

Yarema


[   69.646046] ata4.01: qc timeout (cmd 0xa0)
[   69.646063] ata4.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 
frozen
[   69.646077] ata4.01: cmd a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 
cdb 0x12 data 254 in
[   69.646080]          res 51/51:03:00:12:00/00:00:00:00:00/b0 Emask 
0x5 (timeout)
[   76.635584] ata4: port is slow to respond, please be patient (Status 
0xd8)
[   99.617183] ata4: port failed to respond (30 secs, Status 0xd8)
[   99.617196] ata4: soft resetting port
[   99.784327] ATA: abnormal status 0x7F on port 0xE08815DF
[   99.795702] ATA: abnormal status 0x7F on port 0xE08815DF
[   99.956680] ata4: protocol 2 task_state 1 (dev_stat 0x51)
[   99.956691] ata4: protocol 2 task_state 3 (dev_stat 0x51)
[   99.956724] ata4.01: failed to IDENTIFY (I/O error, err_mask=0x1)
[   99.956728] ata4.01: revalidation failed (errno=-5)
[   99.956735] ata4: failed to recover some devices, retrying in 5 secs
[  104.953222] ata4: soft resetting port
[  105.120375] ATA: abnormal status 0x7F on port 0xE08815DF
[  105.131749] ATA: abnormal status 0x7F on port 0xE08815DF
[  105.292697] ata4: protocol 2 task_state 1 (dev_stat 0x58)
[  105.292960] ata4: protocol 2 task_state 2 (dev_stat 0x50)
[  105.293007] ata4.01: device is on DMA blacklist, disabling DMA
[  105.293139] ata4: protocol 1 task_state 2
[  105.293143] ata4: host_stat 0x4
[  105.293148] ata4: protocol 1 task_state 2 (dev_stat 0x50)
[  105.456453] ata4: protocol 2 task_state 1 (dev_stat 0x58)
[  105.456739] ata4: protocol 2 task_state 2 (dev_stat 0x50)
[  105.456780] ata4.01: configured for PIO4
[  105.456830] ata4: EH complete
[  105.456944] CDB (4:0,1,0) 00 00 00 00 00 00 00 00 00
[  105.457003] ata4: protocol 6 task_state 4 (dev_stat 0x58)
[  105.457551] ata4: protocol 6 task_state 2
[  105.457555] ata4: host_stat 0x4
[  105.457561] ata4: protocol 6 task_state 2 (dev_stat 0x51)
[  105.457563] ata4: protocol 6 task_state 3 (dev_stat 0x51)
[  105.457647] ata4: protocol 5 task_state 4 (dev_stat 0x58)
[  105.458233] ata4: protocol 5 task_state 1
[  105.458237] ata4: host_stat 0x4
[  105.458242] ata4: protocol 5 task_state 1 (dev_stat 0x58)
[  105.458350] ata4: protocol 5 task_state 1
[  105.458353] ata4: host_stat 0x4
[  105.458358] ata4: protocol 5 task_state 1 (dev_stat 0x50)
[  105.458361] ata4: protocol 5 task_state 2 (dev_stat 0x50)
[  105.458410] CDB (4:0,1,0) 43 00 00 00 00 00 00 00 0c
[  105.458465] ata4: protocol 5 task_state 4 (dev_stat 0x58)
[  105.458914] ata4: protocol 5 task_state 1
[  105.458918] ata4: host_stat 0x4
[  105.458923] ata4: protocol 5 task_state 1 (dev_stat 0x51)
[  105.458926] ata4: protocol 5 task_state 2 (dev_stat 0x51)
[  105.458929] ata4: protocol 5 task_state 3 (dev_stat 0x51)
[  105.459005] ata4: protocol 5 task_state 4 (dev_stat 0x58)
[  105.459599] ata4: protocol 5 task_state 1
[  105.459603] ata4: host_stat 0x4
[  105.459608] ata4: protocol 5 task_state 1 (dev_stat 0x58)
[  105.459715] ata4: protocol 5 task_state 1
[  105.459718] ata4: host_stat 0x4
[  105.459724] ata4: protocol 5 task_state 1 (dev_stat 0x50)
[  105.459726] ata4: protocol 5 task_state 2 (dev_stat 0x50)
[  105.459757] CDB (4:0,1,0) 43 00 00 00 00 00 00 00 0c
[  105.459811] ata4: protocol 5 task_state 4 (dev_stat 0x58)
[  105.460279] ata4: protocol 5 task_state 1
[  105.460283] ata4: host_stat 0x4
[  105.460288] ata4: protocol 5 task_state 1 (dev_stat 0x51)
[  105.460291] ata4: protocol 5 task_state 2 (dev_stat 0x51)
[  105.460294] ata4: protocol 5 task_state 3 (dev_stat 0x51)
[  105.460370] ata4: protocol 5 task_state 4 (dev_stat 0x58)
[  105.460965] ata4: protocol 5 task_state 1
[  105.460969] ata4: host_stat 0x4
[  105.460974] ata4: protocol 5 task_state 1 (dev_stat 0x58)
[  105.461081] ata4: protocol 5 task_state 1
[  105.461084] ata4: host_stat 0x4
[  105.461089] ata4: protocol 5 task_state 1 (dev_stat 0x50)
[  105.461092] ata4: protocol 5 task_state 2 (dev_stat 0x50)
[  105.461127] CDB (4:0,1,0) 25 00 00 00 00 00 00 00 00
[  105.461182] ata4: protocol 5 task_state 4 (dev_stat 0x58)
[  105.461645] ata4: protocol 5 task_state 1
[  105.461649] ata4: host_stat 0x4
[  105.461654] ata4: protocol 5 task_state 1 (dev_stat 0x51)
[  105.461657] ata4: protocol 5 task_state 2 (dev_stat 0x51)
[  105.461660] ata4: protocol 5 task_state 3 (dev_stat 0x51)
[  105.461737] ata4: protocol 5 task_state 4 (dev_stat 0x58)
[  105.462330] ata4: protocol 5 task_state 1
[  105.462333] ata4: host_stat 0x4
[  105.462339] ata4: protocol 5 task_state 1 (dev_stat 0x58)
[  105.462446] ata4: protocol 5 task_state 1
[  105.462449] ata4: host_stat 0x4
[  105.462454] ata4: protocol 5 task_state 1 (dev_stat 0x50)
[  105.462457] ata4: protocol 5 task_state 2 (dev_stat 0x50)
[  105.462485] CDB (4:0,1,0) 25 00 00 00 00 00 00 00 00
[  105.462539] ata4: protocol 5 task_state 4 (dev_stat 0x58)
[  105.463010] ata4: protocol 5 task_state 1
[  105.463014] ata4: host_stat 0x4
[  105.463019] ata4: protocol 5 task_state 1 (dev_stat 0x51)
[  105.463022] ata4: protocol 5 task_state 2 (dev_stat 0x51)
[  105.463025] ata4: protocol 5 task_state 3 (dev_stat 0x51)
[  105.463101] ata4: protocol 5 task_state 4 (dev_stat 0x58)
[  105.463695] ata4: protocol 5 task_state 1
[  105.463699] ata4: host_stat 0x4
[  105.463704] ata4: protocol 5 task_state 1 (dev_stat 0x58)
[  105.463812] ata4: protocol 5 task_state 1
[  105.463815] ata4: host_stat 0x4
[  105.463820] ata4: protocol 5 task_state 1 (dev_stat 0x50)
[  105.463823] ata4: protocol 5 task_state 2 (dev_stat 0x50)
[  105.463850] CDB (4:0,1,0) 25 00 00 00 00 00 00 00 00
[  105.463905] ata4: protocol 5 task_state 4 (dev_stat 0x58)
[  105.464376] ata4: protocol 5 task_state 1
[  105.464380] ata4: host_stat 0x4
[  105.464385] ata4: protocol 5 task_state 1 (dev_stat 0x51)
[  105.464388] ata4: protocol 5 task_state 2 (dev_stat 0x51)
[  105.464391] ata4: protocol 5 task_state 3 (dev_stat 0x51)
[  105.464475] ata4: protocol 5 task_state 4 (dev_stat 0x58)
[  105.465104] ata4: protocol 5 task_state 1
[  105.465108] ata4: host_stat 0x4
[  105.465113] ata4: protocol 5 task_state 1 (dev_stat 0x58)
[  105.465219] ata4: protocol 5 task_state 1
[  105.465222] ata4: host_stat 0x4
[  105.465228] ata4: protocol 5 task_state 1 (dev_stat 0x50)
[  105.465231] ata4: protocol 5 task_state 2 (dev_stat 0x50)
[  105.465543] CDB (4:0,1,0) 1e 00 00 00 00 00 00 00 00
[  105.465609] ata4: protocol 6 task_state 4 (dev_stat 0x58)
[  105.466245] ata4: protocol 6 task_state 2
[  105.466250] ata4: host_stat 0x4
[  105.466257] ata4: protocol 6 task_state 2 (dev_stat 0x50)
[  105.471684] CDB (4:0,1,0) 00 00 00 00 00 00 00 00 00
[  105.471762] ata4: protocol 6 task_state 4 (dev_stat 0x58)
[  105.472290] ata4: protocol 6 task_state 2
[  105.472294] ata4: host_stat 0x4
[  105.472300] ata4: protocol 6 task_state 2 (dev_stat 0x51)
[  105.472303] ata4: protocol 6 task_state 3 (dev_stat 0x51)
[  105.472398] ata4: protocol 5 task_state 4 (dev_stat 0x58)
[  105.472971] ata4: protocol 5 task_state 1
[  105.472974] ata4: host_stat 0x4
[  105.472980] ata4: protocol 5 task_state 1 (dev_stat 0x58)
[  105.473087] ata4: protocol 5 task_state 1
[  105.473090] ata4: host_stat 0x4
[  105.473095] ata4: protocol 5 task_state 1 (dev_stat 0x50)
[  105.473098] ata4: protocol 5 task_state 2 (dev_stat 0x50)
[  105.473160] CDB (4:0,1,0) 43 00 00 00 00 00 00 00 0c
[  105.473215] ata4: protocol 5 task_state 4 (dev_stat 0x58)
[  105.473651] ata4: protocol 5 task_state 1
[  105.473655] ata4: host_stat 0x4
[  105.473660] ata4: protocol 5 task_state 1 (dev_stat 0x51)
[  105.473663] ata4: protocol 5 task_state 2 (dev_stat 0x51)
[  105.473666] ata4: protocol 5 task_state 3 (dev_stat 0x51)
[  105.473743] ata4: protocol 5 task_state 4 (dev_stat 0x58)
[  105.474371] ata4: protocol 5 task_state 1
[  105.474374] ata4: host_stat 0x4
[  105.474380] ata4: protocol 5 task_state 1 (dev_stat 0x58)
[  105.474488] ata4: protocol 5 task_state 1
[  105.474491] ata4: host_stat 0x4
[  105.474496] ata4: protocol 5 task_state 1 (dev_stat 0x50)
[  105.474499] ata4: protocol 5 task_state 2 (dev_stat 0x50)
[  105.474530] CDB (4:0,1,0) 43 00 00 00 00 00 00 00 0c
[  105.474585] ata4: protocol 5 task_state 4 (dev_stat 0x58)
[  105.475052] ata4: protocol 5 task_state 1
[  105.475056] ata4: host_stat 0x4
[  105.475061] ata4: protocol 5 task_state 1 (dev_stat 0x51)
[  105.475064] ata4: protocol 5 task_state 2 (dev_stat 0x51)
[  105.475067] ata4: protocol 5 task_state 3 (dev_stat 0x51)
[  105.475143] ata4: protocol 5 task_state 4 (dev_stat 0x58)
[  105.475737] ata4: protocol 5 task_state 1
[  105.475741] ata4: host_stat 0x4
[  105.475746] ata4: protocol 5 task_state 1 (dev_stat 0x58)
[  105.475853] ata4: protocol 5 task_state 1
[  105.475856] ata4: host_stat 0x4
[  105.475861] ata4: protocol 5 task_state 1 (dev_stat 0x50)
[  105.475864] ata4: protocol 5 task_state 2 (dev_stat 0x50)
[  105.475893] CDB (4:0,1,0) 25 00 00 00 00 00 00 00 00
[  105.475948] ata4: protocol 5 task_state 4 (dev_stat 0x58)
[  105.476418] ata4: protocol 5 task_state 1
[  105.476422] ata4: host_stat 0x4
[  105.476428] ata4: protocol 5 task_state 1 (dev_stat 0x51)
[  105.476431] ata4: protocol 5 task_state 2 (dev_stat 0x51)
[  105.476434] ata4: protocol 5 task_state 3 (dev_stat 0x51)
[  105.476514] ata4: protocol 5 task_state 4 (dev_stat 0x58)
[  105.477102] ata4: protocol 5 task_state 1
[  105.477106] ata4: host_stat 0x4
[  105.477111] ata4: protocol 5 task_state 1 (dev_stat 0x58)
[  105.477219] ata4: protocol 5 task_state 1
[  105.477222] ata4: host_stat 0x4
[  105.477227] ata4: protocol 5 task_state 1 (dev_stat 0x50)
[  105.477230] ata4: protocol 5 task_state 2 (dev_stat 0x50)
[  105.477260] CDB (4:0,1,0) 25 00 00 00 00 00 00 00 00
[  105.477314] ata4: protocol 5 task_state 4 (dev_stat 0x58)
[  105.477783] ata4: protocol 5 task_state 1
[  105.477787] ata4: host_stat 0x4
[  105.477792] ata4: protocol 5 task_state 1 (dev_stat 0x51)
[  105.477795] ata4: protocol 5 task_state 2 (dev_stat 0x51)
[  105.477798] ata4: protocol 5 task_state 3 (dev_stat 0x51)
[  105.477874] ata4: protocol 5 task_state 4 (dev_stat 0x58)
[  105.478468] ata4: protocol 5 task_state 1
[  105.478471] ata4: host_stat 0x4
[  105.478477] ata4: protocol 5 task_state 1 (dev_stat 0x58)
[  105.478584] ata4: protocol 5 task_state 1
[  105.478587] ata4: host_stat 0x4
[  105.478592] ata4: protocol 5 task_state 1 (dev_stat 0x50)
[  105.478595] ata4: protocol 5 task_state 2 (dev_stat 0x50)
[  105.478623] CDB (4:0,1,0) 25 00 00 00 00 00 00 00 00
[  105.478677] ata4: protocol 5 task_state 4 (dev_stat 0x58)
[  105.479148] ata4: protocol 5 task_state 1
[  105.479152] ata4: host_stat 0x4
[  105.479157] ata4: protocol 5 task_state 1 (dev_stat 0x51)
[  105.479160] ata4: protocol 5 task_state 2 (dev_stat 0x51)
[  105.479163] ata4: protocol 5 task_state 3 (dev_stat 0x51)
[  105.479239] ata4: protocol 5 task_state 4 (dev_stat 0x58)
[  105.479833] ata4: protocol 5 task_state 1
[  105.479836] ata4: host_stat 0x4
[  105.479842] ata4: protocol 5 task_state 1 (dev_stat 0x58)
[  105.479950] ata4: protocol 5 task_state 1
[  105.479953] ata4: host_stat 0x4
[  105.479958] ata4: protocol 5 task_state 1 (dev_stat 0x50)
[  105.479961] ata4: protocol 5 task_state 2 (dev_stat 0x50)
[  105.480046] CDB (4:0,1,0) 12 01 00 00 fe 00 00 00 00
[  105.480101] ata4: protocol 5 task_state 4 (dev_stat 0x58)
[  105.480551] ata4: protocol 5 task_state 1
[  105.480555] ata4: host_stat 0x4
[  105.480561] ata4: protocol 5 task_state 1 (dev_stat 0x51)
[  105.480564] ata4: protocol 5 task_state 2 (dev_stat 0x51)
[  105.480567] ata4: protocol 5 task_state 3 (dev_stat 0x51)
[  105.480644] ata4: protocol 5 task_state 4 (dev_stat 0x58)
[  113.509692] ata4: protocol 5 task_state 1
[  113.509703] ata4: host_stat 0x0
[  113.510276] ata4: protocol 5 task_state 1
[  113.510280] ata4: host_stat 0x0
[  113.510890] ata4: protocol 5 task_state 1
[  113.510894] ata4: host_stat 0x0
[  113.512120] ata4: protocol 5 task_state 1
[  113.512124] ata4: host_stat 0x0
[  113.513615] ata4: protocol 5 task_state 1
[  113.513618] ata4: host_stat 0x0
[  113.514228] ata4: protocol 5 task_state 1
[  113.514231] ata4: host_stat 0x0
[  113.515461] ata4: protocol 5 task_state 1
[  113.515464] ata4: host_stat 0x0
[  113.516992] ata4: protocol 5 task_state 1
[  113.516996] ata4: host_stat 0x0
[  113.517601] ata4: protocol 5 task_state 1
[  113.517604] ata4: host_stat 0x0
[  113.518813] ata4: protocol 5 task_state 1
[  113.518816] ata4: host_stat 0x0
[  113.520297] ata4: protocol 5 task_state 1
[  113.520301] ata4: host_stat 0x0
[  113.520904] ata4: protocol 5 task_state 1
[  113.520908] ata4: host_stat 0x0
[  113.522131] ata4: protocol 5 task_state 1
[  113.522134] ata4: host_stat 0x0
[  119.374296] ata4: protocol 5 task_state 1
[  119.374307] ata4: host_stat 0x0
[  119.374421] ata4: protocol 5 task_state 1
[  119.374425] ata4: host_stat 0x0
[  123.791814] ata4: protocol 5 task_state 1
[  123.791825] ata4: host_stat 0x0
[  123.792374] ata4: protocol 5 task_state 1
[  123.792377] ata4: host_stat 0x0
[  126.226710] ata4: protocol 5 task_state 1
[  126.226721] ata4: host_stat 0x0
[  126.227294] ata4: protocol 5 task_state 1
[  126.227298] ata4: host_stat 0x0
[  126.320673] ata4: protocol 5 task_state 1
[  126.320683] ata4: host_stat 0x0
[  126.320794] ata4: protocol 5 task_state 1
[  126.320798] ata4: host_stat 0x0
[  126.974867] ata4: protocol 5 task_state 1
[  126.974877] ata4: host_stat 0x0
[  127.491048] ata4: protocol 5 task_state 1
[  127.491059] ata4: host_stat 0x0
[  127.491132] ata4: protocol 5 task_state 1
[  127.491136] ata4: host_stat 0x0
[  127.723773] ata4: protocol 5 task_state 1
[  127.723783] ata4: host_stat 0x0
[  128.885431] ata4: protocol 5 task_state 1
[  128.885442] ata4: host_stat 0x0
[  128.885546] ata4: protocol 5 task_state 1
[  128.885549] ata4: host_stat 0x0
[  130.469771] ata4: protocol 5 task_state 1
[  130.469782] ata4: host_stat 0x0
[  130.470361] ata4: protocol 5 task_state 1
[  130.470364] ata4: host_stat 0x0
[  131.218534] ata4: protocol 5 task_state 1
[  131.218545] ata4: host_stat 0x0
[  131.967403] ata4: protocol 5 task_state 1
[  131.967414] ata4: host_stat 0x0
[  133.481105] ata4: protocol 5 task_state 1
[  133.481116] ata4: host_stat 0x0
[  133.481700] ata4: protocol 5 task_state 1
[  133.481704] ata4: host_stat 0x0
[  133.482309] ata4: protocol 5 task_state 1
[  133.482312] ata4: host_stat 0x0
[  133.483544] ata4: protocol 5 task_state 1
[  133.483547] ata4: host_stat 0x0
[  133.485033] ata4: protocol 5 task_state 1
[  133.485037] ata4: host_stat 0x0
[  133.485646] ata4: protocol 5 task_state 1
[  133.485650] ata4: host_stat 0x0
[  133.486874] ata4: protocol 5 task_state 1
[  133.486878] ata4: host_stat 0x0
[  133.488399] ata4: protocol 5 task_state 1
[  133.488403] ata4: host_stat 0x0
[  133.489013] ata4: protocol 5 task_state 1
[  133.489016] ata4: host_stat 0x0
[  133.490231] ata4: protocol 5 task_state 1
[  133.490235] ata4: host_stat 0x0
[  133.491721] ata4: protocol 5 task_state 1
[  133.491724] ata4: host_stat 0x0
[  133.492323] ata4: protocol 5 task_state 1
[  133.492326] ata4: host_stat 0x0
[  133.493545] ata4: protocol 5 task_state 1
[  133.493548] ata4: host_stat 0x0
[  134.715230] ata4: protocol 5 task_state 1
[  134.715240] ata4: host_stat 0x0
[  134.715821] ata4: protocol 5 task_state 1
[  134.715825] ata4: host_stat 0x0
[  135.435628] ata4.01: qc timeout (cmd 0xa0)
[  135.435646] ata4.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 
frozen
[  135.435660] ata4.01: cmd a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 
cdb 0x12 data 254 in
[  135.435663]          res 51/51:03:00:12:00/00:00:00:00:00/b0 Emask 
0x5 (timeout)
[  142.425183] ata4: port is slow to respond, please be patient (Status 
0xd8)
[  165.406773] ata4: port failed to respond (30 secs, Status 0xd8)
[  165.406786] ata4: soft resetting port
[  165.573946] ATA: abnormal status 0x7F on port 0xE08815DF
[  165.585332] ATA: abnormal status 0x7F on port 0xE08815DF
[  165.746275] ata4: protocol 2 task_state 1 (dev_stat 0x51)
[  165.746286] ata4: protocol 2 task_state 3 (dev_stat 0x51)
[  165.746320] ata4.01: failed to IDENTIFY (I/O error, err_mask=0x1)
[  165.746324] ata4.01: revalidation failed (errno=-5)
[  165.746330] ata4: failed to recover some devices, retrying in 5 secs
[  170.742819] ata4: soft resetting port
[  170.909969] ATA: abnormal status 0x7F on port 0xE08815DF
[  170.921349] ATA: abnormal status 0x7F on port 0xE08815DF
[  171.082305] ata4: protocol 2 task_state 1 (dev_stat 0x58)
[  171.082568] ata4: protocol 2 task_state 2 (dev_stat 0x50)
[  171.082613] ata4.01: device is on DMA blacklist, disabling DMA
[  171.082747] ata4: protocol 1 task_state 2
[  171.082751] ata4: host_stat 0x4
[  171.082757] ata4: protocol 1 task_state 2 (dev_stat 0x50)
[  171.246050] ata4: protocol 2 task_state 1 (dev_stat 0x58)
[  171.246333] ata4: protocol 2 task_state 2 (dev_stat 0x50)
[  171.246373] ata4.01: configured for PIO4
[  171.246421] ata4: EH complete
[  171.246518] CDB (4:0,1,0) 1e 00 00 00 00 00 00 00 00
[  171.246578] ata4: protocol 6 task_state 4 (dev_stat 0x58)
[  171.246878] ata4: protocol 6 task_state 2
[  171.246882] ata4: host_stat 0x4
[  171.246887] ata4: protocol 6 task_state 2 (dev_stat 0x50)
[  171.249402] CDB (4:0,1,0) 00 00 00 00 00 00 00 00 00
[  171.249486] ata4: protocol 6 task_state 4 (dev_stat 0x58)
[  171.249988] ata4: protocol 6 task_state 2
[  171.249992] ata4: host_stat 0x4
[  171.249998] ata4: protocol 6 task_state 2 (dev_stat 0x51)
[  171.250001] ata4: protocol 6 task_state 3 (dev_stat 0x51)
[  171.250115] ata4: protocol 5 task_state 4 (dev_stat 0x58)
[  171.250706] ata4: protocol 5 task_state 1
[  171.250709] ata4: host_stat 0x4
[  171.250714] ata4: protocol 5 task_state 1 (dev_stat 0x58)
[  171.250821] ata4: protocol 5 task_state 1
[  171.250824] ata4: host_stat 0x4
[  171.250830] ata4: protocol 5 task_state 1 (dev_stat 0x50)
[  171.250833] ata4: protocol 5 task_state 2 (dev_stat 0x50)
[  171.250904] CDB (4:0,1,0) 43 00 00 00 00 00 00 00 0c
[  171.250958] ata4: protocol 5 task_state 4 (dev_stat 0x58)
[  171.251386] ata4: protocol 5 task_state 1
[  171.251389] ata4: host_stat 0x4
[  171.251395] ata4: protocol 5 task_state 1 (dev_stat 0x51)
[  171.251398] ata4: protocol 5 task_state 2 (dev_stat 0x51)
[  171.251401] ata4: protocol 5 task_state 3 (dev_stat 0x51)
[  171.251478] ata4: protocol 5 task_state 4 (dev_stat 0x58)
[  171.252071] ata4: protocol 5 task_state 1
[  171.252074] ata4: host_stat 0x4
[  171.252079] ata4: protocol 5 task_state 1 (dev_stat 0x58)
[  171.252187] ata4: protocol 5 task_state 1
[  171.252190] ata4: host_stat 0x4
[  171.252196] ata4: protocol 5 task_state 1 (dev_stat 0x50)
[  171.252199] ata4: protocol 5 task_state 2 (dev_stat 0x50)
[  171.252231] CDB (4:0,1,0) 43 00 00 00 00 00 00 00 0c
[  171.252284] ata4: protocol 5 task_state 4 (dev_stat 0x58)
[  171.252751] ata4: protocol 5 task_state 1
[  171.252755] ata4: host_stat 0x4
[  171.252760] ata4: protocol 5 task_state 1 (dev_stat 0x51)
[  171.252763] ata4: protocol 5 task_state 2 (dev_stat 0x51)
[  171.252766] ata4: protocol 5 task_state 3 (dev_stat 0x51)
[  171.252842] ata4: protocol 5 task_state 4 (dev_stat 0x58)
[  171.253437] ata4: protocol 5 task_state 1
[  171.253440] ata4: host_stat 0x4
[  171.253445] ata4: protocol 5 task_state 1 (dev_stat 0x58)
[  171.253552] ata4: protocol 5 task_state 1
[  171.253555] ata4: host_stat 0x4
[  171.253561] ata4: protocol 5 task_state 1 (dev_stat 0x50)
[  171.253564] ata4: protocol 5 task_state 2 (dev_stat 0x50)
[  171.253592] CDB (4:0,1,0) 25 00 00 00 00 00 00 00 00
[  171.253646] ata4: protocol 5 task_state 4 (dev_stat 0x58)
[  171.254119] ata4: protocol 5 task_state 1
[  171.254123] ata4: host_stat 0x4
[  171.254129] ata4: protocol 5 task_state 1 (dev_stat 0x51)
[  171.254132] ata4: protocol 5 task_state 2 (dev_stat 0x51)
[  171.254135] ata4: protocol 5 task_state 3 (dev_stat 0x51)
[  171.254247] ata4: protocol 5 task_state 4 (dev_stat 0x58)
[  171.254810] ata4: protocol 5 task_state 1
[  171.254820] ata4: host_stat 0x4
[  171.254827] ata4: protocol 5 task_state 1 (dev_stat 0x58)
[  171.254932] ata4: protocol 5 task_state 1
[  171.254936] ata4: host_stat 0x4
[  171.254942] ata4: protocol 5 task_state 1 (dev_stat 0x50)
[  171.254945] ata4: protocol 5 task_state 2 (dev_stat 0x50)
[  171.255986] CDB (4:0,1,0) 25 00 00 00 00 00 00 00 00
[  171.256064] ata4: protocol 5 task_state 4 (dev_stat 0x58)
[  171.256595] ata4: protocol 5 task_state 1
[  171.256600] ata4: host_stat 0x4
[  171.256605] ata4: protocol 5 task_state 1 (dev_stat 0x51)
[  171.256608] ata4: protocol 5 task_state 2 (dev_stat 0x51)
[  171.256611] ata4: protocol 5 task_state 3 (dev_stat 0x51)
[  171.256703] ata4: protocol 5 task_state 4 (dev_stat 0x58)
[  171.257276] ata4: protocol 5 task_state 1
[  171.257279] ata4: host_stat 0x4
[  171.257285] ata4: protocol 5 task_state 1 (dev_stat 0x58)
[  171.257392] ata4: protocol 5 task_state 1
[  171.257395] ata4: host_stat 0x4
[  171.257400] ata4: protocol 5 task_state 1 (dev_stat 0x50)
[  171.257403] ata4: protocol 5 task_state 2 (dev_stat 0x50)
[  171.257450] CDB (4:0,1,0) 25 00 00 00 00 00 00 00 00
[  171.257504] ata4: protocol 5 task_state 4 (dev_stat 0x58)
[  171.257956] ata4: protocol 5 task_state 1
[  171.257960] ata4: host_stat 0x4
[  171.257965] ata4: protocol 5 task_state 1 (dev_stat 0x51)
[  171.257968] ata4: protocol 5 task_state 2 (dev_stat 0x51)
[  171.257971] ata4: protocol 5 task_state 3 (dev_stat 0x51)
[  171.258084] ata4: protocol 5 task_state 4 (dev_stat 0x58)
[  171.258641] ata4: protocol 5 task_state 1
[  171.258645] ata4: host_stat 0x4
[  171.258650] ata4: protocol 5 task_state 1 (dev_stat 0x58)
[  171.258758] ata4: protocol 5 task_state 1
[  171.258761] ata4: host_stat 0x4
[  171.258766] ata4: protocol 5 task_state 1 (dev_stat 0x50)
[  171.258769] ata4: protocol 5 task_state 2 (dev_stat 0x50)
[  171.258863] CDB (4:0,1,0) 12 01 00 00 fe 00 00 00 00
[  171.258918] ata4: protocol 5 task_state 4 (dev_stat 0x58)
[  171.259359] ata4: protocol 5 task_state 1
[  171.259363] ata4: host_stat 0x4
[  171.259368] ata4: protocol 5 task_state 1 (dev_stat 0x51)
[  171.259371] ata4: protocol 5 task_state 2 (dev_stat 0x51)
[  171.259374] ata4: protocol 5 task_state 3 (dev_stat 0x51)
[  171.259451] ata4: protocol 5 task_state 4 (dev_stat 0x58)
[  172.538040] ata4: protocol 5 task_state 1
[  172.538051] ata4: host_stat 0x0
[  172.538145] ata4: protocol 5 task_state 1
[  172.538150] ata4: host_stat 0x0
[  173.424869] ata4: protocol 5 task_state 1
[  173.424880] ata4: host_stat 0x0
[  173.425452] ata4: protocol 5 task_state 1
[  173.425456] ata4: host_stat 0x0
[  173.426060] ata4: protocol 5 task_state 1
[  173.426064] ata4: host_stat 0x0
[  173.427291] ata4: protocol 5 task_state 1
[  173.427295] ata4: host_stat 0x0
[  173.428809] ata4: protocol 5 task_state 1
[  173.428812] ata4: host_stat 0x0
[  173.429410] ata4: protocol 5 task_state 1
[  173.429414] ata4: host_stat 0x0
[  173.430643] ata4: protocol 5 task_state 1
[  173.430647] ata4: host_stat 0x0
[  173.432169] ata4: protocol 5 task_state 1
[  173.432172] ata4: host_stat 0x0
[  173.432782] ata4: protocol 5 task_state 1
[  173.432785] ata4: host_stat 0x0
[  173.433995] ata4: protocol 5 task_state 1
[  173.433999] ata4: host_stat 0x0
[  173.435542] ata4: protocol 5 task_state 1
[  173.435546] ata4: host_stat 0x0
[  173.436143] ata4: protocol 5 task_state 1
[  173.436147] ata4: host_stat 0x0
[  173.437382] ata4: protocol 5 task_state 1
[  173.437386] ata4: host_stat 0x0
[  174.343900] ata4: protocol 5 task_state 1
[  174.343911] ata4: host_stat 0x0
[  174.344021] ata4: protocol 5 task_state 1
[  174.344025] ata4: host_stat 0x0
[  175.981991] ata4: protocol 5 task_state 1
[  175.982004] ata4: host_stat 0x0
[  175.982068] ata4: protocol 5 task_state 1
[  175.982072] ata4: host_stat 0x0
[  183.700872] ata4: protocol 5 task_state 1
[  183.700884] ata4: host_stat 0x0
[  183.701438] ata4: protocol 5 task_state 1
[  183.701442] ata4: host_stat 0x0
[  187.149097] ata4: protocol 5 task_state 1
[  187.149108] ata4: host_stat 0x0
[  187.149222] ata4: protocol 5 task_state 1
[  187.149226] ata4: host_stat 0x0
[  192.175325] ata4: protocol 5 task_state 1
[  192.175336] ata4: host_stat 0x0
[  192.175442] ata4: protocol 5 task_state 1
[  192.175446] ata4: host_stat 0x0
[  193.396823] ata4: protocol 5 task_state 1
[  193.396834] ata4: host_stat 0x0
[  193.397412] ata4: protocol 5 task_state 1
[  193.397416] ata4: host_stat 0x0
[  193.398020] ata4: protocol 5 task_state 1
[  193.398024] ata4: host_stat 0x0
[  193.399255] ata4: protocol 5 task_state 1
[  193.399259] ata4: host_stat 0x0
[  193.400756] ata4: protocol 5 task_state 1
[  193.400760] ata4: host_stat 0x0
[  193.401364] ata4: protocol 5 task_state 1
[  193.401368] ata4: host_stat 0x0
[  193.402591] ata4: protocol 5 task_state 1
[  193.402594] ata4: host_stat 0x0
[  193.404122] ata4: protocol 5 task_state 1
[  193.404125] ata4: host_stat 0x0
[  193.404736] ata4: protocol 5 task_state 1
[  193.404739] ata4: host_stat 0x0
[  193.405943] ata4: protocol 5 task_state 1
[  193.405946] ata4: host_stat 0x0
[  193.407427] ata4: protocol 5 task_state 1
[  193.407430] ata4: host_stat 0x0
[  193.408033] ata4: protocol 5 task_state 1
[  193.408037] ata4: host_stat 0x0
[  193.409256] ata4: protocol 5 task_state 1
[  193.409260] ata4: host_stat 0x0
[  201.213244] ata4.01: qc timeout (cmd 0xa0)
[  201.213261] ata4.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 
frozen
[  201.213275] ata4.01: cmd a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 
cdb 0x12 data 254 in
[  201.213278]          res 51/51:03:00:12:00/00:00:00:00:00/b0 Emask 
0x5 (timeout)
[  208.202798] ata4: port is slow to respond, please be patient (Status 
0xd8)
[  226.517486] fuse init (API version 7.8)
[  226.517573] PM: Adding info for No Bus:fuse
[  226.556633] lp0: using parport0 (interrupt-driven).
[  226.626319] PM: Adding info for No Bus:i2c-0
[  226.679158] PM: Adding info for i2c:0-0050
[  226.695133] PM: Adding info for i2c:0-0051
[  226.765520] PM: Adding info for No Bus:i2c-9191
[  226.804442] it87: Found IT8712F chip at 0x290, revision 4
[  226.806966] PM: Adding info for i2c:9191-0290
[  226.809416] it87-isa 9191-0290: Detected broken BIOS defaults, 
disabling PWM interface
[  226.960072] Adding 1044184k swap on 
/dev/disk/by-uuid/5c6a2d8c-54c1-44cb-8f1b-4a159373a120.  Priority:-1 
extents:1 across:1044184k
[  227.198847] EXT3 FS on sda7, internal journal
[  230.723686] kjournald starting.  Commit interval 5 seconds
[  230.723853] EXT3 FS on sda1, internal journal
[  230.723860] EXT3-fs: mounted filesystem with ordered data mode.
[  230.749428] kjournald starting.  Commit interval 5 seconds
[  230.749625] EXT3 FS on sda3, internal journal
[  230.749633] EXT3-fs: mounted filesystem with ordered data mode.
[  230.801490] kjournald starting.  Commit interval 5 seconds
[  230.801742] EXT3 FS on sdb5, internal journal
[  230.801751] EXT3-fs: mounted filesystem with ordered data mode.
[  230.878961] NTFS driver 2.1.28 [Flags: R/O MODULE].
[  230.950919] NTFS volume version 3.1.
[  231.075849] kjournald starting.  Commit interval 5 seconds
[  231.076123] EXT3 FS on sdb6, internal journal
[  231.076131] EXT3-fs: mounted filesystem with ordered data mode.
[  231.096927] kjournald starting.  Commit interval 5 seconds
[  231.097091] EXT3 FS on sda5, internal journal
[  231.097099] EXT3-fs: mounted filesystem with ordered data mode.
[  231.127698] kjournald starting.  Commit interval 5 seconds
[  231.127853] EXT3 FS on sda2, internal journal
[  231.127862] EXT3-fs: mounted filesystem with ordered data mode.
[  231.184388] ata4: port failed to respond (30 secs, Status 0xd8)
[  231.184399] ata4: soft resetting port
[  231.351557] ATA: abnormal status 0x7F on port 0xE08815DF
[  231.363013] ATA: abnormal status 0x7F on port 0xE08815DF
[  231.523914] ata4: protocol 2 task_state 1 (dev_stat 0x51)
[  231.523925] ata4: protocol 2 task_state 3 (dev_stat 0x51)
[  231.523964] ata4.01: failed to IDENTIFY (I/O error, err_mask=0x1)
[  231.523968] ata4.01: revalidation failed (errno=-5)
[  231.523976] ata4: failed to recover some devices, retrying in 5 secs
[  233.208238] NET: Registered protocol family 17
[  236.520433] ata4: soft resetting port
[  236.687575] ATA: abnormal status 0x7F on port 0xE08815DF
[  236.698947] ATA: abnormal status 0x7F on port 0xE08815DF
[  236.859904] ata4: protocol 2 task_state 1 (dev_stat 0x58)
[  236.860163] ata4: protocol 2 task_state 2 (dev_stat 0x50)
[  236.860206] ata4.01: device is on DMA blacklist, disabling DMA
[  236.860334] ata4: protocol 1 task_state 2
[  236.860338] ata4: host_stat 0x4
[  236.860344] ata4: protocol 1 task_state 2 (dev_stat 0x50)
[  237.023658] ata4: protocol 2 task_state 1 (dev_stat 0x58)
[  237.023933] ata4: protocol 2 task_state 2 (dev_stat 0x50)
[  237.023963] ata4.01: configured for PIO4
[  237.023990] ata4: EH complete
[  237.024078] CDB (4:0,1,0) 1e 00 00 00 00 00 00 00 00
[  237.024136] ata4: protocol 6 task_state 4 (dev_stat 0x58)
[  237.024466] ata4: protocol 6 task_state 2
[  237.024470] ata4: host_stat 0x4
[  237.024476] ata4: protocol 6 task_state 2 (dev_stat 0x50)
[  237.492179] PM: Adding info for No Bus:vcs2
[  237.495203] PM: Adding info for No Bus:vcsa2
[  237.498249] PM: Removing info for No Bus:vcs2
[  237.500841] PM: Removing info for No Bus:vcsa2
[  237.503592] PM: Adding info for No Bus:vcs3
[  237.506509] PM: Adding info for No Bus:vcsa3
[  237.509627] PM: Removing info for No Bus:vcs3
[  237.512230] PM: Removing info for No Bus:vcsa3
[  237.514952] PM: Adding info for No Bus:vcs4
[  237.517864] PM: Adding info for No Bus:vcsa4
[  237.520939] PM: Removing info for No Bus:vcs4
[  237.523511] PM: Removing info for No Bus:vcsa4
[  237.526211] PM: Adding info for No Bus:vcs5
[  237.529177] PM: Adding info for No Bus:vcsa5
[  237.532242] PM: Removing info for No Bus:vcs5
[  237.534796] PM: Removing info for No Bus:vcsa5
[  237.537549] PM: Adding info for No Bus:vcs6
[  237.540488] PM: Adding info for No Bus:vcsa6
[  237.543578] PM: Removing info for No Bus:vcs6
[  237.546143] PM: Removing info for No Bus:vcsa6
[  237.601243] PM: Adding info for No Bus:vcs2
[  237.604278] PM: Adding info for No Bus:vcsa2
[  237.608738] PM: Removing info for No Bus:vcs2
[  237.611399] PM: Removing info for No Bus:vcsa2
[  237.617946] PM: Adding info for No Bus:vcs3
[  237.620989] PM: Adding info for No Bus:vcsa3
[  237.625468] PM: Removing info for No Bus:vcs3
[  237.628191] PM: Removing info for No Bus:vcsa3
[  237.634691] PM: Adding info for No Bus:vcs4
[  237.637729] PM: Adding info for No Bus:vcsa4
[  237.642211] PM: Removing info for No Bus:vcs4
[  237.644862] PM: Removing info for No Bus:vcsa4
[  237.651417] PM: Adding info for No Bus:vcs5
[  237.654425] PM: Adding info for No Bus:vcsa5
[  237.658930] PM: Removing info for No Bus:vcs5
[  237.661557] PM: Removing info for No Bus:vcsa5
[  237.668159] PM: Adding info for No Bus:vcs6
[  237.671196] PM: Adding info for No Bus:vcsa6
[  237.675637] PM: Removing info for No Bus:vcs6
[  237.678280] PM: Removing info for No Bus:vcsa6
[  238.048195] PM: Adding info for No Bus:vcs4
[  238.048999] PM: Adding info for No Bus:vcsa4
[  238.051342] PM: Adding info for No Bus:vcs5
[  238.052199] PM: Adding info for No Bus:vcsa5
[  238.063699] PM: Adding info for No Bus:vcs3
[  238.064497] PM: Adding info for No Bus:vcsa3
[  238.076877] PM: Adding info for No Bus:vcs6
[  238.079930] PM: Adding info for No Bus:vcsa6
[  238.083802] PM: Adding info for No Bus:vcs2
[  238.084609] PM: Adding info for No Bus:vcsa2
[  243.707008] Capability LSM initialized
[  244.118470] PM: Adding info for No Bus:parport0
[  244.123012] ppdev: user-space parallel port driver
[  246.876872] apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16ac)
[  246.877503] PM: Adding info for No Bus:apm_bios
[  250.339650] PM: Adding info for No Bus:vcs7
[  250.343953] PM: Adding info for No Bus:vcsa7
[  250.920062] [drm] Initialized drm 1.1.0 20060810
[  250.989635] [drm] Initialized radeon 1.25.0 20060524 on minor 0
[  252.707001] agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
[  252.707263] agpgart: Putting AGP V2 device at 0000:00:00.0 into 1x mode
[  252.707284] agpgart: Putting AGP V2 device at 0000:01:00.0 into 1x mode
[  253.048476] [drm] Setting GART location based on new memory map
[  253.048548] [drm] writeback test succeeded in 1 usecs



