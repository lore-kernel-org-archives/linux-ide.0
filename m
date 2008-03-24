From: Bodo Eggert <7eggert@gmx.de>
Subject: Re: [PATCH 1/8] ide: always auto-tune PIO in legacy VLB host drivers
Date: Mon, 24 Mar 2008 03:27:22 +0100
Message-ID: <E1JdcPD-0000lP-2t@be1.7eggert.dyndns.org>
References: <aajV7-54-9@gated-at.bofh.it>
Reply-To: 7eggert@gmx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:61043 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753119AbYCXC1b (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 23 Mar 2008 22:27:31 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.orgBartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:

|Subject: [PATCH 1/8] ide: always auto-tune PIO in legacy VLB host drivers

AFAIR this isn't safe for bus speeds above 33 MHz, is it?

