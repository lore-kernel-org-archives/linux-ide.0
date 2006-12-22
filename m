From: rabbit@rabbit.us (Peter Rabbitson)
Subject: SATAII150 TX4 Disk ordering (Was: Promise SATAII150 TX4: strange disk ordering)
Date: Fri, 22 Dec 2006 06:31:31 -0500
Message-ID: <20061222113131.GA24610@rabbit.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from arx.rabbit.us ([68.251.127.6]:4888 "EHLO arx.rabbit.us"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964819AbWLVL4d (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 22 Dec 2006 06:56:33 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: jgarzik@pobox.com

Hello. I have stumbled upon the problem described more than a year ago 
in http://www.mail-archive.com/linux-ide@vger.kernel.org/msg01743.html 
It manifested itself in a very unpleasant way while trying to sort out a 
damaged GRUB installation. As GRUB relies on BIOS device numbering 
rather than linux kernel device numbering (there is no kernel at that 
stage) writing a manual boot stanza took a number of trial and errors. I 
just wanted to drop my 2 cents by pointing a use case when this mismatch 
is a real pain. The above URL was the only info I was able to find on 
google, so I assume no further work has been done on this.
This is a non-production system so I can help with any tests necessary 
to get the ordering right, if anyone decides to work on the driver. 

Thanks

Peter
