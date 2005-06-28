From: "Al Boldi" <a1426z@gawab.com>
Subject: Ide-Driver slowdown
Date: Tue, 28 Jun 2005 12:08:12 +0300
Message-ID: <200506280908.MAA13492@raad.intranet>
References: <011901c57bad$79559e20$0c14a8c0@in.riwagis.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from dial169-164.awalnet.net ([213.184.169.164]:30212 "EHLO
	raad.intranet") by vger.kernel.org with ESMTP id S261711AbVF1JId
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 28 Jun 2005 05:08:33 -0400
Received: from i810 (rescueCli [10.254.254.253])
	by raad.intranet (8.8.7/8.8.7) with ESMTP id MAA13492
	for <linux-ide@vger.kernel.org>; Tue, 28 Jun 2005 12:08:31 +0300
In-Reply-To: <011901c57bad$79559e20$0c14a8c0@in.riwagis.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Why is the ide-driver consistently being slowed down?
>From 2.4.15 - 2.4.31 hdparm -tT /dev/hda slowed from 42mb/s to 38mb/s and
down to 28mb/s on 2.6.12.

