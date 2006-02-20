From: Tejun Heo <htejun@gmail.com>
Subject: EH progress summary
Date: Mon, 20 Feb 2006 12:40:35 +0900
Message-ID: <43F93A33.1020809@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.197]:49106 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932601AbWBTDkk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 19 Feb 2006 22:40:40 -0500
Received: by zproxy.gmail.com with SMTP id s1so866716nze
        for <linux-ide@vger.kernel.org>; Sun, 19 Feb 2006 19:40:39 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux-ide <linux-ide@vger.kernel.org>

Hello, Jeff.

I think we're half-way through the EH changes. New reset mechanism and 
most of config reorganization are in tree. Currently, the patches which 
are waiting for your review are...

[1] libata: rename ata_dev_id_[c_]string()
[2] libata: reorganize ata_dev_identify() (7 patches)
[3] libata: implement and use ata_dev_revalidate() (4 patches)

Once these revalidation changes make into tree, I'll submit 
ata_set_mode() changes (I've submitted the first patchset of this but 
Alan had a valid objection. I agreed and dropped that one.[4])

After ata_set_mode() changes are complete, the real EH changes will be 
submitted including error recording (to determine whether speed down is 
necessary) and all the recovery actions. I haven't splitted these yet 
but I guess it will be three or four patchsets.

And after that, Jens' NCQ work can be integrated over it. The code 
required to implement NCQ is actually quite small.  It will probably 
take only one patchset of about three to five patches.

So, this is where we stand. I hope we can get new EH up and working soon.

Thanks a lot. :-)

-- 
tejun

[1] http://article.gmane.org/gmane.linux.ide/7997
[2] http://article.gmane.org/gmane.linux.ide/8048
[3] http://article.gmane.org/gmane.linux.ide/8050
[4] http://article.gmane.org/gmane.linux.ide/8054
