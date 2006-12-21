From: Bob Stewart <bob@evoria.net>
Subject: Re: sata_inic162x driver for 2.6.19
Date: Wed, 20 Dec 2006 17:48:23 -0800 (PST)
Message-ID: <429226.30925.qm@web807.biz.mail.mud.yahoo.com>
References: <4588D680.4060103@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web807.biz.mail.mud.yahoo.com ([209.191.90.80]:45405 "HELO
	web807.biz.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1161127AbWLUBsY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 20 Dec 2006 20:48:24 -0500
In-Reply-To: <4588D680.4060103@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org


--- Tejun Heo <htejun@gmail.com> wrote:

> The attached patch is inic162x driver for 2.6.19.  The driver against
> livata-dev#upstream didn't work on 2.6.19 due to difference in how
> dev->max_sectors is handled.  The driver is also available at...
> 
> http://home-tj.org/files/sata_inic-2.6.19.patch
> 
> Please report how it works.


As further data, I have discovered that the problem with the lockups only
occurs when mkfs.xfs reports that it will create more then 16383 blocks in the
new filesystem.

Bob
