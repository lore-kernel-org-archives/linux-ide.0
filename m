From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2/18] ide-pmac: skip conservative PIO "downgrade"
Date: Tue, 06 Nov 2007 14:30:07 +0300
Message-ID: <4730503F.6060705@ru.mvista.com>
References: <200711050017.04599.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:30532 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754036AbXKFL3y (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Nov 2007 06:29:54 -0500
In-Reply-To: <200711050017.04599.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, Mikael Pettersson <mikpe@it.uu.se>, Benjamin Herrenschmidt <benh@kernel.crashing.org>

Bartlomiej Zolnierkiewicz wrote:

> We can skip conservative PIO "downgrade" (PIO3 becomes PIO2 etc.) on PMAC.

> Problem reported by Mikael.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
