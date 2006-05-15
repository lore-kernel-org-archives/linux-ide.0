From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [RFT] major libata update
Date: Mon, 15 May 2006 14:06:55 -0400
Message-ID: <4468C33F.7070905@garzik.org>
References: <20060515170006.GA29555@havoc.gtf.org> <20060515101831.0e38d131.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:49091 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965066AbWEOSHB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 15 May 2006 14:07:01 -0400
In-Reply-To: <20060515101831.0e38d131.akpm@osdl.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, torvalds@osdl.org

Andrew Morton wrote:

We watch the bug reports, but try to get an overall picture rather than 
being good about updating each bugzilla tracker promptly :/  The 
tracking is quite useful though.


> http://bugzilla.kernel.org/show_bug.cgi?id=4920

not us

> http://bugzilla.kernel.org/show_bug.cgi?id=5533

addressed here

> http://bugzilla.kernel.org/show_bug.cgi?id=5586

sata_mv still considered highly experimental, as noted in Kconfig.  Bugs 
deferred to Mark Lord.

> http://bugzilla.kernel.org/show_bug.cgi?id=5589

funny looking backtrace, according to you

> http://bugzilla.kernel.org/show_bug.cgi?id=5798

worth looking into

> http://bugzilla.kernel.org/show_bug.cgi?id=5863

worth looking into, also worth testing with big update.

probable cause, the most recent ata_piix map value stuff.


> http://bugzilla.kernel.org/show_bug.cgi?id=4968

big update should help diagnose.  might need 'nv-adma' branch to fix.

> http://bugzilla.kernel.org/show_bug.cgi?id=5047

big update should help.

> http://bugzilla.kernel.org/show_bug.cgi?id=5905

big update should help, or at least help diagnose.

> http://bugzilla.kernel.org/show_bug.cgi?id=5596

ditto sata_mv info above.

> http://bugzilla.kernel.org/show_bug.cgi?id=5654

big update should help.

> http://bugzilla.kernel.org/show_bug.cgi?id=5664

should forward to NVIDIA for help debugging.  nv-adma branch may help 
diagnose.

> http://bugzilla.kernel.org/show_bug.cgi?id=5700

big update should help

> http://bugzilla.kernel.org/show_bug.cgi?id=5709

trivial patch submission

> http://bugzilla.kernel.org/show_bug.cgi?id=5721

dont care

> http://bugzilla.kernel.org/show_bug.cgi?id=5722

maybe a bug, probably weird drive or media, worth looking into

> http://bugzilla.kernel.org/show_bug.cgi?id=5922

should be using ahci driver

> http://bugzilla.kernel.org/show_bug.cgi?id=5789

include in the "atapi + via problems" bucket; bucket should be looked 
into... some people it works great, others not.  may need 
motherboard-specific (southbridge) tuning.

> http://bugzilla.kernel.org/show_bug.cgi?id=5931

big update will help

> http://bugzilla.kernel.org/show_bug.cgi?id=5969

probably just needs PCI IDs

> http://bugzilla.kernel.org/show_bug.cgi?id=5948

not libata?

> http://bugzilla.kernel.org/show_bug.cgi?id=5987

not libata

> http://bugzilla.kernel.org/show_bug.cgi?id=5995

big update + upcoming hotplug will fix.  until then, don't expect 
unplugging a drive to DTRT.

> http://bugzilla.kernel.org/show_bug.cgi?id=6173

need NVIDIA help.  maybe nv-adma branch will help diagnose.

> http://bugzilla.kernel.org/show_bug.cgi?id=6207

ditto

> http://bugzilla.kernel.org/show_bug.cgi?id=6240

investigate.  big update will help diagnose.

> http://bugzilla.kernel.org/show_bug.cgi?id=6253

big update should fix.

> http://bugzilla.kernel.org/show_bug.cgi?id=6260

waiting on SATA ACPI merge.

> http://bugzilla.kernel.org/show_bug.cgi?id=6272

big update should fix.

> http://bugzilla.kernel.org/show_bug.cgi?id=6283

investigate.  big update will help.

> http://bugzilla.kernel.org/show_bug.cgi?id=6311

big update should fix.

> http://bugzilla.kernel.org/show_bug.cgi?id=6317

big update may fix.

> http://bugzilla.kernel.org/show_bug.cgi?id=6346

not libata?

> http://bugzilla.kernel.org/show_bug.cgi?id=6470

new hardware, needs driver.

> http://bugzilla.kernel.org/show_bug.cgi?id=6056

bounce to NV

> http://bugzilla.kernel.org/show_bug.cgi?id=6494

waiting on SATA ACPI

> http://bugzilla.kernel.org/show_bug.cgi?id=6516

investigate, low priority

> http://bugzilla.kernel.org/show_bug.cgi?id=6521

big update should fix

