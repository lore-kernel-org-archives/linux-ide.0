From: Jeff Garzik <jeff@garzik.org>
Subject: Re: 2.6.25-mm1 (no disks with sata_nv)
Date: Sat, 26 Apr 2008 22:55:47 -0400
Message-ID: <20080427025547.GC24710@havoc.gtf.org>
References: <29495f1d0804261912k584cb68p36f4b9e5401afbb8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.61.125.42]:43718 "EHLO havoc.gtf.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753165AbYD0Czs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 26 Apr 2008 22:55:48 -0400
Content-Disposition: inline
In-Reply-To: <29495f1d0804261912k584cb68p36f4b9e5401afbb8@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Nish Aravamudan <nish.aravamudan@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, Apr 26, 2008 at 07:12:58PM -0700, Nish Aravamudan wrote:
> 
> While trying to test the hugepage changes pending for -mm, I found
> that none of my 4 disks attached to
> 
> nVidia Corporation CK804 Serial ATA Controller (rev f3)
> 
> come up (and thus I am dropped to an initramfs shell). The driver is
> loading and indicates a link up on all 4 ports that are involved, but
> I see no sd/sdX messages like I do with 2.6.25 (which I'm using right
> now). I've started the bisection, but if Jeff or anyone has any ideas,
> I'd appreciate it. I don't have a serial console on this box, and no
> oops is produced. .configs from 2.6.25 and 2.6.25-mm1 attached.

Should be fixed in upstream, so I presume it will appear when Andrew
next updates his kernel to the latest upstream.

	Jeff



