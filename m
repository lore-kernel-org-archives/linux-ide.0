From: Jeff Garzik <jgarzik@pobox.com>
Subject: libata PATA to-do list
Date: Wed, 13 Oct 2004 15:44:13 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <416D858D.2000702@pobox.com>
References: <200410110045.05952.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:40096 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269798AbUJMTo1
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 13 Oct 2004 15:44:27 -0400
In-Reply-To: <200410110045.05952.bzolnier@elka.pw.edu.pl>
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>, Alan Cox <alan@lxorguk.ukuu.org.uk>, albertcc@tw.ibm.com


Since Bart was asking about to-do items for ATAPI (a key requirement for 
useful PATA support), I thought I would go ahead and post the main PATA 
to-do items, should anybody like to work on these.

* ATAPI (to-do list outlined in recent conversation with Bart)
* C/H/S addressing; libata currently hardcoded to use LBA
* add PATA device errata/blacklist info; Alan likes to complain about 
this one, with colorful examples of device death :)

There may be one or two minor things I am forgetting, but those are the 
main ones.

	Jeff



