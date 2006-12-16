From: Tejun Heo <htejun@gmail.com>
Subject: Okay, ppl.  Here's driver for inic162x.
Date: Sat, 16 Dec 2006 19:55:42 +0900
Message-ID: <4583D0AE.3090204@gmail.com>
References: <20061216104805.GC5400@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:19169 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030841AbWLPKz5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 16 Dec 2006 05:55:57 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1060260uga
        for <linux-ide@vger.kernel.org>; Sat, 16 Dec 2006 02:55:56 -0800 (PST)
In-Reply-To: <20061216104805.GC5400@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, bob@evoria.net, nabble@theanthonys.net, alan@lxorguk.ukuu.org.uk, matthias@urlichs.de, romieu@fr.zoreil.com

These three patches implement sata_inic162x.  As usual, the patches are
against the current libata-dev#upstream
(b6c0159899e9742f5462ae3ee19e6573aa47b5d8).

It seems to run pretty stable on my machine but I'm the developer and no
one should trust my testing.  So, knock yourself out.  Remember, this is
still in alpha stage.  Put your precious xxx collection somewhere else.

Anyone interested in patch against 2.6.19?  If there's enough need I can
make one to accelerate testing.

-- 
tejun
