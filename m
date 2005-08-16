From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] IDE: don't offer IDE_GENERIC on ia64
Date: Tue, 16 Aug 2005 12:02:00 +0200
Message-ID: <58cb370e050816030248e6283c@mail.gmail.com>
References: <200508111424.43150.bjorn.helgaas@hp.com>
	 <20050811203437.GA9265@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nproxy.gmail.com ([64.233.182.201]:64807 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965181AbVHPKCB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 16 Aug 2005 06:02:01 -0400
Received: by nproxy.gmail.com with SMTP id x37so252813nfc
        for <linux-ide@vger.kernel.org>; Tue, 16 Aug 2005 03:02:00 -0700 (PDT)
In-Reply-To: <20050811203437.GA9265@infradead.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>, Bjorn Helgaas <bjorn.helgaas@hp.com>, B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-ia64@vger.kernel.org

On 8/11/05, Christoph Hellwig <hch@infradead.org> wrote:
> On Thu, Aug 11, 2005 at 02:24:43PM -0600, Bjorn Helgaas wrote:
> > IA64 boxes only have PCI IDE devices, so there's no need to blindly poke
> > around in I/O port space.  Poking at things that don't exist causes MCAs
> > on HP ia64 systems.
> 
> Maybe it should instead depend on those systems where it is available.
> Anything but X86?

Don't forget that arch specific drivers use IDE_GENERIC *indirectly*
to probe for devices.

Bartlomiej
