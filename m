From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: 2.6.24-rc4-git5: Reported regressions from 2.6.23
Date: Sat, 8 Dec 2007 10:28:58 +0000
Message-ID: <20071208102858.GA12080@srcf.ucam.org>
References: <200712080340.49546.rjw@sisk.pl> <20071208013631.3147986a.akpm@linux-foundation.org> <20071208101256.GA25807@rhlx01.hs-esslingen.de> <20071208022001.155e0c52.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20071208022001.155e0c52.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andreas Mohr <andi@lisas.de>, "Rafael J. Wysocki" <rjw@sisk.pl>, LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, linux-ide@vger.kernel.org, Tejun Heo <htejun@gmail.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Sat, Dec 08, 2007 at 02:20:01AM -0800, Andrew Morton wrote:
> On Sat, 8 Dec 2007 11:12:57 +0100 Andreas Mohr <andi@lisas.de> wrote:
> > ACPI Exception (exoparg2-0442): AE_AML_PACKAGE_LIMIT, Index (0FFFFFFFF) is beyond end of object [20070126]
> > ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.IDE0.GTF_] (Node c180b990), AE_AML_PACKAGE_LIMIT
> > ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.IDE0.CHN0.DRV1._GTF] (Node c180b888), AE_AML_PACKAGE_LIMIT
> > ata1.01: _GTF evaluation failed (AE 0x300d)

037f6bb79f753c014bc84bca0de9bf98bb5ab169 ought to have fixed this?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
