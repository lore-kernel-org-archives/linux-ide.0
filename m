From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] pata_legacy: Allow disabling of legacy PATA device
 probes on non-PCI systems
Date: Mon, 5 Dec 2016 14:23:10 -0500
Message-ID: <20161205192310.GA30331@mtj.duckdns.org>
References: <1480441982-20992-1-git-send-email-tedheadster@gmail.com>
 <84a95190-9e30-81ac-5f23-744243ba7fce@cogentembedded.com>
 <20161130145322.252f7403@lxorguk.ukuu.org.uk>
 <CAP8WD_boGwPZCEPE8hA-AhQnHChrbaM+74LTUy-9__s6ex56Sg@mail.gmail.com>
 <20161130202201.GA15989@htj.duckdns.org>
 <CAP8WD_bZWeLBhLXqJG5uDwBe+zBubw+A+ecSuaihOuwvw9QoCQ@mail.gmail.com>
 <20161202170705.GB6033@htj.duckdns.org>
 <CAP8WD_bUW9cAAQpvenL73sxvpoxNYwZdRqpj92YWEyanK51+0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36359 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751373AbcLETXW (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 5 Dec 2016 14:23:22 -0500
Received: by mail-pg0-f65.google.com with SMTP id x23so17295303pgx.3
        for <linux-ide@vger.kernel.org>; Mon, 05 Dec 2016 11:23:14 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAP8WD_bUW9cAAQpvenL73sxvpoxNYwZdRqpj92YWEyanK51+0g@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: whiteheadm@acm.org
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, linux-ide@vger.kernel.org

Hello,

Hmm... I'm a bit confused.  These resources are tied to the platform
device which is unregistered on probe failure which will invoke
devres_release_all().

Matthew, can you please apply the following patch and see whether
device_release() gets invoked?

Thanks.

diff --git a/drivers/ata/pata_legacy.c b/drivers/ata/pata_legacy.c
index bce2a8c..0dd72ce 100644
--- a/drivers/ata/pata_legacy.c
+++ b/drivers/ata/pata_legacy.c
@@ -1013,6 +1013,7 @@ static __init int legacy_init_one(struct legacy_probe *probe)
 	}
 	ata_host_detach(host);
 fail:
+	printk("XXX pata_legacy: unregistering platform dev %p\n", pdev);
 	platform_device_unregister(pdev);
 	return ret;
 }
diff --git a/drivers/base/core.c b/drivers/base/core.c
index ce057a5..a3d112d 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -237,6 +237,7 @@ static void device_release(struct kobject *kobj)
 	 * is deleted but alive, so release devres here to avoid
 	 * possible memory leak.
 	 */
+	printk("XXX device_release: invoking devres_release_all\n");
 	devres_release_all(dev);
 
 	if (dev->release)

