From: Tejun Heo <htejun@gmail.com>
Subject: ATA ACPI needs "Mr interpreter, would you please shut up?" flag
Date: Fri, 14 Dec 2007 14:02:22 +0900
Message-ID: <47620E5E.5020001@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.177]:51940 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750708AbXLNFCc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 14 Dec 2007 00:02:32 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1510592wah.23
        for <linux-ide@vger.kernel.org>; Thu, 13 Dec 2007 21:02:31 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linux Kernel <linux-kernel@vger.kernel.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, linux-acpi@vger.kernel.org, Robert Hancock <hancockr@shaw.ca>, Jeff Garzik <jeff@gar>

Hello, all.

During 2.6.24-rc1, libata enabled ATA-ACPI support by default and there
have been a lot of regression reports stemming from it.  I have patchset
ready to fix most of the problems.  With these patches applied, libata
should be able to cope with most failures pretty well.  There is one
remaining issue tho.

libata caches the result of _GTM during controller for later use.  The
primary use is to peek at how BIOS configured the controller.  Some
controllers (pata_via and pata_amd) lack proper cable detection and BIOS
configured values are used as reference.  This caching is done before
any other operation is performed on the port to avoid caching corrupted
data.

Problem is that _GTM implementation on certain BIOSen crap themselves if
invoked on empty channels.  However, as written above, because initial
_GTM caching is done before any actual operation is performed on the
port, libata can't determine whether the port is occupied or not when
trying to cache _GTM result.  Unfortunately, VIA PATA is on both
categories - it needs _GTM caching but can't cope with _GTM invocation
on empty ports.  Yay!

libata doesn't need _GTM to succeed.  If the information can be
acquired, it will use it.  If not, it will do just fine without it and
for pata_via, this works perfectly well because the information is
available when actually needed (device present).  The only problem is
that _GTM evaluation failure will print ugly messages during boot.

We can twist ATA probing such that _GTM caching is done between device
detection but before mode is reset to PIO0 but I don't think that's a
good idea for two reasons.  1. That would require pushing PIO0
enforcement after reset.  IMHO, it's wiser to put controller into PIO0
before initiating reset.  2. Presence detection sometimes requires
actually issuing IDENTIFY DEVICE command which in turn needs PIO0
configuration.

So, I think the logical solution here is to tell ACPI interpreter that
the _GTM evaluation may fail and there's no need to alert the user about
that.  Maybe printing with KERN_DEBUG is good enough.  libata can print
additional message after failure (again w/ KERN_DEBUG) telling the user
that there's nothing to worry about.

Thanks.

-- 
tejun
