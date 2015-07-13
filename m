From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [PATCH] libata: add ATA_HORKAGE_MAX_SEC_1024 to revert back to previous max_sectors limit
Date: Mon, 13 Jul 2015 13:09:47 -0400
Message-ID: <x49wpy40ysk.fsf@segfault.boston.devel.redhat.com>
References: <1436806103-16503-1-git-send-email-dmilburn@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59521 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752301AbbGMRJt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 13 Jul 2015 13:09:49 -0400
In-Reply-To: <1436806103-16503-1-git-send-email-dmilburn@redhat.com> (David
	Milburn's message of "Mon, 13 Jul 2015 11:48:23 -0500")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Milburn <dmilburn@redhat.com>
Cc: tj@kernel.org, linux-ide@vger.kernel.org

David Milburn <dmilburn@redhat.com> writes:

> Since no longer limiting max_sectors to BLK_DEF_MAX_SECTORS (commit 34b48db66e08),
> data corruption may occur on ST380013AS drive configured on 82801JI (ICH10 Family)
> SATA controller. This patch will allow the driver to limit max_sectors as before
>
> # cat /sys/block/sdb/queue/max_sectors_kb 
> 512
>
> I was able to double the max_sectors_kb value up to 16384 on linux-4.2.0-rc2
> before seeing corruption, but seems safer to use previous limit. Without this 
> patch max_sectors_kb will be 32767.
>
> Reported-by: Jeff Moyer <jmoyer@redhat.com>

Note that this is silent data corruption.  It appeared to be misdirected
writes.  Here's the reproducer I used:

rpm -e kernel-debuginfo
yum -y install kernel-debuginfo
sync
echo 3 > /proc/sys/vm/drop_caches
rpm -V kernel-debuginfo

The rpm verify would fail the md5sum checks for several of the files in
the kernel-debuginfo package.  You could substitute a reboot for the
drop_caches to get the same results (it just takes longer).

Cheers,
Jeff
