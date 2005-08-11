From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] IDE: don't offer IDE_GENERIC on ia64
Date: Thu, 11 Aug 2005 21:34:37 +0100
Message-ID: <20050811203437.GA9265@infradead.org>
References: <200508111424.43150.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ia64-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200508111424.43150.bjorn.helgaas@hp.com>
Sender: linux-ia64-owner@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-ia64@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Thu, Aug 11, 2005 at 02:24:43PM -0600, Bjorn Helgaas wrote:
> IA64 boxes only have PCI IDE devices, so there's no need to blindly poke
> around in I/O port space.  Poking at things that don't exist causes MCAs
> on HP ia64 systems.

Maybe it should instead depend on those systems where it is available.
Anything but X86?

