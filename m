From: David Wuertele <dave-gnus@bfnet.com>
Subject: 2.4.18 hangs during probe of hda (hda == Compact Flash not plugged
 in)
Date: Mon, 17 Mar 2003 12:56:16 -0800
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <m3r895hfv3.fsf@bfnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from root by main.gmane.org with local (Exim 3.35 #1 (Debian))
	id 18v1s3-0007YM-00
	for <linux-ide@vger.kernel.org>; Mon, 17 Mar 2003 22:10:11 +0100
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I'm building an embedded system which has no disk drives, but it does
have a slot for a compact flash card.  One problem I'm having is that
when the compact flash is not plugged in during boot, Linux 2.4.18
tries to probe hda, and hangs.

I've used the "hda=noprobe" kernel argument to get past that stage.
The problem is that once I've booted, I don't know how to enable hda.

Since the Compact Flash is removable, I want to enable hda as soon as
it is inserted.  What is the proper way to do this?

Dave

