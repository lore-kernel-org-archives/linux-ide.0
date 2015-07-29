From: Joerg Roedel <joro@8bytes.org>
Subject: Re: Since Linux 4.1: A lot of AMD-Vi IO_PAGE_FAULTs
Date: Wed, 29 Jul 2015 17:22:08 +0200
Message-ID: <20150729152208.GS10969@8bytes.org>
References: <55AE5F84.5020204@01019freenet.de>
 <1437492886.1391.847.camel@redhat.com>
 <20150721155635.GE10969@8bytes.org>
 <55AE7147.7070902@maya.org>
 <20150721163517.GG10969@8bytes.org>
 <55B1BDA3.3030507@maya.org>
 <CAErSpo666MBxpDe+uPvfVc7LPJsJQsVTusBhHygtwbou5GGj1w@mail.gmail.com>
 <55B27CEB.6010007@maya.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55B27CEB.6010007@maya.org>
Sender: linux-pci-owner@vger.kernel.org
To: Andreas Hartmann <andihartmann@freenet.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Alex Williamson <alex.williamson@redhat.com>, linux-pci <linux-pci@vger.kernel.org>, iommu <iommu@lists.linux-foundation.org>, Tejun Heo <tj@kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

Hi Andreas,

On Fri, Jul 24, 2015 at 07:59:07PM +0200, Andreas Hartmann wrote:
> New information: During testing, I now realized that Linux 4.0.9 shows
> the same problem ... . I'm now testing 3.19.4.

Have you seen the issue on 3.19 too or hasn't it happened there at all
yet? The question is where to look for a commit that breaks it on  your
machine.


	Joerg
