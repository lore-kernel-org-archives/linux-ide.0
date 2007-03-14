From: Len Brown <lenb@kernel.org>
Subject: Re: Regression between 2.6.20 and 2.6.21-rc1: NCQ problem with ahci and Hitachi drive
Date: Wed, 14 Mar 2007 01:31:28 -0400
Message-ID: <200703140131.28251.lenb@kernel.org>
References: <45EB6980.90600@crans.org> <45EB79C1.3070107@gmail.com> <45EC8B3E.7040706@crans.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:50154 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933833AbXCNFhj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 14 Mar 2007 01:37:39 -0400
In-Reply-To: <45EC8B3E.7040706@crans.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mathieu =?iso-8859-1?q?B=E9rard?= <Mathieu.Berard@crans.org>
Cc: Tejun Heo <htejun@gmail.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Adrian Bunk <bunk@stusta.de>


> Yes It works with acpi=off (2.6.21-rc1):
> Please notice that IRQ is changed from 19 with ACPI to 11 without.

Please verify the problem still exists in the latest 2.6.21 git.

If yes, please file a bug here:
http://bugzilla.kernel.org/enter_bug.cgi?product=ACPI

For 2.6.20.stable, please attach
the complete output from dmesg -s64000
output from acpidump
output from lspci -vv
and paste a copy of /proc/interrupts

For 2.6.21.broken, please attach as much
of the dmesg as you can capture, and the /proc/interrupts
if you can get that far.

thanks,
-Len
