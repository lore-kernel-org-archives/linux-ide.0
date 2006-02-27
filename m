From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: bad kfree(id) ?
Date: Mon, 27 Feb 2006 10:21:23 -0800 (PST)
Message-ID: <Pine.LNX.4.58.0602271015370.22195@shark.he.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:37310 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750800AbWB0SVZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 27 Feb 2006 13:21:25 -0500
Received: from shark.he.net ([66.160.160.2]) by xenotime.net for <linux-ide@vger.kernel.org>; Mon, 27 Feb 2006 10:21:23 -0800
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


I'm using 2.6.16-rc4-mm2.

A the end of function ata_dev_read_id(), in the error case,
under err_out:, it does
	kfree(id);
but this was not dynamically allocated.

Is this a git-to-mm merge error or something that was
missed since it's on an error path?

thanks,
-- 
~Randy
