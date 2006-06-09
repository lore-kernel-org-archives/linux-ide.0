From: "zhao, forrest" <forrest.zhao@intel.com>
Subject: Re: Another project for you...  :)
Date: Fri, 09 Jun 2006 11:13:44 +0800
Message-ID: <1149822824.5721.16.camel@forrest26.sh.intel.com>
References: <1149751860.29552.79.camel@forrest26.sh.intel.com>
	 <44883BAE.7070406@pobox.com>
	 <1149820043.5721.7.camel@forrest26.sh.intel.com> <4488E6F6.10306@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:41535 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751327AbWFIDbt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 8 Jun 2006 23:31:49 -0400
In-Reply-To: <4488E6F6.10306@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: htejun@gmail.com, linux-ide@vger.kernel.org, randy_dunlap <rdunlap@xenotime.net>, Alan Cox <alan@lxorguk.ukuu.org.uk>

On Thu, 2006-06-08 at 23:11 -0400, Jeff Garzik wrote:
> Forrest,
> 
> BTW, if you are looking for useful libata projects, it would really be 
> nice to resurrect Randy Dunlap's SATA ACPI patches, update those for the 
> current libata-dev.git#upstream, and get those in.
> 
> libata needs to execute the SATA taskfiles passed to us from ACPI BIOS 
> tables, in order to properly set up the hard drive in a way the user 
> expects (hard drive password, acoustic settings, etc.).  There should be 
> a module option that allows the user to skip this step, and preserve 
> current behavior.

OK. I'll work on Randy's SATA ACPI patches first, then CCC.

> Also, a feature Alan requests on occasion:  Call the ATA "set max" 
> command to fully address the hard drive, including HPA.  The Linux 
> standard is to export the raw hardware directly, making 100% of the 
> hardware capability available to the user (and, in this case, 
> Linux-based BIOS and recovery tools).

I'll first study what this means, then start to work on it.

Jeff and Tejun,

Thank you very much for helping me get involved in libata development.
I'm very happy to make contribution to open source project :)

Best wishes,
Forrest
