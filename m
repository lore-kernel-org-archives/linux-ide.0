From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RFC] Read/Write Buffer support
Date: Sat, 15 Mar 2008 23:09:49 +0000
Message-ID: <20080315230949.785decfb@the-village.bc.nu>
References: <20080315153730.GX613@parisc-linux.org>
	<47DC04CD.7060209@garzik.org>
	<20080315174929.GY613@parisc-linux.org>
	<47DC5223.6080105@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:34017 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752367AbYCOXbs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 15 Mar 2008 19:31:48 -0400
In-Reply-To: <47DC5223.6080105@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Matthew Wilcox <matthew@wil.cx>, linux-ide@vger.kernel.org

> You arrived at the proper conclusion -- it doesn't happen in practice 
> for a variety of reasons, the main one being that it's largely in the 
> realm of something the superuser must do intentionally, the way kernel 
> and userland code is written today.

Actually thats a serious privilege escalation as it gets you from raw
disk access to cap_sys_rawio so its a security flaw and should be treated
as such even though it is only a minor one in most operating contexts.

Alan
