From: Johny A <kernel@agotnes.com>
Subject: Re: SATA_SX4: data corruption with simultaneous writes
Date: Sun, 06 Feb 2005 22:04:54 +1000
Message-ID: <420607E6.5060900@agotnes.com>
References: <41D3A15C.5050809@agotnes.com> <41E08A4B.5090400@agotnes.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040908070109000308000201"
Received: from munin.agotnes.com ([202.173.149.60]:43392 "EHLO
	mail.agotnes.com") by vger.kernel.org with ESMTP id S261193AbVBFMFP
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 6 Feb 2005 07:05:15 -0500
In-Reply-To: <41E08A4B.5090400@agotnes.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk

This is a multi-part message in MIME format.
--------------040908070109000308000201
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jeff et al,

I'd appreciate if you'd apply the attached patch to the Kconfig file as 
it may well save people with an SX4 rather a lot of time. It'd be 
fantastic if it made the patchset for 2.6.11 which I see you're busy 
preparing.

Thanks!

:)Johny

Johny A wrote:
> Guys,
> 
> Sorry to be a pain, wee bump for this note. In particular, if there is 
> no time to fix this issue now could a wee note be added to the driver 
> (in the docs, or possibly in the kernel log) stating that it is 
> potentially dangerous to use this card with the current crop of kernels?
> 
> I'm still happy to help with testing and debugging, but as stated 
> before, a couple of hints and pointers would be required :)
> 
> Thanks for listening!
> 
> :)Johny
> 
> Johny A wrote:
> 
>> Jeff et al,
>>
>> I found this one on the mailing-list;
>> http://marc.theaimsgroup.com/?l=linux-ide&m=109749133709795&w=2
>>
>> and have the same issues as described there, and also in the previous 
>> mails in this thread.
>>
>> The difference is, I can reproduce this with the simplest possible setup;
>>
>> I have an older Asus Mobo with an AMD1.33GHz CPU,
>> 1 Promise SX4 SATA controller (0000:00:0a.0 RAID bus controller: 
>> Promise Technology, Inc.: Unknown device 6622 (rev 01))
>> 2 Seagate  ST380817AS, Rev: 3.42 (80 GB SATA) disks
>>
>> Disks each have 1 large partition with ext2 on them.
>>
>> 1. I boot off a Gentoo LiveCD  running 2.6.9
>> 2. I scp over some 180 MB simultaneously to the two disks across the 
>> network, one shell copying to 1 disk only
>> 3. Unzip the .bz2 and .gz files just copied the files, again 1 shell 
>> working on each disk (no cross disk stuff going on at all).
>>
>> Typically, within a few minutes at most of the unzipping starting I 
>> get CRC errors on the files. No errors in dmesg necessarily. Sometimes 
>> I get errors unzipping - unmount the drive and run fsck which reports 
>> no errors - very insidious!
>>
>> I'd like the card to work - hey, I got one! and am willing to use my 
>> setup for testing of new driver versions. I'm useful with C, but not a 
>> kernel hacker, give me pointers to what needs done and I'll get it 
>> done, no worries...
>>
>> Let me know if I can help getting this thing fixed!
>>
>> Thanks,
>>
>> Johny A
>>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

--------------040908070109000308000201
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

--- a/drivers/scsi/Kconfig	2005-02-06 21:58:45.823674543 +1000
+++ b/drivers/scsi/Kconfig	2005-02-06 21:58:47.888341520 +1000
@@ -455,6 +455,10 @@
 	help
 	  This option enables support for Promise Serial ATA SX4.
 
+	  This driver is experimental and issues have been raised on linux-ide
+	  stating that data corruption may occur when running with multiple
+	  disks on this controller.
+
 	  If unsure, say N.
 
 config SCSI_SATA_SIL

--------------040908070109000308000201--
