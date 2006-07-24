From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: tighten ATA kconfig dependancies
Date: Mon, 24 Jul 2006 04:05:02 +0100
Message-ID: <1153710303.2380.3.camel@localhost>
References: <20060715053418.GA5557@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:46056 "EHLO
	out.lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S964791AbWGYQhD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 25 Jul 2006 12:37:03 -0400
In-Reply-To: <20060715053418.GA5557@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dave Jones <davej@redhat.com>
Cc: linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>

On Sad, 2006-07-15 at 01:34 -0400, Dave Jones wrote:
> A lot of prehistoric junk shows up on x86-64 configs.

This is the old IDE layer, this isn't a bugfix or urgent so it isnt
appropriate for merging. It also makes testing and building more awkward
for maintainers.

This is the same policy we follow elsewhere in the kernel, filter stuff
that can't compile not general PCI stuff.

NAK


