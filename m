From: Andrew Morton <akpm@osdl.org>
Subject: Re: [Bugme-new] [Bug 6745] New: kernel hangs when trying to read
 atip wiith cdrecord
Date: Sun, 25 Jun 2006 04:37:02 -0700
Message-ID: <20060625043702.e7e2d20f.akpm@osdl.org>
References: <200606242036.k5OKaSvp031813@fire-2.osdl.org>
	<20060624144739.78bde590.akpm@osdl.org>
	<1151233643.4940.13.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:23471 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932380AbWFYLhJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 25 Jun 2006 07:37:09 -0400
In-Reply-To: <1151233643.4940.13.camel@laptopd505.fenrus.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Christian Lohmaier <lohmaier@gmx.de>

On Sun, 25 Jun 2006 13:07:23 +0200
Arjan van de Ven <arjan@infradead.org> wrote:

> On Sat, 2006-06-24 at 14:47 -0700, Andrew Morton wrote:
> > > I simply try to use "cdrecord dev=ATAPI:1,0,0 -atip" as root.
> 
> 
> one issue is that it's a lot better to use --dev=/dev/hda (or whatever
> your cdrom device is.. usually even /dev/cdrom or /dev/cdwriter will
> work, depends on your distro)... that is what most people use and that
> is the interface that's actively supported and debugged...

cc added.
