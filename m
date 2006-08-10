From: Andi Kleen <ak@suse.de>
Subject: Re: Merging libata PATA support into the base kernel
Date: 10 Aug 2006 08:24:27 +0200
Message-ID: <p733bc5nm5g.fsf@verdi.suse.de>
References: <1155144599.5729.226.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:39648 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1161079AbWHJGY2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 10 Aug 2006 02:24:28 -0400
In-Reply-To: <1155144599.5729.226.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org


Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
> - No support for host-protected-area yet

Even the support in the old one for that wasn't complete. It didn't
redo the HPA disabling on resume-from-ram, which made parts of the
disk not accessible anymore after wakeup. So at least on laptops it
always had to be disabled anyways.

-Andi
