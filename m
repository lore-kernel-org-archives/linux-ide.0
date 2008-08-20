From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 6/9] ide: remove [ata_]select_t
Date: Wed, 20 Aug 2008 13:57:49 +0400
Message-ID: <48ABEA9D.8040804@ru.mvista.com>
References: <20080817195336.13393.86030.sendpatchset@localhost.localdomain> <20080817195411.13393.22229.sendpatchset@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:29024 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750932AbYHTJ54 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 20 Aug 2008 05:57:56 -0400
In-Reply-To: <20080817195411.13393.22229.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

> * Use 'drive->dn & 1' in ide_init_disk().
>
> * remove [ata_]select_t.
>
> While at it:
>
> * Use ATA_DEVICE_OBS define in ide_port_init_devices_data().
>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei


