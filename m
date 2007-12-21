From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 21/63] ide-cd: remove unused and write-only struct ide_cd_config_flags
 fields
Date: Fri, 21 Dec 2007 15:45:49 +0300
Message-ID: <476BB57D.3050306@ru.mvista.com>
References: <200712200208.43246.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:30796 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750723AbXLUMp2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 21 Dec 2007 07:45:28 -0500
In-Reply-To: <200712200208.43246.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> unused fields:
> * ->writing
> * ->reserved

> write-only fields:
> * ->playmsf_as_bcd
> * ->subchan_as_bcd
> * ->test_write
> * ->supp_disc_present

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei

