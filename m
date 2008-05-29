From: Holger Macht <hmacht@suse.de>
Subject: Re: [PATCH] libata: Handle bay devices in dock stations
Date: Thu, 29 May 2008 18:32:02 +0200
Message-ID: <20080529163201.GA4520@homac>
References: <20080528143857.GB5585@homac.suse.de> <20080529132253.GA22309@srcf.ucam.org> <483EB33D.6010101@gmail.com> <20080529140213.GA23373@srcf.ucam.org> <20080529141421.GC9268@homac.suse.de> <20080529143541.GA24013@srcf.ucam.org> <483EBFC5.7020406@gmail.com> <20080529144934.GA24382@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:59310 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755172AbYE2Q3S (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 29 May 2008 12:29:18 -0400
Content-Disposition: inline
In-Reply-To: <20080529144934.GA24382@srcf.ucam.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Tejun Heo <htejun@gmail.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, linux-acpi@vger.kernel.org, akpm@linux-foundation.org

On Thu 29. May - 15:49:34, Matthew Garrett wrote:
> Got it. It works if I lose the ata_port_freeze() from 
> ata_acpi_detach_device. 

Tejun, any idea? This is in for quite some time now. Maybe there's some
involved...

Regards,
	Holger

