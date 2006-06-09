From: Jeff Garzik <jgarzik@pobox.com>
Subject: Another project for you...  :)
Date: Thu, 08 Jun 2006 23:11:50 -0400
Message-ID: <4488E6F6.10306@pobox.com>
References: <1149751860.29552.79.camel@forrest26.sh.intel.com>	 <44883BAE.7070406@pobox.com> <1149820043.5721.7.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:21988 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965115AbWFIDL4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Jun 2006 23:11:56 -0400
In-Reply-To: <1149820043.5721.7.camel@forrest26.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "zhao, forrest" <forrest.zhao@intel.com>
Cc: htejun@gmail.com, linux-ide@vger.kernel.org, randy_dunlap <rdunlap@xenotime.net>, Alan Cox <alan@lxorguk.ukuu.org.uk>

Forrest,

BTW, if you are looking for useful libata projects, it would really be 
nice to resurrect Randy Dunlap's SATA ACPI patches, update those for the 
current libata-dev.git#upstream, and get those in.

libata needs to execute the SATA taskfiles passed to us from ACPI BIOS 
tables, in order to properly set up the hard drive in a way the user 
expects (hard drive password, acoustic settings, etc.).  There should be 
a module option that allows the user to skip this step, and preserve 
current behavior.


Also, a feature Alan requests on occasion:  Call the ATA "set max" 
command to fully address the hard drive, including HPA.  The Linux 
standard is to export the raw hardware directly, making 100% of the 
hardware capability available to the user (and, in this case, 
Linux-based BIOS and recovery tools).

	Jeff



