From: Jarrod Johnson <jarrod.b.johnson@gmail.com>
Subject: Problems w/ RAID-5/sata_promise/PDC20579
Date: Tue, 19 Jul 2005 00:58:41 -0400
Message-ID: <fab4e42a050718215857958bc4@mail.gmail.com>
Reply-To: Jarrod Johnson <jarrod.b.johnson@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.197]:52063 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261946AbVGSE7v convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 19 Jul 2005 00:59:51 -0400
Received: by wproxy.gmail.com with SMTP id i11so1150750wra
        for <linux-ide@vger.kernel.org>; Mon, 18 Jul 2005 21:59:51 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I have a Soltek planar with this controller providing two ports.

As I try to use those ports together with two non-pdc attached sata
drives for software raid, the devices hanging off of the PDC
controller frequently become unresponive, throwing I/O errors on every
attempt to read a sector after a timeout.

Don't have the exact error in front of me, but essentially, it gets
command timeout,
then every command to the controller seems to give the same, status of
0xff busy, but not much more informative output.

The situation seems very similar to Jim Ramsays:
http://www.opensubscriber.com/message/linux-ide@vger.kernel.org/1671725.html

Output seems to line up pretty much exactly, except specific sector
numbers, of course.
