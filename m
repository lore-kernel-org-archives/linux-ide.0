From: Jeff Garzik <jgarzik@pobox.com>
Subject: Orphaned libata patches
Date: Fri, 15 Oct 2004 04:01:05 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <416F83C1.4000902@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:34703 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266465AbUJOIBV
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 15 Oct 2004 04:01:21 -0400
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>


Here are two patches which I created, but they are incomplete, and their 
parent trees have since disappeared or moved on.

A fair amount of REQUEST SENSE work:
http://www.kernel.org/pub/linux/kernel/people/jgarzik/libata/patch.request-sense.bz2

The easy half of the libata iomap conversion:
http://www.kernel.org/pub/linux/kernel/people/jgarzik/libata/patch.iomap.bz2
(the remaining half involves iomap'ing >= 4 independent BARs per 
controller... yuck.)

I'll continue to work on the iomap conversion, but it will be a few days 
before I get back to it (in case you want to beat me to it, Al).

The request sense patch hasn't been touched in a while.

	Jeff



