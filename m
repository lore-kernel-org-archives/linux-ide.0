From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [COORDINATE] INIC-1620TA/1622TA2/1623TA2 SATA controllers from
 initio
Date: Fri, 1 Dec 2006 12:13:01 +0000
Message-ID: <20061201121301.6db615df@localhost.localdomain>
References: <43D646C2.6040104@gmail.com>
	<ekn6pj$9dt$1@sea.gmane.org>
	<456F7E17.6050301@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:46507 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030820AbWLAMGC (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 1 Dec 2006 07:06:02 -0500
In-Reply-To: <456F7E17.6050301@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Matthias Urlichs <matthias@urlichs.de>, linux-ide@vger.kernel.org

On Fri, 01 Dec 2006 09:57:59 +0900
Tejun Heo <htejun@gmail.com> wrote:

> Yeah, I saw that.  The problem with the driver is that it doesn't
> contain any license notice.  I'm not sure if it would be okay to read
> the driver and use the acquired info to implement GPL driver.  I asked
> sunix about it but got no useful answer.

Its clearly based on some of the GPL IDE controller code and blocks of it
are cut/pasted.

If you want to write the driver then I'm happy to write the description of
the device. It's basically an SFF device with MMIO on BAR5

Alan
