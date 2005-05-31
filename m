From: Jeff Garzik <jgarzik@pobox.com>
Subject: libata dev guide updated
Date: Mon, 30 May 2005 20:54:35 -0400
Message-ID: <429BB5CB.2020708@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:59116 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261785AbVEaAym (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 30 May 2005 20:54:42 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>


Just made a run through the libata docs, updating them for the latest 
hooks and filling in missing details like locking/context documentation. 
I've been playing with lulu.com self-publishing, and published this 
newly updated libata Developer's Guide there as a short book (92 pages):
	http://www.lulu.com/content/130446

I think the muddy road on the front cover is apropos :)

This guide continues to be open source -- just run "make pdfdocs" in the 
kernel source tree.

A PDF of the book is available for free on lulu.com or at 
http://www.kernel.org/pub/linux/kernel/people/jgarzik/libata.pdf or by 
running "make pdfdocs" (or "make psdocs", "make htmldocs", ...).

The source code for the guide is in the kernel source tree, with new 
additions in the 'docs' branch of 
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git


