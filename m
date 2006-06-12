From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH v5] Snoop SET FEATURES - WRITE CACHE ENABLE/DISABLE command
Date: Mon, 12 Jun 2006 12:50:53 +0900
Message-ID: <448CE49D.10004@gmail.com>
References: <1150081562.5721.26.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.177]:24046 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751250AbWFLDu7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 11 Jun 2006 23:50:59 -0400
Received: by py-out-1112.google.com with SMTP id x31so1559103pye
        for <linux-ide@vger.kernel.org>; Sun, 11 Jun 2006 20:50:58 -0700 (PDT)
In-Reply-To: <1150081562.5721.26.camel@forrest26.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "zhao, forrest" <forrest.zhao@intel.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

zhao, forrest wrote:
> OK. I ported it to latest #upstream
> 
> Signed-off-by: Zhao, Forrest <forrest.zhao@intel.com>
> 

The patch looks good to me, but can you repost it with proper header 
message?  If Jeff applies your patch w/ git-applymbox, "OK. I ported it 
to latest #upstream" will end up as the commit message body, which isn't 
so descriptive.  Please write what the patch does above Signed-off-by. 
You can write 'ported to latest #upstream' kind of message below 
Signed-off-by separated w/ '---'.  For example.


Subject: [PATCH] libata: Snoop SET FEATURES - WRITE CACHE ENABLE/DISABLE 
command (v5)

[Explain what the patch does.]

Signed-off-by: [....]

---

OK. I ported it to latest #upstream

[If the patch touches a lot of files, including diffstat -p1 result here 
would be nice.]

diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 11df827..7efe991 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -69,6 +69,8 @@ static void ata_dev_xfermask(struct ata_
....

-- 
tejun
