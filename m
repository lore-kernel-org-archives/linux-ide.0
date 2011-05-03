From: "Asai Thambi Samymuthu Pattrayasamy (asamymuthupa) [CONTRACTOR]"
	<asamymuthupa@micron.com>
Subject: [PATCH 0/3] RE: New driver mtipx2xx submission
Date: Tue, 3 May 2011 14:07:35 -0600
Message-ID: <22A973199D2C2F46933448F6E7990A300204FB7C@ntxboimbx31.micron.com>
References: <22A973199D2C2F46933448F6E7990A300204F2BC@ntxboimbx31.micron.com><20110428230605.78c55c70@lxorguk.ukuu.org.uk><22A973199D2C2F46933448F6E7990A300204F728@ntxboimbx31.micron.com> <20110502184206.25907c5e@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from masquerade.micron.com ([137.201.242.130]:24990 "EHLO
	masquerade.micron.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754781Ab1ECUHq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 May 2011 16:07:46 -0400
Content-class: urn:content-classes:message
In-Reply-To: <20110502184206.25907c5e@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

> > > I think the starting point would be to explain what problems you
see
> > with
> > > the existing driver, and where the profiling tools say the
bottlenecks
> > > are when you try and get full speed under libata + libata ahci
driver.
> > 
> > The performance difference is not just because of libata + libata
ahci
> > driver. Our driver gets the request before elevator comes into
picture.
> > So, the stack starting from elevator,scsi upper, scsi mid, libata
and
> > libata ahci driver attributes to the performance difference. 
>
> Elevator for flash devices should automatically be null and most of
the
> SCSI layer isn't actually used so it would be interesting to know for
> example what shows up in comparative profiles so that it can be
optimised
> or dropped out.

We are working on getting performance figures for both paths. Meanwhile,
I am reposting the new patch inline in 3 parts.
