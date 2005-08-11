From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH] IDE: don't offer IDE_GENERIC on ia64
Date: Thu, 11 Aug 2005 14:37:46 -0600
Message-ID: <200508111437.46958.bjorn.helgaas@hp.com>
References: <200508111424.43150.bjorn.helgaas@hp.com> <20050811203437.GA9265@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from atlrel9.hp.com ([156.153.255.214]:57265 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S932432AbVHKUh4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 11 Aug 2005 16:37:56 -0400
In-Reply-To: <20050811203437.GA9265@infradead.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-ia64@vger.kernel.org

On Thursday 11 August 2005 2:34 pm, Christoph Hellwig wrote:
> On Thu, Aug 11, 2005 at 02:24:43PM -0600, Bjorn Helgaas wrote:
> > IA64 boxes only have PCI IDE devices, so there's no need to blindly poke
> > around in I/O port space.  Poking at things that don't exist causes MCAs
> > on HP ia64 systems.
> 
> Maybe it should instead depend on those systems where it is available.
> Anything but X86?

I'm OK with that, but don't want to be responsible for coming up
with the list of systems where it should be available :-)
