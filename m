From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [1/2] 2.6.22-rc7: known regressions
Date: Tue, 3 Jul 2007 19:50:26 +0200
Message-ID: <200707031950.27162.bzolnier@gmail.com>
References: <468A7D14.1050505@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <sparclinux-owner@vger.kernel.org>
In-Reply-To: <468A7D14.1050505@googlemail.com>
Content-Disposition: inline
Sender: sparclinux-owner@vger.kernel.org
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, reiserfs-devel@vger.kernel.org, "Vladimir V. Saveliev" <vs@namesys.com>, Randy Dunlap <randy.dunlap@oracle.com>, linux-ide@vger.kernel.org, David Chinner <dgc@sgi.com>, sparclinux@vger.kernel.org, David Miller <davem@davemloft.net>, Mikael Pettersson <mikpe@it.uu.se>, Mark Fortescue <mark@mtfhpc.demon.co.uk>, William Lee Irwin III <wli@holomorphy.com>
List-Id: linux-ide@vger.kernel.org


Hi,

On Tuesday 03 July 2007, Michal Piotrowski wrote:

> IDE
> 
> Subject    : 2.6.22-rcX: hda: lost interrupt
> References : http://lkml.org/lkml/2007/6/29/121
> Submitter  : David Chinner <dgc@sgi.com>
> Status     : unknown

David, any news on this one?

Have you tried libata as suggested by Jeff?

[ would exclude IRQ routing issue or broken hardware ]

Thanks,
Bart
