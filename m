From: Philip Armstrong <phil@kantaka.co.uk>
Subject: Re: Bug#289770: kernel-image-2.6.10-1-686: 2.6.10 fails to set up DMA on my IBM thinkpad
Date: Thu, 10 Feb 2005 20:08:46 +0000
Message-ID: <20050210200846.GB28238@kantaka.co.uk>
References: <20050111195345.GI2618@stro.at> <20050112120245.GA24839@kantaka.co.uk> <200501121352.33520.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Received: from dsl-217-155-153-11.zen.co.uk ([217.155.153.11]:61133 "EHLO
	217.155.153.11") by vger.kernel.org with ESMTP id S261653AbVBJUIr
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 10 Feb 2005 15:08:47 -0500
Content-Disposition: inline
In-Reply-To: <200501121352.33520.bzolnier@elka.pw.edu.pl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Cc: maximilian attems <debian@sternwelten.at>, linux-ide@vger.kernel.org, 289770@bugs.debian.org

On Wed, Jan 12, 2005 at 01:52:33PM +0100, Bartlomiej Zolnierkiewicz wrote:
>Further investigation reveals that turning off CONFIG_PNPBIOS solves
>the problem.

Addendum:

# diff 2.6.10/ioports nopnp/ioports
10a11
> 0100-013f : pcmcia_socket0
12,13d12
< 0200-0207 : ns558-pnp
< 03bc-03be : parport0
16,17d14
< 03f8-03ff : serial
< 04d0-04d1 : pnp 00:0a
20d16
< 15e0-15ef : pnp 00:0a
31c27
<   fcf8-fcff : pnp 00:1c
---
>   fcf0-fcf7 : ide0

(The nopnp kernel doesn't have the ns558 joystick driver compiled in)

cheers,

Phil

-- 
http://www.kantaka.co.uk/ .oOo. public key: http://www.kantaka.co.uk/gpg.txt
