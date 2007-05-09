From: Chuck Ebbert <cebbert@redhat.com>
Subject: Re: [PATCH] pci-quirks: disable MSI on RS400-200 and RS480, take
 #2
Date: Wed, 09 May 2007 11:37:09 -0400
Message-ID: <4641EAA5.4030409@redhat.com>
References: <4641BD26.1020501@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:54073 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754094AbXEIPhQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 9 May 2007 11:37:16 -0400
In-Reply-To: <4641BD26.1020501@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Greg K-H <greg@kroah.com>, Jeff Garzik <jeff@garzik.org>, linux-kernel <linux-kernel@vger.kernel.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, =?ISO-8859-1?Q?Mat=ED=ADas_Alejandro_Torres?= <torresmat@gmail.com>

Tejun Heo wrote:
> MSI doesn't work on RS400-200 and RS480 requiring pci=nomsi kernel
> boot parameter for ahci to work.  This patch renames quirk_svw_msi()
> to quirk_disable_all_msi() and use it to disable MSI on those chips.
> 
>   http://thread.gmane.org/gmane.linux.ide/17820
>   http://thread.gmane.org/gmane.linux.ide/17516
>   https://bugzilla.novell.com/show_bug.cgi?id=263893
> 

FWIW several distros have turned off MSI by default and added
a "pci=msi" option to enable it.


