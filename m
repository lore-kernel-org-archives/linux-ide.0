From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET] sata_sil: R_ERR on DMA activate FIS errata workaround
Date: Sat, 25 Feb 2006 13:30:46 +0900
Message-ID: <1140841846157-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.197]:23027 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932658AbWBYE3k (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 24 Feb 2006 23:29:40 -0500
Received: by wproxy.gmail.com with SMTP id i22so435828wra
        for <linux-ide@vger.kernel.org>; Fri, 24 Feb 2006 20:29:40 -0800 (PST)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org, hellan@acm.org, Carlos.Pardo@siliconimage.com, Raymond.Liu@siliconimage.com

Hello, Jeff.

This patchset implements workaround for 3512/3114 R_ERR on DMA
activate FIS workaround.  I've confirmed the lockup and workaround on
SiI3114 with ST3120026AS (FW 3.18) and Jon Kare confirmed it on 3512
with ST3200822AS and SP2504C.  This is also consistent with a number
of lock up reports from 3512/3114 users that I personally received and
seen on linux-ide.

Mod15Write workaround masks this errata and, without m15w workaround,
this errata triggers for wider range of drives (including 7200.7's).
This seems to be the main reason for overgrowth of m15w blacklist.

The m15w workaround was applied to 3512 and 3114 until 2.6.13.
2.6.14-rc1 removed it causing lockups for 3512/3114.  I think this is
a regression (and a very bothering one) and hope this fix can slip
into 2.6.16.

Thanks.

--
tejun


