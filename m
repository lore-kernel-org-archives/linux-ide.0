From: Joseph Salisbury <joseph.salisbury@canonical.com>
Subject: [Regression] libata: sata_down_spd_limit should return if driver has
 not recorded sstatus speed
Date: Fri, 10 Aug 2018 16:41:00 -0400
Message-ID: <479e7a10-1fdc-5742-e488-3c36233a5393@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: dmilburn@redhat.com
Cc: tj@kernel.org, linux-ide@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 1783906@bugs.launchpad.net
List-Id: linux-ide@vger.kernel.org

Hi David,

A kernel bug report was opened against Ubuntu [0].  This bug is a
regression introduced in v4.15-rc4.  The following commit was identified
as the cause of the regression:

        2dc0b46b5ea3 ("libata: sata_down_spd_limit should return if
driver has not recorded sstatus speed")

I was hoping to get your feedback, since you are the patch author.  Do
you think gathering any additional data will help diagnose this issue,
or would it be best to submit a revert request?


Thanks,

Joe

http://pad.lv/1783906
