From: Brad Fitzpatrick <brad@danga.com>
Subject: crash w/ bonnie++ on XFS on LVM VG w/5 PMP devices
Date: Tue, 16 Jan 2007 19:51:27 +0000 (UTC)
Message-ID: <Pine.LNX.4.58.0701161933540.17363@mailx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.danga.com ([207.7.148.197]:47520 "EHLO danga.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751385AbXAPTvH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 16 Jan 2007 14:51:07 -0500
Received: from localhost (mailx [127.0.0.1])
	by danga.com (Postfix) with ESMTP id 5FD9A14132A3
	for <linux-ide@vger.kernel.org>; Tue, 16 Jan 2007 19:51:38 +0000 (UTC)
Received: from danga.com ([127.0.0.1])
	by localhost (mailx [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 10893-02 for <linux-ide@vger.kernel.org>;
	Tue, 16 Jan 2007 19:51:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by danga.com (Postfix) with ESMTP id 167403430EF0
	for <linux-ide@vger.kernel.org>; Tue, 16 Jan 2007 19:51:28 +0000 (UTC)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello,

I can reliably crash 2.6.18.6 + libata-tj-2.6.18.1-20061020 with 5 PMP
devices in a LVM2 volume group, with bonnie++ (filesystem benchmarking
tool) running on a 2.3TB XFS filesystem.

The crash happens almost immediately upon starting bonnie, within writing
~600 MB of the initial test file.

Unfortunately the backtrace blows the VGA console and I'm unable to
capture it with netconsole.  Sysrq seems equally useless.

So before I go find/buy a serial cable and move a computer to get a serial
console backtrace, I'd like to try the latest git repo w/ PMP.  I got the
libata-tj git with:

   git clone git://htj.dyndns.org/libata-tj

But it doesn't seem to have PMP in it.  I see the "pmp" head has it, but
is there anything that's merged with upstream any more recently than
2006-10?

Thanks!

Brad

