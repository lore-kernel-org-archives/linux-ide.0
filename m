From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] AHCI PCI ID for MacBook Pro
Date: Sat, 10 Feb 2007 12:10:17 -0500
Message-ID: <45CDFC79.1040301@gmail.com>
References: <82530.66623.qm@web25412.mail.ukl.yahoo.com>	 <200702091527.08447.rootkit85@yahoo.it>	 <1171032893.8134.13.camel@localhost>	 <200702091839.52316.rootkit85@yahoo.it>  <45CDD0CB.2070608@gmail.com> <1171123622.31813.9.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.182]:61321 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751393AbXBJRKi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 10 Feb 2007 12:10:38 -0500
Received: by py-out-1112.google.com with SMTP id a29so580792pyi
        for <linux-ide@vger.kernel.org>; Sat, 10 Feb 2007 09:10:37 -0800 (PST)
In-Reply-To: <1171123622.31813.9.camel@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Soeren Sonnenburg <sonne@nn7.de>
Cc: Matteo Croce <rootkit85@yahoo.it>, linux-ide@vger.kernel.org

Soeren Sonnenburg wrote:
> I don't get it. Why is it rejected then ? If I'd like to use the ahci
> mode of the ich7 r/m driver I just compile it into the kernel, else the
> piix ?!

Well, it's probably okay if you know what you want but when ich's are 
present, most distributions choose to load both ahci and ata_piix while 
usually preferring ahci.  That should generally work.  If BIOS didn't 
set it up properly, ahci will fail to load then ata_piix is loaded 
instead.  The thing is that BIOSen are weird and it's quite possible 
that switching to ahci mode might have other side effects.  For one, 
ACPI methods could have been written assuming certain mode and 
suspend/resume might choke if the controller is put into different mode 
from what BIOS has configured.

-- 
tejun
