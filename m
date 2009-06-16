From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: SATA: link online but device misclassified
Date: Tue, 16 Jun 2009 15:21:36 +0000
Message-ID: <1245165697.3965.40.camel@mulgrave.site>
References: <cfa4e840906101715r56b643f4tab58e1c859d119ba@mail.gmail.com>
	 <4A308798.6060803@gmail.com>
	 <cfa4e840906110231u4e90eb22wbeb2d4e748c5624a@mail.gmail.com>
	 <1244746872.3998.88.camel@mulgrave.site>
	 <cfa4e840906111232i52decee3mf9ab2d0abcaa78d9@mail.gmail.com>
	 <cfa4e840906160759m31db333cr555104ca0e3c6255@mail.gmail.com>
	 <cfa4e840906160803h3364ac8aqfd78405dbcc512df@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:35852 "EHLO
	bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753054AbZFPPVi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 16 Jun 2009 11:21:38 -0400
In-Reply-To: <cfa4e840906160803h3364ac8aqfd78405dbcc512df@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marc Bowes <marcbowes@gmail.com>
Cc: linux-ide@vger.kernel.org

On Tue, 2009-06-16 at 17:03 +0200, Marc Bowes wrote:
> Sorry to bother, but this is really bugging me! I can't seem to find anybody
> else with the same problem. What steps should I be taking to figure this
> out? I'm thinking I should be trying other kernel versions and/or plugging
> drives in different places. I don't think the motherboard is faulty, and I
> seem to be getting good speeds (~70mbs) to all four drives.

Well, those are on the AHCI built in controller. The one with the slow
response is the empty JMicron 20360/20363.  But why this should be so,
I've no idea ... it looks like the AHCI driver can't tell the phys are
empty for some reason, which could be due to many things.

James


