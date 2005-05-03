From: "Oskar Liljeblad" <oskar@osk.mine.nu>
Subject: Re: clock drift with two Promise Ultra133 TX2 (PDC 20269) cards
Date: Tue, 3 May 2005 19:28:46 +0200
Message-ID: <20050503172845.GA12944@oskar>
References: <66F9227F7417874C8DB3CEB05772741704514D@MILEX0.Miltope.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from diadema.skane.tbv.se ([193.13.139.13]:33182 "EHLO
	diadema.skane.tbv.se") by vger.kernel.org with ESMTP
	id S261441AbVECR2s (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 3 May 2005 13:28:48 -0400
Content-Disposition: inline
In-Reply-To: <66F9227F7417874C8DB3CEB05772741704514D@MILEX0.Miltope.local>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Drew Winstel <DWinstel@Miltope.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Tuesday, May 03, 2005 at 11:53, Drew Winstel wrote:
> I think I know what the problem is.
> 
> In include/linux/libata.h, make sure the preprocessor declarations are as 
> follows.  I think the defaults have ATA_ENABLE_PATA undefined.
> 
> #define ATA_ENABLE_ATAPI        /* undefine to disable ATAPI support */
> #define ATA_ENABLE_PATA          /* define to enable PATA support in some
>                                  * low-level drivers */

Thanks, now it loads correctly. Unfortunately the clock drift still occurs
with pata_pdc2027x. I'm guessing here, but can clock drift have anything
to do with IRQs? Also, is it normal to see errors in /proc/interrupt?

# cat /proc/interrupts 
           CPU0       
  0:     954189          XT-PIC  timer
  2:          0          XT-PIC  cascade
  8:         16          XT-PIC  rtc
  9:          0          XT-PIC  acpi
 10:       1630          XT-PIC  eth1
 11:     103147          XT-PIC  libata
 12:       9990          XT-PIC  eth0
 14:       5993          XT-PIC  ide0
 15:     145866          XT-PIC  libata
NMI:          0 
LOC:          0 
ERR:      23672
MIS:          0

Regards,

Oskar Liljeblad (oskar@osk.mine.nu)
