From: "Adam J. Richter" <adam@yggdrasil.com>
Subject: Re: [FIX] Re: 2.5.70-bk[56] breaks disk partitioning with multiple IDE disks
Date: Sun, 1 Jun 2003 18:59:03 -0700
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200306020159.h521x3T13476@freya.yggdrasil.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h-64-105-35-138.SNVACAID.covad.net ([64.105.35.138]:1664 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP id S264783AbTFBBpL
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 1 Jun 2003 21:45:11 -0400
List-Id: linux-ide@vger.kernel.org
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: linux-ide@vger.kernel.org

On Mon, 2 Jun 2003 viro@parcelfarce.linux.theplanet.co.uk wrote:
> vi drivers/ide/ide.c -c'/drive->list.*driver->drives/s/list_add/&_tail/|x'

	Your change worked for me.  Thanks!

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Miplitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
