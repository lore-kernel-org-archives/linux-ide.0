From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 4/13] ATA ACPI: add params/docs.
Date: Tue, 28 Feb 2006 12:46:47 +0100
Message-ID: <20060228114647.GA4081@elf.ucw.cz>
References: <20060222133241.595a8509.randy_d_dunlap@linux.intel.com> <20060222135403.55086107.randy_d_dunlap@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:49115 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751533AbWB1LtA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 28 Feb 2006 06:49:00 -0500
Content-Disposition: inline
In-Reply-To: <20060222135403.55086107.randy_d_dunlap@linux.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Randy Dunlap <randy_d_dunlap@linux.intel.com>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, akpm@osdl.org, jgarzik@pobox.com

Hi!

> From: Randy Dunlap <randy_d_dunlap@linux.intel.com>
> 
> Add and use 'noacpi' parameter for libata-acpi.

Why is this option needed? Either the code works, or it does not. If
it does not, it is not suitable for merging...
								Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
