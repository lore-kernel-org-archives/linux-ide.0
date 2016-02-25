From: Laura Abbott <labbott@redhat.com>
Subject: [REGRESSION] 8a3e33cf92c7 "ata: ahci: find eSATA ports and flag them
 as removable" changes userspace behavior
Date: Thu, 25 Feb 2016 09:12:26 -0800
Message-ID: <56CF35FA.1070500@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49793 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760941AbcBYRMe (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 25 Feb 2016 12:12:34 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Manuel Lauss <manuel.lauss@gmail.com>
Cc: linux-ide@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi,

We received a bugzilla report https://bugzilla.redhat.com/show_bug.cgi?id=1310682
of partitions being automounted unexpectedly. Testing showed that
8a3e33cf92c7 ("ata: ahci: find eSATA ports and flag them as removable") was responsible.
This seems to be classified as 'breaking' userspace given that this behavior results
in partitions that were previously unmounted now being being mounted unwanted
automatically which is unwanted behavior for the user. Can we revert this patch or
give a fix to change this behavior?

Thanks,
Laura
