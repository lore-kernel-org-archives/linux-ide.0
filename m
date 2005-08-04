From: Christoph Lameter <christoph@lameter.com>
Subject: Re: [patch] ide: fix kmalloc_node breakage in ide driver
Date: Wed, 3 Aug 2005 18:31:03 -0700 (PDT)
Message-ID: <Pine.LNX.4.62.0508031830440.25755@graphe.net>
References: <20050804012657.GA3542@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from graphe.net ([209.204.138.32]:27346 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S261732AbVHDBbO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 3 Aug 2005 21:31:14 -0400
In-Reply-To: <20050804012657.GA3542@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Cc: Andrew Morton <akpm@osdl.org>, shai@scalex86.org, linux-kernel@vger.kernel.org, ak@suse.de, linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

On Wed, 3 Aug 2005, Ravikiran G Thirumalai wrote:

> Machines with ide-interfaces which do not have pci devices are crashing on boot
> at pcibus_to_node in the ide drivers.  We noticed this on a x445 running
> 2.6.13-rc4.  Similar issue was discussed earlier, but the crash was due 
> to hwif being NULL.
> http://marc.theaimsgroup.com/?t=112075352000003&r=1&w=2
> Andi and Christoph had patches, but neither went in.  Here's one of those
> patches with an added BUG_ON(hwif == NULL).  Please include.

This needs to go into 2.6.13.

