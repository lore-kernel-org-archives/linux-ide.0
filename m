From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] libata: Handle bay devices in dock stations
Date: Thu, 29 May 2008 15:35:41 +0100
Message-ID: <20080529143541.GA24013@srcf.ucam.org>
References: <20080528143857.GB5585@homac.suse.de> <20080529132253.GA22309@srcf.ucam.org> <483EB33D.6010101@gmail.com> <20080529140213.GA23373@srcf.ucam.org> <20080529141421.GC9268@homac.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:43664 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752210AbYE2OgD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 29 May 2008 10:36:03 -0400
Content-Disposition: inline
In-Reply-To: <20080529141421.GC9268@homac.suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, linux-acpi@vger.kernel.org, akpm@linux-foundation.org

On Thu, May 29, 2008 at 04:14:21PM +0200, Holger Macht wrote:
> On Thu 29. May - 15:02:13, Matthew Garrett wrote:
> > No, I'm seeing an identical hang. Mainline works fine.
> 
> Maybe you could also try this on top of Tejun's patch?

No luck there either, I'm afraid.
-- 
Matthew Garrett | mjg59@srcf.ucam.org
