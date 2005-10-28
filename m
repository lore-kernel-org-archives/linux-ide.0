From: thomas schorpp <t.schorpp@gmx.de>
Subject: Re: FW: hdparm ATA Security Options return errors
Date: Fri, 28 Oct 2005 22:54:43 +0200
Message-ID: <43629013.2070303@gmx.de>
References: <CA45571DE57E1C45BF3552118BA92C9D69BF0D@WDSCEXBECL03.sc.wdc.com>
Reply-To: t.schorpp@gmx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from imap.gmx.net ([213.165.64.20]:16585 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751706AbVJ1Uyr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 28 Oct 2005 16:54:47 -0400
In-Reply-To: <CA45571DE57E1C45BF3552118BA92C9D69BF0D@WDSCEXBECL03.sc.wdc.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

today i found out that latest ibm thinkpad t23 bios locked harddisc
(with ibm part number label) cant be unlocked by no other ata-security
software than ibm's bios (or special ibm service software)... :( anyone
knows these "non-standard"? or just a bug (padding 0's from MSB instead
LSB side into the passphrase frame)?

thinkpad sets high/maximum security, but at max no master passwort for
later erase command can be set in bios.

the other way round, if hdparm or tims hdsec sets security on the drive
connected to a desktop ibm bios cant unlock, too.

y
tom

Timothy Thelin wrote:
> Thanks for the update.  To unfreeze a drive you can power cycle it, but
> thats not going to be a viable solution for a production system.
> 
> Tim
> 
> 
>>-----Original Message-----
>>From: thomas schorpp [mailto:t.schorpp@gmx.de]
>>Sent: Thursday, October 27, 2005 12:02 PM
>>To: Timothy Thelin
>>Cc: linux-ide@vger.kernel.org; liml@rtr.ca
>>Subject: Re: FW: hdparm ATA Security Options return errors
>>
>>
>>ok tim. your app works, except that no maximum security can 
>>be set on my
>>old 20gb seagate (max supported) ata5 on kernel
>>2.6.13.4+passthrough...2.6.14-rc5-mm and drive status error 
>>handling is
>>incomplete and gives one false ok message after some command...
>>
>>hdparm works too now, must be an issue on unlocking with NULL 
>>password i
>>used for 1. test on the linux-ide list...
>>
>>tested with ata5-6 seagate/ibm desktop drives.
>>
>>enhanced erase not tested cause not supported by the drives.
>>
>>BTW: AMI Bios here freezes ata-security on at least ide0 PM drive on
>>power on without any option to turn freeze off, THATS NOT VERY NICE
>>cause this FORBIDS security use, i had to test on the sil680 
>>controller :(
>>
>>y
>>tom
>>
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
