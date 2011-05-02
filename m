From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: New driver mtipx2xx submission
Date: Mon, 2 May 2011 18:42:06 +0100
Message-ID: <20110502184206.25907c5e@lxorguk.ukuu.org.uk>
References: <22A973199D2C2F46933448F6E7990A300204F2BC@ntxboimbx31.micron.com>
	<20110428230605.78c55c70@lxorguk.ukuu.org.uk>
	<22A973199D2C2F46933448F6E7990A300204F728@ntxboimbx31.micron.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:34146 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751793Ab1EBRkz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 2 May 2011 13:40:55 -0400
In-Reply-To: <22A973199D2C2F46933448F6E7990A300204F728@ntxboimbx31.micron.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Asai Thambi Samymuthu Pattrayasamy (asamymuthupa) [CONTRACTOR]" <asamymuthupa@micron.com>
Cc: linux-ide@vger.kernel.org

On Mon, 2 May 2011 06:40:31 -0600
"Asai Thambi Samymuthu Pattrayasamy (asamymuthupa) [CONTRACTOR]"
<asamymuthupa@micron.com> wrote:

> > The kernel starting point would be that we have an AHCI driver. If you
> > need workarounds for hardware errata then they can go into it and that
> is
> > fine. We support NCQ so we can use the queue depths. If there are
> > extensions then the AHCI driver can be enhanced.
> 
> We understand that AHCI driver can be patched for hardware errata and
> other customizations, but main concern is performance.

Yes I understand that - but our main concern is maintainability, which
means one driver per AHCI flash vendor is a mess that isn't practicable
to deal with.

Documenting the errata would be a help anyway so we can get them into the
mainline AHCI driver, irrespective of what drivers we end up with
ultimately.

> > I think the starting point would be to explain what problems you see
> with
> > the existing driver, and where the profiling tools say the bottlenecks
> > are when you try and get full speed under libata + libata ahci driver.
> 
> The performance difference is not just because of libata + libata ahci
> driver. Our driver gets the request before elevator comes into picture.
> So, the stack starting from elevator,scsi upper, scsi mid, libata and
> libata ahci driver attributes to the performance difference. 

Elevator for flash devices should automatically be null and most of the
SCSI layer isn't actually used so it would be interesting to know for
example what shows up in comparative profiles so that it can be optimised
or dropped out.

Alan
