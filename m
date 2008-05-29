From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] libata: Handle bay devices in dock stations
Date: Thu, 29 May 2008 14:32:01 +0100
Message-ID: <20080529133201.GA22476@srcf.ucam.org>
References: <20080528143857.GB5585@homac.suse.de> <20080529132253.GA22309@srcf.ucam.org> <20080529133302.GA9268@homac.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:42407 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752141AbYE2NcR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 29 May 2008 09:32:17 -0400
Content-Disposition: inline
In-Reply-To: <20080529133302.GA9268@homac.suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, linux-acpi@vger.kernel.org, akpm@linux-foundation.org

On Thu, May 29, 2008 at 03:33:02PM +0200, Holger Macht wrote:

> Can you please give a bit more details? Does your userspace react on the
> eject request? I tested with Thinkpads, too.

No, I'm not doing anything with userspace - just pulling the drive out 
directly. I'm looking into it now.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
