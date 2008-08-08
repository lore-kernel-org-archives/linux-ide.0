From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 6/2] ide-floppy: remove MODE_SENSE_* defines
Date: Fri, 08 Aug 2008 13:56:03 +0400
Message-ID: <489C1833.40409@ru.mvista.com>
References: <200808071911.22171.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:22122 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753584AbYHHJ4L (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 8 Aug 2008 05:56:11 -0400
In-Reply-To: <200808071911.22171.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

Hello.

Bartlomiej Zolnierkiewicz wrote:

> Only MODE_SENSE_CURRENT (0x00) is ever used so just remove
> these defines and then drop no longer needed 'type' argument
> from idefloppy_create_mode_sense_cmd().
>
> Cc: Borislav Petkov <petkovbb@gmail.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei


