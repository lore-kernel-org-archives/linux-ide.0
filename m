From: "mike zheng" <mail4mz@gmail.com>
Subject: Re: FIS structure and Command List structure for AHCI SATA controller
Date: Fri, 9 Nov 2007 08:39:29 -0500
Message-ID: <5c9cd53b0711090539u79c1ba4fte46ee13f5906b42a@mail.gmail.com>
References: <5c9cd53b0711081938m1e752087yda930792a57a98c0@mail.gmail.com>
	 <20071109035506.GC25581@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.190]:10658 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754516AbXKINj3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Nov 2007 08:39:29 -0500
Received: by rv-out-0910.google.com with SMTP id k20so468423rvb
        for <linux-ide@vger.kernel.org>; Fri, 09 Nov 2007 05:39:29 -0800 (PST)
In-Reply-To: <20071109035506.GC25581@havoc.gtf.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org

Hi Jeff,

Actually I am using Marvell's 88SE6121 on kernel 2.4. I just wonder do
I have to enable the FIS? The SATA Command Table of the device have
following definitions:

00h Command FIS
40h ATAPI Command (CDB)
60h RSVD
80h Physical Region Descriptor Table

Does it mean I can only use FIS or ATAPI for this device?

Another confusion is the manual say that software should prepare the
command header, command FIS and the ATAPI command (CDB) for the ATAPI
command. Why it needs the FIS for ATAPI command?

Thanks for your help.

Mike

BTW, does anyone work on this device for kernel2.4?

On 11/8/07, Jeff Garzik <jeff@garzik.org> wrote:
> On Thu, Nov 08, 2007 at 10:38:25PM -0500, mike zheng wrote:
> > I am working on an AHCI SATA controller. For each port, there is one
> > FIS descriptor and one Command List, which points to a Received FIS
> > structure and Command List structure. So what is Received FIS
> > structure? The Command List structure points to Command Table, that
> > has Command FIS field and Physical Region Descriptor table. I assume
> > the Command table is used for the communication between processor and
> > the SATA controller. Then why do we need the Received FIS structure?
>
> The driver actually doesn't need it at all, though a few ideas are
> floating around for using it.
>
> However, it's required by the hardware by definition -- you must
> provide a buffer for incoming FIS's (P0FB), before enabling FIS
> reception (P0CMD bit 4, FRE).
>
> If I had to guess, the hardware dumps the RX FIS into host memory rather
> than having additional internal buffers/FIFOs...
>
>        Jeff
>
>
>
>
