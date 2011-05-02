From: "Asai Thambi Samymuthu Pattrayasamy (asamymuthupa) [CONTRACTOR]"
	<asamymuthupa@micron.com>
Subject: RE: New driver mtipx2xx submission
Date: Mon, 2 May 2011 06:40:31 -0600
Message-ID: <22A973199D2C2F46933448F6E7990A300204F728@ntxboimbx31.micron.com>
References: <22A973199D2C2F46933448F6E7990A300204F2BC@ntxboimbx31.micron.com> <20110428230605.78c55c70@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from masquerade.micron.com ([137.201.242.130]:51823 "EHLO
	masquerade.micron.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754250Ab1EBMkl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 2 May 2011 08:40:41 -0400
Content-class: urn:content-classes:message
In-Reply-To: <20110428230605.78c55c70@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

> The kernel starting point would be that we have an AHCI driver. If you
> need workarounds for hardware errata then they can go into it and that
is
> fine. We support NCQ so we can use the queue depths. If there are
> extensions then the AHCI driver can be enhanced.

We understand that AHCI driver can be patched for hardware errata and
other customizations, but main concern is performance.

> Similarly if you've got performnace problems going through the libata
> core and AHCI driver the right thing to do is to fix the performance
> problems in the core (or rewrite bits of the core as needed).

> I think the starting point would be to explain what problems you see
with
> the existing driver, and where the profiling tools say the bottlenecks
> are when you try and get full speed under libata + libata ahci driver.

The performance difference is not just because of libata + libata ahci
driver. Our driver gets the request before elevator comes into picture.
So, the stack starting from elevator,scsi upper, scsi mid, libata and
libata ahci driver attributes to the performance difference. 

> Otherwise we will end up with one AHCIish driver per vendor and it
turns
> into a nightmare for maintenance.

Regards,
Asai Thambi
