From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: libata: CD and dvd devices not recognized
Date: Fri, 16 Mar 2007 23:06:24 +0800
Message-ID: <45FAB270.8090909@tw.ibm.com>
References: <45F873AC.6010204@gmail.com> <45F8C3E1.3080805@tw.ibm.com> <45F9460E.7020701@gmail.com> <45F98343.3060703@tw.ibm.com> <45FA6E8A.5070507@gmail.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:56934 "EHLO
	e33.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753217AbXCPPG4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 16 Mar 2007 11:06:56 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l2GF6tPu002749
	for <linux-ide@vger.kernel.org>; Fri, 16 Mar 2007 11:06:55 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l2GF6p7j064536
	for <linux-ide@vger.kernel.org>; Fri, 16 Mar 2007 09:06:53 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l2GF6poE025833
	for <linux-ide@vger.kernel.org>; Fri, 16 Mar 2007 09:06:51 -0600
In-Reply-To: <45FA6E8A.5070507@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: YUP <yupadmin@gmail.com>
Cc: albertl@mail.com, linux-ide@vger.kernel.org

YUP wrote:
> Hi Albert,
> 
>> 2. Turn off ATAPI DMA by adding one line of
>>      { "CD-ROM 56X/AKH", NULL,    ATA_HORKAGE_NODMA },
>>    to  ata_device_blacklist[] and see if it helps.
> 
> 
> Here is dmesg with blacklisted cdrom:
> 
> 
> 
> ------------------------------------------------------------------------
<snip>
> [   50.889690] eth0: no IPv6 routers present
> [   62.013082] ata2.01: qc timeout (cmd 0xa0)
> [   62.013098] ata2.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> [   62.013160] ata2.01: cmd a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x12 data 254 in
> [   62.013163]          res 51/51:03:00:12:00/00:00:00:00:00/b0 Emask 0x5 (timeout)
> [   69.002638] ata2: port is slow to respond, please be patient (Status 0xd8)
> [   91.984233] ata2: port failed to respond (30 secs, Status 0xd8)
> [   91.984292] ata2: soft resetting port
> [   92.151391] ATA: abnormal status 0x7F on port 0xE08515DF
> [   92.162767] ATA: abnormal status 0x7F on port 0xE08515DF
> [   92.323758] ata2.01: failed to IDENTIFY (I/O error, err_mask=0x1)
> [   92.323766] ata2.01: revalidation failed (errno=-5)
> [   92.323821] ata2: failed to recover some devices, retrying in 5 secs
> [   97.320272] ata2: soft resetting port
> [   97.487428] ATA: abnormal status 0x7F on port 0xE08515DF
> [   97.498808] ATA: abnormal status 0x7F on port 0xE08515DF
> [   97.660041] ata2.01: device is on DMA blacklist, disabling DMA
> [   97.823822] ata2.01: configured for PIO4
> [   97.823874] ata2: EH complete
> [  127.798684] ata2.01: qc timeout (cmd 0xa0)
> [  127.798702] ata2.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> [  127.798762] ata2.01: cmd a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x12 data 254 in
> [  127.798764]          res 51/51:03:00:12:00/00:00:00:00:00/b0 Emask 0x5 (timeout)


Hi Yarema,

The dmesg looks bad. The AOpen CD-956E/AKH doesn't work under PIO mode 4 either.
Device status 0x51 means "device error". The drive should interrupt the software to
report the error but it didn't and caused qc timeout eventually.

BTW, the problem only affect the ATAPI commands;
ATA commands (e.g. IDENTIFY PACKET DEVICE and set transfer mode) look fine.

I've checked some local forum about the AOpen CD-952E drive (close relative of CD-956E)
(http://www.arclink.com.tw/TopicProductList.do?p_id=495&page=2). It's said
that the AOpen 52x drives have quality issues and over-heat problem.
Some drive even stop working after 4-days of use.

So, I guess your AOpen 56x hardware is broken. If true, there is little hope we can
workaround it from the software.

Could you please check whether the IDE driver work for it? (Please configure the
IDE pdc202xx_new and deconfig the libata pata_pdc2027x driver, recompile/reboot
the kernel and try read some cd using the IDE driver.) Thanks.

--
albert



