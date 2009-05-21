From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2/4] hpt366: enable all quirks for devices on quirk_drives[]
 list
Date: Thu, 21 May 2009 22:58:19 +0400
Message-ID: <4A15A44B.2020407@ru.mvista.com>
References: <200905201733.58869.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:58100 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753388AbZEUS50 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 21 May 2009 14:57:26 -0400
In-Reply-To: <200905201733.58869.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> Enable also quirks in do_reset1() and ide_config_drive_speed()
> for devices on quirk_drives[] list.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
