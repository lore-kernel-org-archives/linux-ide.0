From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 7/13] ATA ACPI: more Makefile/Kconfig
Date: Tue, 28 Feb 2006 12:49:15 +0100
Message-ID: <20060228114915.GC4081@elf.ucw.cz>
References: <20060222133241.595a8509.randy_d_dunlap@linux.intel.com> <20060222135802.60ab42ab.randy_d_dunlap@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:50404 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751591AbWB1LwI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 28 Feb 2006 06:52:08 -0500
Content-Disposition: inline
In-Reply-To: <20060222135802.60ab42ab.randy_d_dunlap@linux.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Randy Dunlap <randy_d_dunlap@linux.intel.com>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, akpm@osdl.org, jgarzik@pobox.com

On St 22-02-06 13:58:02, Randy Dunlap wrote:
> From: Randy Dunlap <randy_d_dunlap@linux.intel.com>
> 
> Simplify Makefile.
> Add Kconfig help.

Could you fold this with patch 1 of series? Introducing too complex
Makefile then fixing it makes review quite "interetsing". 

Is the config option really neccessary?
								Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
