From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET] libata: implement and use ata_dev_revalidate(), take #3
Date: Sun, 5 Mar 2006 17:55:58 +0900
Message-ID: <11415489584127-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.201]:10589 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1752008AbWCEI4D (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 5 Mar 2006 03:56:03 -0500
Received: by zproxy.gmail.com with SMTP id 13so1017523nzn
        for <linux-ide@vger.kernel.org>; Sun, 05 Mar 2006 00:56:02 -0800 (PST)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org, htejun@gmail.com

Hello, Jeff.

This is the third take of implement-and-use-ata_dev_revalidate
patchset.  In the last take[1], out of four patches, %1, %2 and %4 got
ACK'ed while %3 had some minor issues.

Changes from the last take are...

* in #3, ata_dev_same_device() tags mismatch messages with KERN_INFO
  instead of KERN_WARNING.

* in #3, ata_dev_revalidate() returns -ENODEV instead of 0 if device
  isn't present

Thanks.

--
tejun

[1] http://marc.theaimsgroup.com/?l=linux-ide&m=114120130020500&w=2
    (gmane is down...)


