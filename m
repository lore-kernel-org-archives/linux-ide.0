From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: libata & scsi rescan.
Date: Fri, 01 Oct 2004 15:30:06 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <415DB03E.5090005@pobox.com>
References: <20041001123951.A23006@florence.linkmargin.com> <415DA2C0.3060600@pobox.com> <20041001141244.B23006@florence.linkmargin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:20154 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266243AbUJATaU
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 1 Oct 2004 15:30:20 -0400
In-Reply-To: <20041001141244.B23006@florence.linkmargin.com>
List-Id: linux-ide@vger.kernel.org
To: Andy Warner <andyw@pobox.com>
Cc: linux-ide@vger.kernel.org

Andy Warner wrote:
> Jeff Garzik wrote:
> 
>>[...]
>>I don't see why rescan is needed, since SATA hardware supports hotplug.
> 
> 
> OK - but at present, I can remove a quiescent drive
> and /proc/scsi/scsi still serves up the cached info
> about the drive.

That's because libata doesn't call the proper hot-unplug hooks.  Call 
those hooks, and the problem goes away.

	Jeff


