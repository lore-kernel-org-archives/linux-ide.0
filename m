From: Joe Ceklosky <jfceklosky@gmail.com>
Subject: SSD slowdown with 3.3.X?
Date: Wed, 18 Apr 2012 22:15:15 -0400
Message-ID: <4F8F7533.6020300@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:56270 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751180Ab2DSCPS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Apr 2012 22:15:18 -0400
Received: by qcro28 with SMTP id o28so4930035qcr.19
        for <linux-ide@vger.kernel.org>; Wed, 18 Apr 2012 19:15:16 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

All,

Has anyone reported slowness using SSD's on kernel 3.3.X compiled
as 32-bit PAE with 16 Gigs of memory (I know I need to update to 64-bit
already, will do with Fedora 17)?

I am see terrible r/w to an SSD using 3.3.2.  When I boot the same machine
and SSD back in 3.2.15 all is fine.





Joe Ceklosky
