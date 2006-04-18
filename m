From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: [PATCH/RFC] libata: turn on the ATAPI DMADIR support per word
 62 (revised)
Date: Tue, 18 Apr 2006 12:34:52 +0800
Message-ID: <44446C6C.702@tw.ibm.com>
References: <CF6023AC-C62F-4BA8-A1DA-5CF6100B9608@verizon.net> <44360922.8050801@tw.ibm.com> <44360B05.6050509@garzik.org> <44363D2E.7010700@tw.ibm.com> <4436431C.8070800@tw.ibm.com> <4436A770.70107@garzik.org>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:63171 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S932204AbWDREfS
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 18 Apr 2006 00:35:18 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e32.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k3I4ZAM2002281
	for <linux-ide@vger.kernel.org>; Tue, 18 Apr 2006 00:35:10 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k3I4cVb9163712
	for <linux-ide@vger.kernel.org>; Mon, 17 Apr 2006 22:38:32 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k3I4Z6Bb029205
	for <linux-ide@vger.kernel.org>; Mon, 17 Apr 2006 22:35:07 -0600
In-Reply-To: <4436A770.70107@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, Jonathan Benson <airbatica@verizon.net>, Tejun Heo <htejun@gmail.com>, Carlos Pardo <Carlos.Pardo@siliconimage.com>, Doug Maxey <dwm@maxeymade.com>, Brian King <brking@us.ibm.com>

Jeff Garzik wrote:
> Albert Lee wrote:
> 
>> Turn on the ATAPI DMADIR support if word 62 indicates it.
>>
>> Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
>> ---
>> (Revised to add mwdma/udma mask of word 62 per Jeff's comments.
>> Need more testing once I get the SiI 3811, etc.)
>>
>> ATAPI DMADIR follow-up patch to turn on the DMADIR support automatically
>> by checking identify device word 62. (Thanks for Jeff and Tejun's
>> pointer.)
>>
>> According to Jonathan's test result, SiI 3611 (the current known
>> bridge that
>> requires the ATAPI DMADIR support) doesn't implement word 62. So, the
>> atapi_dmadir parameter is preserved to enable the DMA DIR support
>> manually as
>> work around.
>>
>> Patch against upstream (c2a6585296009379e0f4eff39cdcb108b457ebf2).
>> For your review, thanks.
> 
> 
> I ACK the patch, though like I said, I would like to see this tested
> first with some compliant devices.
> 

I've collected/tested most of the PATA-to-SATA bridges, none of them 
implements the word 62 behavior as defined in ATA-7.
So, maybe we don't need the word 62 patch at this moment.
(And I guess few vendor is going to implement it in the future:
depending on host software for the DMA direction isn't too backward
compatible with old host software.)

The following are test results:
(Tested with SiI 3112 SATA adapter + LITEON SOHR-5238S CD-RW drive.)

1. SiI 3611:
   - ATAPI DMA supported (DMADIR needed)
   - id[62] == 0
   - IDENTIFY PACKET DEVICE unchanged

2. SiI 3811:
   There is a jumper on board. When the jumper installed (default),
   DMADIR is not needed.
   - ATAPI DMA supported (DMADIR not needed)
   - id[62] == 0
   - IDENTIFY PACKET DEVICE unchanged

   When the jumper is removed, SiI 3811 behaves like SiI 3611
   and needs the DMADIR bit for ATAPI DMA to work.

3. Marvell 88i8030:
   - ATAPI not supported. Device timeout on probe.

4. Marvell 88SA8040:
   - ATAPI DMA supported (DMADIR not needed)
   - id[62] == 0
   - IDENTIFY PACKET DEVICE unchanged

5. Marvell 88SA8050:
   - Not tested

6. Acard ARC770:
   - ATAPI DMA supported (DMADIR not needed)
   - id[62] == 0
   - IDENTIFY PACKET DEVICE mangled to report "no MWDMA support".
     (UDMA is supported.)

7. JMicron JM20330:
   - ATAPI DMA supported (DMADIR not needed)
   - id[62] == 0
   - IDENTIFY PACKET DEVICE mangled. id[76] == 0x0202 id[78] == 0008.
     (Don't know why yet. Maybe device signature?)

Summary:
  SiI 3611 is currently the only known chip that needs DMADIR.
Since SiI 3611 doesn't implement the ATA-7 word 62 or mangle identify
packet device data, it's hard to check the chip and turn on the DMADIR
support automatically. (Currently the libata DMADIR support can be 
turned on manually by module parameter.)

To turn on the DMADIR support automatically, maybe we can check whether
the ATAPI device is bridged (by ata_dev_knobble()). If bridged, we can
try to issue a ATAPI DMA read command to check if ATAPI DMA works.
If not work, then try turning on DMADIR or turn off ATAPI DMA.
--
albert
     

