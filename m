From: Stan Hoeppner <stan@hardwarefreak.com>
Subject: Re: kernel 2.6.31.1 + Sil 3512 + WDC WD5000AAKS-00V1A0 = no NCQ and
    UDMA5 instead of UDMA6
Date: Sat, 19 Dec 2009 17:15:53 -0600
Message-ID: <4B2D5EA9.1040106@hardwarefreak.com>
References: <4B2A3D25.9030209@hardwarefreak.com> <4B2A720B.2040809@pobox.com>	 <4B2AE779.9060109@hardwarefreak.com> <4B2AF2C2.9010708@pobox.com>	 <4B2AFBDD.30601@hardwarefreak.com> <4B2AFF7B.4000007@gmail.com>	 <4B2B0642.3010501@hardwarefreak.com> <51f3faa70912172100p103e7698ne8a4216fe6471634@mail.gmail.com> <4B2BDD55.5090800@hardwarefreak.com> <4B2D1893.4060407@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mo-65-41-216-221.sta.embarqhsd.net ([65.41.216.221]:49494 "EHLO
	greer.hardwarefreak.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753669AbZLSXP4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 19 Dec 2009 18:15:56 -0500
In-Reply-To: <4B2D1893.4060407@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Robert Hancock put forth on 12/19/2009 12:16 PM:
> On 12/18/2009 01:51 PM, Stan Hoeppner wrote:
>> Robert Hancock put forth on 12/17/2009 11:00 PM:
>>> On Thu, Dec 17, 2009 at 10:34 PM, Stan
>>> Hoeppner<stan@hardwarefreak.com>  wrote:
>>
>>>> So, how does this "phantom" UDMA setting affect either libata or
>>>> sata_sil?  If it effects nothing, why is it hanging around?  Is this a
>>>> backward compatibility thing for the kernel's benefit?  I'm not a
>>>> kernel
>>>> hacker or programmer (yet), so please forgive my ignorant questions.
>>>
>>> It doesn't affect either the driver or the controller. Only the drive
>>> may possibly care - that would be if there's a SATA-to-PATA bridge
>>> involved (as some early SATA drives had internally, for example) and
>>> there's an actual PATA bus that needs to be programmed properly for
>>> speed. Other than that, it's basically vestigial.
>>
>> So in sata_sil.c version 2.4, the following are only present in the case
>> one of these early drives with an onboard PATA-SATA bridge is connected?
>>
>>          SIL_QUIRK_UDMA5MAX      = (1<<  1),
>>
>> } sil_blacklist [] = {
>>
>>          { "Maxtor 4D060H3",     SIL_QUIRK_UDMA5MAX },
>>
>>
>> static const struct ata_port_info sil_port_info[] = {
>>          /* sil_3512 */
>>          {
>>                  .flags          = SIL_DFL_PORT_FLAGS |
>> SIL_FLAG_RERR_ON_DMA_ACT,
>>                  .pio_mask       = ATA_PIO4,
>>                  .mwdma_mask     = ATA_MWDMA2,
>>                  .udma_mask      = ATA_UDMA5,
>>                  .port_ops       =&sil_ops,
>>          },
>>
>>   *      20040111 - Seagate drives affected by the Mod15Write bug are
>> blacklisted
>>   *      The Maxtor quirk is in the blacklist, but I'm keeping the
>> original
>>   *      pessimistic fix for the following reasons...
>>   *      - There seems to be less info on it, only one device gleaned
>> off the
>>   *      Windows driver, maybe only one is affected.  More info would be
>> greatly
>>   *      appreciated.
>>   *      - But then again UDMA5 is hardly anything to complain about
>>
>>          /* limit to udma5 */
>>          if (quirks&  SIL_QUIRK_UDMA5MAX) {
>>                  if (print_info)
>>                          ata_dev_printk(dev, KERN_INFO, "applying
>> Maxtor "
>>                                         "errata fix %s\n", model_num);
>>                  dev->udma_mask&= ATA_UDMA5;
>>                  return;
>>          }
>>
>>
>> Might it be beneficial, if merely to keep people like myself from asking
>> questions, to set the default for the 3512 to UDMA6 max instead of UDMA5
>> max, and only set UDMA5 in the case of a blacklisted Maxtor?  I'm sure
>> I'm not the first person to see in dmesg that my drive is showing
>> UDMA/133 capability but sata_sil is "limiting" the drive to UDMA/100.
>> If this setting is merely window dressing for all but the oldest borked
>> SATA1 drives with bridge chips, why not fix up this code so it at least
>> "appears" the controller is matching the mode the new pure SATA drive is
>> reporting?
> 
> For whatever reason the sata_sil driver only indicates it supports
> UDMA5, not UDMA6. So it appears that Maxtor quirk doesn't really do
> anything, all drivers will only get programmed as UDMA5 max anyway.

According to the source comments Jeff seems to hint that it's a conscious
decision he made for sata_sil chips, although he doesn't elaborate as to all the
"why's" in the comments.  Jeff, would you shed more light on this please?  It
probably makes no difference in my case, I'm just curious.

> Most likely not for just NCQ. Though, the other thing a newer controller
> would have would be 3Gbps SATA support, you might see a little boost
> from that in some cases.

My controller card is brand new, although, obviously based on a rather old chip
design (what, 4-5 years on the 3512?), thus the $15 price tag.  So, I understand
your point, and agree that a 3Gbs controller might boost performance a little
bit in some cases, basically bursting to/from the drive cache.  But most of the
time, that 300MB/s bus would be limited one one side by a 133MB/s PCI bus and on
the other side by a drive that can only push a sequential read max of 126MB/s
according to the manufacturer, and that's a raw byte figure for the electronics
on this drive series, not particularly _this_ drive.  A couple of reasons I
didn't go with a sata2 controller are cost, though not extravagantly high, and
plugging in a dual channel card with 600MB/s potential into a 133MB/s PCI bus.
Oh, and 3rd I was under the mistaken impression that the card I was purchasing
did support NCQ.  Turns out that was not the case...

>>> It's true the biggest benefits tend to be with multithreaded
>>> workloads, but even single-threaded workloads can get broken down by
>>> the kernel into multiple parallel requests.
>>
>> Noted.  Speaking of the kernel, why do I see 85MB/s using O_DIRECT with
>> hdparm, yet I only get 55MB/s with buffered reads?  On my workstation,
>> with a 4 year old 120GB Seagate IDE disk I get 32MB/s with both hdparm
>> test modes.  O_DIRECT gives no advantage on my workstation, but a 38%
>> advantage on the server.  The server with the SATA drive, the machine
>> we've been discussing the past few days, is a dual 550MHz CPU with PC100
>> memory bus, Intel BX chipset (circa 1998), and sil3512 PCI SATA card.
>> The workstation is an Athlon XP (32 bit) at 2GHz with nVidia nForce2
>> chipset, dual channel DDR2 400.  The server is running Debian 5.0.3 with
>> my custom 2.6.31.1 kernel built from kernel.org sources with make
>> menuconfig.  The workstation is running a stock SuSE Linux Enterprise
>> Desktop 10 kernel, though I can't recall what 2.6.x rev it is.  (I dual
>> boot winders and SLED and I'm in winders now)
>>
>> Is the CPU/mem subsystem in the server the cause of the 38% drop in
>> buffered read performance vs O_DIRECT, or does my custom kernel need
>> some work somewhere?  Can someone point me to some docs that explain why
>> the buffer cache on this system is putting such a clamp on buffered
>> sequential disk reads in hdparm compared to raw performance?
> 
> Not too sure about that one. It could be that the I/O pattern with
> buffered IO is somehow worse than with O_DIRECT, or that the CPU load is
> killing you somehow when using buffered IO.

I performed a little rudimentary testing and grabbed some data with batch top.
I'm hoping you experts can actually discern something from it better than I can.

/dev/sda:
 Timing buffered disk reads:  166 MB in  3.01 seconds =  55.15 MB/sec

Cpu0  :  0.0%us, 31.1%sy,  0.0%ni, 47.6%id, 18.4%wa,  1.0%hi,  1.9%si,  0.0%st
Cpu0  :  1.0%us, 29.4%sy,  0.0%ni, 52.0%id, 15.7%wa,  0.0%hi,  2.0%si,  0.0%st
Cpu0  :  1.0%us, 20.6%sy,  0.0%ni, 60.8%id, 14.7%wa,  1.0%hi,  2.0%si,  0.0%st

Cpu1  :  2.9%us, 25.0%sy,  0.0%ni, 43.3%id, 23.1%wa,  1.0%hi,  4.8%si,  0.0%st
Cpu1  :  2.0%us, 29.4%sy,  0.0%ni, 43.1%id, 22.5%wa,  0.0%hi,  2.9%si,  0.0%st
Cpu1  :  1.0%us, 36.3%sy,  0.0%ni, 40.2%id, 19.6%wa,  0.0%hi,  2.9%si,  0.0%st

Running dd gives slightly lower throughput than hdparm -t, but since it runs a
longer duration I can get a better quality grab of stats from top.

greer:/home/stan# dd if=/dev/sda of=/dev/null
1226017+0 records in
1226016+0 records out
627720192 bytes (628 MB) copied, 13.7097 s, 45.8 MB/s

Cpu0  :  8.8%us, 21.6%sy,  0.0%ni, 48.0%id, 17.6%wa,  0.0%hi,  3.9%si,  0.0%st
Cpu0  :  8.8%us, 21.6%sy,  0.0%ni, 49.0%id, 18.6%wa,  0.0%hi,  2.0%si,  0.0%st
Cpu0  : 11.9%us, 21.8%sy,  0.0%ni, 43.6%id, 22.8%wa,  0.0%hi,  0.0%si,  0.0%st
Cpu0  :  5.0%us, 20.8%sy,  0.0%ni, 62.4%id, 10.9%wa,  0.0%hi,  1.0%si,  0.0%st
Cpu0  :  5.9%us, 24.5%sy,  0.0%ni, 49.0%id, 19.6%wa,  0.0%hi,  1.0%si,  0.0%st
Cpu0  :  7.8%us, 21.6%sy,  0.0%ni, 52.9%id, 14.7%wa,  0.0%hi,  2.9%si,  0.0%st
Cpu0  :  6.9%us, 23.5%sy,  0.0%ni, 50.0%id, 18.6%wa,  0.0%hi,  1.0%si,  0.0%st
Cpu0  :  8.9%us, 19.8%sy,  0.0%ni, 52.5%id, 16.8%wa,  0.0%hi,  2.0%si,  0.0%st

Cpu1  :  8.8%us, 29.4%sy,  0.0%ni, 43.1%id, 18.6%wa,  0.0%hi,  0.0%si,  0.0%st
Cpu1  :  9.8%us, 27.5%sy,  0.0%ni, 47.1%id, 15.7%wa,  0.0%hi,  0.0%si,  0.0%st
Cpu1  :  8.8%us, 25.5%sy,  0.0%ni, 52.0%id, 13.7%wa,  0.0%hi,  0.0%si,  0.0%st
Cpu1  : 11.9%us, 37.6%sy,  0.0%ni, 32.7%id, 17.8%wa,  0.0%hi,  0.0%si,  0.0%st
Cpu1  :  5.0%us, 31.7%sy,  0.0%ni, 45.5%id, 17.8%wa,  0.0%hi,  0.0%si,  0.0%st
Cpu1  :  9.7%us, 27.2%sy,  0.0%ni, 41.7%id, 21.4%wa,  0.0%hi,  0.0%si,  0.0%st
Cpu1  :  9.8%us, 27.5%sy,  0.0%ni, 46.1%id, 16.7%wa,  0.0%hi,  0.0%si,  0.0%st
Cpu1  :  8.9%us, 30.7%sy,  0.0%ni, 42.6%id, 17.8%wa,  0.0%hi,  0.0%si,  0.0%st

For comparison here's the hdparm O_DIRECT run.  User space code time is almost
nil, as is kernel time.  I/O wait times are much higher.

/dev/sda:
 Timing O_DIRECT disk reads:  252 MB in  3.02 seconds =  83.46 MB/sec

Cpu0  :  2.0%us,  1.0%sy,  0.0%ni, 84.3%id, 12.7%wa,  0.0%hi,  0.0%si,  0.0%st
Cpu0  :  2.0%us,  2.9%sy,  0.0%ni, 43.1%id, 50.0%wa,  0.0%hi,  2.0%si,  0.0%st
Cpu0  :  2.9%us,  2.9%sy,  0.0%ni,  0.0%id, 91.2%wa,  1.0%hi,  2.0%si,  0.0%st
Cpu0  :  2.0%us,  2.9%sy,  0.0%ni, 58.8%id, 36.3%wa,  0.0%hi,  0.0%si,  0.0%st

Cpu1  :  0.0%us,  0.0%sy,  0.0%ni, 91.1%id,  8.9%wa,  0.0%hi,  0.0%si,  0.0%st
Cpu1  :  0.0%us,  1.0%sy,  0.0%ni, 54.9%id, 43.1%wa,  0.0%hi,  1.0%si,  0.0%st
Cpu1  :  0.0%us,  0.0%sy,  0.0%ni, 97.0%id,  0.0%wa,  0.0%hi,  3.0%si,  0.0%st
Cpu1  :  1.0%us,  2.0%sy,  0.0%ni, 62.7%id, 34.3%wa,  0.0%hi,  0.0%si,  0.0%st


Any ideas on how I can get the buffered read numbers up closer to the raw
numbers, currently ~50MB/s vs ~80MB/s?  Simultaneously lower the CPU consumption
during I/O?

I'm using kernel 2.6.31.1, compiled myself using kernel.org sources and 'make
menuconfig' on a Debian 5.0.3 system using gcc 4.3.2-2 with the default compiler
performance flags, whatever they are.

Thanks again for your continued patience and insight.

--
Stan
