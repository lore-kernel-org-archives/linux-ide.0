From: Soeren Sonnenburg <kernel@nn7.de>
Subject: Re: seagate disks on sil3114 - slow?
Date: Sat, 27 Oct 2007 07:21:02 +0200
Message-ID: <1193462462.7122.7.camel@localhost>
References: <1192683290.5720.38.camel@localhost>
	 <4716EA25.7060205@garzik.org> <1192697546.5720.51.camel@localhost>
	 <472151D3.6060403@gmail.com> <1193377777.5984.13.camel@localhost>
	 <47218442.4000103@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nn7.de ([85.214.94.156]:50596 "EHLO nn7.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751300AbXJ0FV1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 27 Oct 2007 01:21:27 -0400
In-Reply-To: <47218442.4000103@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

On Fri, 2007-10-26 at 15:08 +0900, Tejun Heo wrote:
> Soeren Sonnenburg wrote:
> > On Fri, 2007-10-26 at 11:32 +0900, Tejun Heo wrote:
> [...]
> > OK I knew that one... about 50-60M/s - sounds reasonable, but if I
> > understand the m15w problem correctly it can only be triggered on
> > writes...
> 
> 3114 -> no m15w problem and m15w doesn't slow down transfers.  It locks
> up certain drives.  What slows down transfers is workaround for m15w.

Which means Bernd's sil3114 m15w patch does not fix anything but maybe
just lowered pci-bus load. Well....

Soeren
