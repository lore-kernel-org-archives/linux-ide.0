From: Tejun Heo <htejun@gmail.com>
Subject: Re: 2.6.20-git10 (and -git13): BUG at drivers/pci/pci.c:817 during
 resume from disk
Date: Tue, 20 Feb 2007 12:43:41 +0900
Message-ID: <45DA6E6D.5030700@gmail.com>
References: <200702150016.24865.rjw@sisk.pl> <200702151223.44846.rjw@sisk.pl> <200702171100.39114.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.232]:54725 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965646AbXBTDnp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Feb 2007 22:43:45 -0500
Received: by nz-out-0506.google.com with SMTP id s1so1838297nze
        for <linux-ide@vger.kernel.org>; Mon, 19 Feb 2007 19:43:45 -0800 (PST)
In-Reply-To: <200702171100.39114.rjw@sisk.pl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-ide@vger.kernel.org, Andrew Morton <akpm@osdl.org>, Jeff Garzik <jeff@garzik.org>, Alan <alan@lxorguk.ukuu.org.uk>, LKML <linux-kernel@vger.kernel.org>

Rafael J. Wysocki wrote:
> Update:
> 
> I get the same BUG with 2.6.20-git13 100% of the time during the resume.
> The system seems to be fully functional nonetheless.

Known bug, will be fixed soon.

-- 
tejun
