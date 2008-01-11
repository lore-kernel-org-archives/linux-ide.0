From: Chuck Ebbert <cebbert@redhat.com>
Subject: LIBATA SCSI command validation changed in 2.6.24
Date: Fri, 11 Jan 2008 16:30:10 -0500
Message-ID: <4787DFE2.2000504@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:58967 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760222AbYAKVaM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 11 Jan 2008 16:30:12 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel <linux-kernel@vger.kernel.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

commit 607126c2a21cd6e9bb807fdd415c1a992f7b9009 changed command validation
to allow short commands in 16-byte CDBs, but it also made checking more
strict. Before the change, a 10-byte SG_IO command could have its length set
to 9 and still work. Now it fails. Not sure if this is a bug, but it has
caused at least one application to fail that used to work (qpxtool.)

[https://bugzilla.redhat.com/show_bug.cgi?id=428281]
