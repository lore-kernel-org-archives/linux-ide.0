From: Chuck Ebbert <cebbert@redhat.com>
Subject: Another Maxtor drive with broken NCQ
Date: Fri, 06 Jul 2007 14:45:53 -0400
Message-ID: <468E8DE1.9010405@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:37349 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754333AbXGFSpz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 6 Jul 2007 14:45:55 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l66IjsPt029354
	for <linux-ide@vger.kernel.org>; Fri, 6 Jul 2007 14:45:54 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l66IjsFv017263
	for <linux-ide@vger.kernel.org>; Fri, 6 Jul 2007 14:45:54 -0400
Received: from [172.16.83.145] (dhcp83-145.boston.redhat.com [172.16.83.145])
	by mail.boston.redhat.com (8.13.1/8.13.1) with ESMTP id l66IjrEv025295
	for <linux-ide@vger.kernel.org>; Fri, 6 Jul 2007 14:45:53 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: IDE/ATA development list <linux-ide@vger.kernel.org>

From:
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=246352

Looks like this entry is needed in the NCQ blacklist:

{"Maxtor 6B200M0",      "BANC1BM0",     ATA_HORKAGE_NONCQ }

Or should *all* Maxtor 6B200M0 be blacklisted, since there's already
one of them in the list?
