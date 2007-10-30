From: Frans de Boer <frans@fransdb.nl>
Subject: SATA_SIL
Date: Tue, 30 Oct 2007 22:56:29 +0100
Message-ID: <1193781389.26314.9.camel@ws1.fransdb.nl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out2.tiscali.nl ([195.241.79.177]:50884 "EHLO
	smtp-out2.tiscali.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753461AbXJ3V56 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Oct 2007 17:57:58 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

Dear Sir,

I know, I am not the only one to find out that we can't upgrade to a
newer kernel when using SUSE 10.3. It seems that in 2.6.23 the sil
modules have been updated (newer versions) and thus render the current
system mostly unuseable. I noticed that in the sata_sil24.c source there
where a significant number of chances, which are probally not easy to
change. Overwriting the newer versions with the versions from 2.6.22.9
might work, but for how long.

Is this a problem SUSE introduced, you forgot to take legacy into
account or is it a "feature".
Is this problem adjusted in 2.6.24-rc1?

Kind regards,
Frans de Boer.

