From: Gwendal Grignou <gwendal@google.com>
Subject: [PATCH 0/2] [sata_mv] Improve disk performance when a PMP is used and
	NCQ is disabled
Date: Sun, 25 Jan 2009 14:26:34 -0800
Message-ID: <e7510f760901251426i38704616o52eece9bd6680529@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.45.13]:53415 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750721AbZAYW0k (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 25 Jan 2009 17:26:40 -0500
Received: from spaceape14.eur.corp.google.com (spaceape14.eur.corp.google.com [172.28.16.148])
	by smtp-out.google.com with ESMTP id n0PMQcmP010767
	for <linux-ide@vger.kernel.org>; Sun, 25 Jan 2009 14:26:39 -0800
Received: from wf-out-1314.google.com (wff28.prod.google.com [10.142.6.28])
	by spaceape14.eur.corp.google.com with ESMTP id n0PMQY3X022192
	for <linux-ide@vger.kernel.org>; Sun, 25 Jan 2009 14:26:35 -0800
Received: by wf-out-1314.google.com with SMTP id 28so6430664wff.30
        for <linux-ide@vger.kernel.org>; Sun, 25 Jan 2009 14:26:34 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>, IDE/ATA development list <linux-ide@vger.kernel.org>

Mark,

The next 2 patches enables FBS [FIS Based Switching] for sata_mv. I
need to modify libata to add a new flag in qc to handle errors.
I thought I submitted them properly few months ago, but I did not go through...

Thanks,
Gwendal.
