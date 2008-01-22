From: Jan Engelhardt <jengelh@computergmbh.de>
Subject: Re: [PATCHSET] printk: implement printk_header() and merging printk,
 take #2
Date: Wed, 23 Jan 2008 00:57:09 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0801230056510.9183@fbirervta.pbzchgretzou.qr>
References: <1200892437108-git-send-email-htejun@gmail.com>
 <20080121124821.GH27250@parisc-linux.org> <Pine.LNX.4.64.0801230036250.9183@fbirervta.pbzchgretzou.qr>
 <47968183.3050704@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sovereign.computergmbh.de ([85.214.69.204]:46631 "EHLO
	sovereign.computergmbh.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751015AbYAVX5K (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 22 Jan 2008 18:57:10 -0500
In-Reply-To: <47968183.3050704@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Matthew Wilcox <matthew@wil.cx>, randy.dunlap@oracle.com, daniel.ritz-ml@swissonline.ch, jeff@garzik.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org


On Jan 23 2008 08:51, Tejun Heo wrote:
>
>What do you think about the second suggestion then?
>
>ata1.00: line0
>ata1.00  line1
>ata1.00  line2
>
>It allows you to grab for the header && has indication for message
>boundaries.

Then again, why not "[ata1.00] line0", then it matches what sd_mod does :)
