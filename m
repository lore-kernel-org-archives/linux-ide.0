From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: LSISAS1068E + WDC WD2002FYPS: I/O error & Sense Key
Date: Wed, 29 Jul 2009 13:43:06 -0600
Message-ID: <4A70A64A.2070605@gmail.com>
References: <20090727060322.GB27002@lifeintegrity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-px0-f201.google.com ([209.85.216.201]:37810 "EHLO
	mail-px0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754091AbZG2TtO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 29 Jul 2009 15:49:14 -0400
Received: by pxi39 with SMTP id 39so641371pxi.4
        for <linux-ide@vger.kernel.org>; Wed, 29 Jul 2009 12:49:14 -0700 (PDT)
In-Reply-To: <20090727060322.GB27002@lifeintegrity.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Allan Wind <allan_wind@lifeintegrity.com>
Cc: linux-ide@vger.kernel.org

On 07/27/2009 12:03 AM, Allan Wind wrote:
> I have a pair of Western Digital RE4-GP (WD2002FYPS) in RAID1 configuration
> using Linux 2.6.30.3 and seeing the following:
>
> [ 4907.485324] end_request: I/O error, dev sdb, sector 3907028974

Are there no error messages before this point? Can you post the full 
dmesg output from bootup?

> [ 4907.485543] md: super_written gets error=-5, uptodate=0
> [ 4907.485546] raid1: Disk failure on sdb2, disabling device.
> [ 4907.485547] raid1: Operation continuing on 1 devices.
> [ 4907.499157] RAID1 conf printout:
> [ 4907.499159]  --- wd:1 rd:2
> [ 4907.499162]  disk 0, wo:0, o:1, dev:sda2
> [ 4907.499164]  disk 1, wo:1, o:0, dev:sdb2
> [ 4907.503037] RAID1 conf printout:
> [ 4907.503039]  --- wd:1 rd:2
> [ 4907.503041]  disk 0, wo:0, o:1, dev:sda2
> [ 6705.292961] sd 4:0:1:0: [sdb] Sense Key : Recovered Error [current] [descriptor]
> [ 6705.292967] Descriptor sense data with sense descriptors (in hex):
> [ 6705.292970]         72 01 00 1d 00 00 00 0e 09 0c 00 00 00 00 00 00
> [ 6705.292978]         00 4f 00 c2 00 50
> [ 6705.292983] sd 4:0:1:0: [sdb] Add. Sense: ATA pass through information available
> [ 6705.359497] sd 4:0:1:0: [sdb] Sense Key : Recovered Error [current] [descriptor]
> [ 6705.359502] Descriptor sense data with sense descriptors (in hex):
> [ 6705.359504]         72 01 00 1d 00 00 00 0e 09 0c 00 00 00 00 00 00
> [ 6705.359513]         00 4f 00 c2 00 50
> [ 6705.359517] sd 4:0:1:0: [sdb] Add. Sense: ATA pass through information available
> [ 6724.022616] sd 4:0:1:0: [sdb] Sense Key : Recovered Error [current] [descriptor]
> [ 6724.022622] Descriptor sense data with sense descriptors (in hex):
> [ 6724.022624]         72 01 00 1d 00 00 00 0e 09 0c 00 00 00 00 00 00
> [ 6724.022633]         00 4f 00 c2 00 50
> [ 6724.022638] sd 4:0:1:0: [sdb] Add. Sense: ATA pass through information available
> [ 6724.078063] sd 4:0:1:0: [sdb] Sense Key : Recovered Error [current] [descriptor]
> [ 6724.078068] Descriptor sense data with sense descriptors (in hex):
> [ 6724.078070]         72 01 00 1d 00 00 00 0e 09 0c 00 00 00 00 00 00
> [ 6724.078079]         00 4f 00 c2 00 50
> [ 6724.078083] sd 4:0:1:0: [sdb] Add. Sense: ATA pass through information available
> [ 6740.035419] sd 4:0:1:0: [sdb] Sense Key : Recovered Error [current] [descriptor]
> [ 6740.035425] Descriptor sense data with sense descriptors (in hex):
> [ 6740.035427]         72 01 00 1d 00 00 00 0e 09 0c 00 00 00 00 00 00
> [ 6740.035435]         00 4f 00 c2 00 50
> [ 6740.035440] sd 4:0:1:0: [sdb] Add. Sense: ATA pass through information available
> [ 6740.090867] sd 4:0:1:0: [sdb] Sense Key : Recovered Error [current] [descriptor]
> [ 6740.090872] Descriptor sense data with sense descriptors (in hex):
> [ 6740.090874]         72 01 00 1d 00 00 00 0e 09 0c 00 00 00 00 00 00
> [ 6740.090882]         00 4f 00 c2 00 50
> [ 6740.090887] sd 4:0:1:0: [sdb] Add. Sense: ATA pass through information available
> [ 6812.955958] sd 4:0:0:0: [sda] Sense Key : Recovered Error [current] [descriptor]
> [ 6812.955965] Descriptor sense data with sense descriptors (in hex):
> [ 6812.955967]         72 01 00 1d 00 00 00 0e 09 0c 00 00 00 00 00 00
> [ 6812.955976]         00 4f 00 c2 00 50
> [ 6812.955980] sd 4:0:0:0: [sda] Add. Sense: ATA pass through information available
> [ 6813.011403] sd 4:0:0:0: [sda] Sense Key : Recovered Error [current] [descriptor]
> [ 6813.011408] Descriptor sense data with sense descriptors (in hex):
> [ 6813.011410]         72 01 00 1d 00 00 00 0e 09 0c 00 00 00 00 00 00
> [ 6813.011419]         00 4f 00 c2 00 50
> [ 6813.011423] sd 4:0:0:0: [sda] Add. Sense: ATA pass through information available
> [ 6818.944137] sd 4:0:0:0: [sda] Sense Key : Recovered Error [current] [descriptor]
> [ 6818.944143] Descriptor sense data with sense descriptors (in hex):
> [ 6818.944146]         72 01 00 1d 00 00 00 0e 09 0c 00 00 00 00 00 00
> [ 6818.944154]         00 4f 00 c2 00 50
> [ 6818.944159] sd 4:0:0:0: [sda] Add. Sense: ATA pass through information available
> [ 6818.999583] sd 4:0:0:0: [sda] Sense Key : Recovered Error [current] [descriptor]
> [ 6818.999587] Descriptor sense data with sense descriptors (in hex):
> [ 6818.999590]         72 01 00 1d 00 00 00 0e 09 0c 00 00 00 00 00 00
> [ 6818.999598]         00 4f 00 c2 00 50
> [ 6818.999602] sd 4:0:0:0: [sda] Add. Sense: ATA pass through information available
> [ 7036.061540] sd 4:0:1:0: [sdb] Sense Key : Recovered Error [current] [descriptor]
> [ 7036.061547] Descriptor sense data with sense descriptors (in hex):
> [ 7036.061549]         72 01 00 1d 00 00 00 0e 09 0c 00 00 00 00 00 00
> [ 7036.061558]         00 4f 00 c2 00 50
> [ 7036.061562] sd 4:0:1:0: [sdb] Add. Sense: ATA pass through information available
> [ 7036.116986] sd 4:0:1:0: [sdb] Sense Key : Recovered Error [current] [descriptor]
> [ 7036.116991] Descriptor sense data with sense descriptors (in hex):
> [ 7036.116993]         72 01 00 1d 00 00 00 0e 09 0c 00 00 00 00 00 00
> [ 7036.117001]         00 4f 00 c2 00 50
> [ 7036.117006] sd 4:0:1:0: [sdb] Add. Sense: ATA pass through information available
> [ 7042.247767] sd 4:0:0:0: [sda] Sense Key : Recovered Error [current] [descriptor]
> [ 7042.247773] Descriptor sense data with sense descriptors (in hex):
> [ 7042.247776]         72 01 00 1d 00 00 00 0e 09 0c 00 00 00 00 00 00
> [ 7042.247784]         00 4f 00 c2 00 50
> [ 7042.247789] sd 4:0:0:0: [sda] Add. Sense: ATA pass through information available
> [ 7042.303215] sd 4:0:0:0: [sda] Sense Key : Recovered Error [current] [descriptor]
> [ 7042.303219] Descriptor sense data with sense descriptors (in hex):
> [ 7042.303221]         72 01 00 1d 00 00 00 0e 09 0c 00 00 00 00 00 00
> [ 7042.303230]         00 4f 00 c2 00 50
> [ 7042.303234] sd 4:0:0:0: [sda] Add. Sense: ATA pass through information available
> [ 7048.136156] sd 4:0:0:0: [sda] Sense Key : Recovered Error [current] [descriptor]
> [ 7048.136162] Descriptor sense data with sense descriptors (in hex):
> [ 7048.136165]         72 01 00 1d 00 00 00 0e 09 0c 00 00 00 00 00 00
> [ 7048.136174]         00 4f 00 c2 00 50
> [ 7048.136178] sd 4:0:0:0: [sda] Add. Sense: ATA pass through information available
> [ 7048.191599] sd 4:0:0:0: [sda] Sense Key : Recovered Error [current] [descriptor]
> [ 7048.191604] Descriptor sense data with sense descriptors (in hex):
> [ 7048.191606]         72 01 00 1d 00 00 00 0e 09 0c 00 00 00 00 00 00
> [ 7048.191614]         00 4f 00 c2 00 50
> [ 7048.191619] sd 4:0:0:0: [sda] Add. Sense: ATA pass through information available
> [ 7051.153936] sd 4:0:1:0: [sdb] Sense Key : Recovered Error [current] [descriptor]
> [ 7051.153942] Descriptor sense data with sense descriptors (in hex):
> [ 7051.153944]         72 01 00 1d 00 00 00 0e 09 0c 00 00 00 00 00 00
> [ 7051.153953]         00 4f 00 c2 00 50
> [ 7051.153958] sd 4:0:1:0: [sdb] Add. Sense: ATA pass through information available
> [ 7051.209384] sd 4:0:1:0: [sdb] Sense Key : Recovered Error [current] [descriptor]
> [ 7051.209388] Descriptor sense data with sense descriptors (in hex):
> [ 7051.209390]         72 01 00 1d 00 00 00 0e 09 0c 00 00 00 00 00 00
> [ 7051.209399]         00 4f 00 c2 00 50
> [ 7051.209403] sd 4:0:1:0: [sdb] Add. Sense: ATA pass through information available
>
> SMART suggest the drives are fine:
>
> pawan:/var/log# smartctl -l error /dev/sda
> smartctl version 5.38 [x86_64-unknown-linux-gnu] Copyright (C) 2002-8 Bruce Allen
> Home page is http://smartmontools.sourceforge.net/
>
> === START OF READ SMART DATA SECTION ===
> SMART Error Log Version: 1
> No Errors Logged
>
> pawan:/var/log# smartctl -l error /dev/sdb
> smartctl version 5.38 [x86_64-unknown-linux-gnu] Copyright (C) 2002-8 Bruce Allen
> Home page is http://smartmontools.sourceforge.net/
>
> === START OF READ SMART DATA SECTION ===
> SMART Error Log Version: 1
> No Errors Logged
>
> I disabled NCQ per instructions at:
> http://linux-ata.org/faq.html#ncq
> Btw, is there a better way than writing a init.d script for tweaking NCQ at
> reboot?
>
> Any ideas?
>
>
> /Allan

