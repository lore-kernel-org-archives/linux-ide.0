From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 5/13] ATA ACPI: use debugging macros
Date: Tue, 28 Feb 2006 12:47:33 +0100
Message-ID: <20060228114733.GB4081@elf.ucw.cz>
References: <20060222133241.595a8509.randy_d_dunlap@linux.intel.com> <20060222135542.33fe242c.randy_d_dunlap@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:49124 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750882AbWB1Lty (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 28 Feb 2006 06:49:54 -0500
Content-Disposition: inline
In-Reply-To: <20060222135542.33fe242c.randy_d_dunlap@linux.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Randy Dunlap <randy_d_dunlap@linux.intel.com>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, akpm@osdl.org, jgarzik@pobox.com

On St 22-02-06 13:55:42, Randy Dunlap wrote:
> From: Randy Dunlap <randy_d_dunlap@linux.intel.com>
> 
> Add more libata-acpi debugging, plus controlled by libata.printk
> value.

Please don't. Instead select messages so that it is not too noisy by
default...
								Pavel

-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
