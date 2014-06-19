From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: libata's awful reaction to passworded disks
Date: Thu, 19 Jun 2014 11:38:07 +0100
Message-ID: <20140619113807.401e21ea@alan.etchedpixels.co.uk>
References: <508686.83315.qm@web100003.mail.kks.yahoo.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:43138 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751399AbaFSKiO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 19 Jun 2014 06:38:14 -0400
In-Reply-To: <508686.83315.qm@web100003.mail.kks.yahoo.co.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Norman Diamond <n0diamond@yahoo.co.jp>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On Thu, 19 Jun 2014 13:18:34 +0900 (JST)
Norman Diamond <n0diamond@yahoo.co.jp> wrote:

> If someone has set a password on an ATA/SATA hard drive and someone later connects the drive to a Linux system (before or after booting that Linux system), libata reacts in an unbearably stupid manner.

Yes. It's well known. Send patches if you care. So far nobody has cared
enough to write the code to use the key rings to deal with drive
unlocking.

Alan
