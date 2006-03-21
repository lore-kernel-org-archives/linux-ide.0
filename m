From: Matti Aarnio <matti.aarnio@zmailer.org>
Subject: sata_sil did not like multiple LUNs...
Date: Tue, 21 Mar 2006 21:04:10 +0200
Message-ID: <20060321190410.GA2761@mea-ext.zmailer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from z2.cat.iki.fi ([212.16.98.133]:34785 "EHLO z2.cat.iki.fi")
	by vger.kernel.org with ESMTP id S964906AbWCUTEK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 21 Mar 2006 14:04:10 -0500
Received: (mea@mea-ext) by mail.zmailer.org id S255748AbWCUTEK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 21 Mar 2006 21:04:10 +0200
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I need multiple LUNs on FC Fabric, and machine where these
are on does boot from   sata_sil  mirror disks.

During todays boots (after lengthy uptime), sata_sil driver
was rather upset about some NULL pointer referrals.

I had following extra boot line parameters:
         max_luns=4 max_report_luns=4

Taking off those two let kernel boot just fine.


The kernels in question were Fedora Core development 
models from recent 2-3 weeks, including up to current
date.


  /Matti Aarnio
