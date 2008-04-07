From: Tejun Heo <htejun@gmail.com>
Subject: [GIT PULL REQUEST #upstream] Please pull modularize patchsets
Date: Mon, 07 Apr 2008 23:09:40 +0900
Message-ID: <47FA2B24.8060502@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.180]:42962 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752776AbYDGOJq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 Apr 2008 10:09:46 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1326034wah.23
        for <linux-ide@vger.kernel.org>; Mon, 07 Apr 2008 07:09:46 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

Hello, Jeff.

Please pull from modularize-PMP branch which contains updated versions
of both modularize-SFF[1] and modularize-PMP[2] patchsets.  Other than
minor compile fixes due to new patches on top of #upstream, there
wasn't any change so I'm not posting the updated patches.

The git tree is located at...

  ssh://master.kernel.org/pub/scm/linux/kernel/git/tj/libata-dev.git modularize-PMP

And, hopefully, in the following public repos pretty soon.

  http://git.kernel.org/?p=linux/kernel/git/tj/libata-dev.git;a=shortlog;h=modularize-PMP
  git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata-dev.git modularize-PMP

Thanks.

-- 
tejun

[1] http://thread.gmane.org/gmane.linux.ide/29981
[2] http://thread.gmane.org/gmane.linux.ide/30009
