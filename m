From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 7/21] ide-cris: don't override ide_register_hw() result
Date: Tue, 27 Nov 2007 15:58:09 +0300
Message-ID: <474C1461.1030807@ru.mvista.com>
References: <200711182319.02460.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:42031 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754691AbXK0M54 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 27 Nov 2007 07:57:56 -0500
In-Reply-To: <200711182319.02460.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, Mikael Starvik <starvik@axis.com>

Bartlomiej Zolnierkiewicz wrote:

> * Don't override ide_register_hw() result and check if there is a hwif
>   available to use.

> * MAX_HWIFS is user configurable nowadays so replace it by hard-coded value.

> * Remove the comment about ide_hwifs[].

> Cc: Mikael Starvik <starvik@axis.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei

