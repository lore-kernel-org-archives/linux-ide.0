From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2.5/3] palm_bk3710: port initialization/probing bugfix
Date: Fri, 08 Feb 2008 20:32:50 +0300
Message-ID: <47AC9242.6040705@ru.mvista.com>
References: <200802072150.34389.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:60968 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757147AbYBHRb7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 8 Feb 2008 12:31:59 -0500
In-Reply-To: <200802072150.34389.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Anton Salnikov <asalnikov@ru.mvista.com>

Bartlomiej Zolnierkiewicz wrote:

> Probe port _after_ it is fully initialized.

    Hm, I thought the usual sequence is vice versa: you first probe and then 
initialize. :-)

> Cc: Anton Salnikov <asalnikov@ru.mvista.com>
> Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
