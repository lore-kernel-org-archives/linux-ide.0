From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: pata_winbond doesn`t unregister from sysfs - bug?
Date: Fri, 4 Jan 2008 15:49:17 +0000
Message-ID: <20080104154917.6ba7c548@lxorguk.ukuu.org.uk>
References: <85735256@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:52990 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751825AbYADPu4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 4 Jan 2008 10:50:56 -0500
In-Reply-To: <85735256@web.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: devzero@web.de
Cc: linux-ide@vger.kernel.org, bzolnier@gmail.com

On Fri, 04 Jan 2008 14:52:25 +0100
devzero@web.de wrote:

> Hi, 
> 
> this looks like a bug to me (see below)
> happens on 2.6.24rc6 and i came across this by chance...
> 
> i`m here on notebook with vmware only, so i cannot test if this happens on real hardware, too.
> maybe someone can try "modprobe pata_winbond" twice and see if this is reproduceable....

Thanks - can you put this in bugzilla and assign it to me so it doesn't
get lost. That looks like the winbond driver isn't releasing resources
somewhere
