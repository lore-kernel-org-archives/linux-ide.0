From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 0/3] SATA: Fine-tuning for two function implementations
Date: Thu, 11 May 2017 17:01:34 +0200
Message-ID: <3428511.iH6kg31xz3@amdc3058>
References: <df754c7a-2100-7169-0d40-b981ccd952a1@users.sourceforge.net>
 <20170428215334.GH22354@htj.duckdns.org>
 <CGME20170511150136epcas5p4549f5ae51303ef506c0f7f91b5dd1317@epcas5p4.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20170428215334.GH22354@htj.duckdns.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: SF Markus Elfring <elfring@users.sourceforge.net>, linux-ide@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-ide@vger.kernel.org


Hi,

On Friday, April 28, 2017 05:53:34 PM Tejun Heo wrote:
> Hello,
> 
> On Tue, Apr 18, 2017 at 10:00:37PM +0200, SF Markus Elfring wrote:
> > From: Markus Elfring <elfring@users.sourceforge.net>
> > Date: Tue, 18 Apr 2017 21:54:32 +0200
> > 
> > A few update suggestions were taken into account
> > from static source code analysis.
> 
> Hmmm, allocs -> callocs.  Are these actually beneficial?  If so, why?
> Because one multiplication is rolled into the call?

Each conversion (i.e. I tried the one from patch #1) seems to add
an extra 24 bytes to the resulting code size (using gcc 4.8.4 for
ARM32 cross-compilation) so I don't see much point in the automatic
conversions. Only instances containing size calculations with
real possibility for integer overflows should be converted and
the patchset under discussion contains no such instances.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
