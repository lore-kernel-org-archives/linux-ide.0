From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 4/4] ide: add IDE_DFLAG_NIEN_QUIRK device flag
Date: Fri, 22 May 2009 14:19:38 +0400
Message-ID: <4A167C3A.7010203@ru.mvista.com>
References: <200905201735.15489.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:26242 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751791AbZEVKTm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 22 May 2009 06:19:42 -0400
In-Reply-To: <200905201735.15489.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

> Add IDE_DFLAG_NIEN_QUIRK device flag and use it instead of
> drive->quirk_list.
>
> There should be no functional changes caused by this patch.
>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei


