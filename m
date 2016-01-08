From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 1/2] drivers: pata_octeon_cf : Switch IO mode depending on
 model number
Date: Fri, 8 Jan 2016 15:22:04 -0500
Message-ID: <CAOS58YP=bsJf3wAp4K_TqtwhvbbW+SvL0OpaeaP3zJiFsLK5KA@mail.gmail.com>
References: <1452230332-14926-1-git-send-email-danielwa@cisco.com>
	<20160108153049.GN1898@mtj.duckdns.org>
	<56901803.209@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yk0-f171.google.com ([209.85.160.171]:36694 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751191AbcAHUWG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 8 Jan 2016 15:22:06 -0500
In-Reply-To: <56901803.209@cisco.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Daniel Walker <danielwa@cisco.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Anil Veliyankara Madam <aveliyan@cisco.com>, xe-kernel@external.cisco.com, Shikha Jain <shikjain@cisco.com>, linux-ide <linux-ide@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, "Chris Hall (hall)" <hall@cisco.com>

Hello,

On Fri, Jan 8, 2016 at 3:11 PM, Daniel Walker <danielwa@cisco.com> wrote:
> It's not specific to pata_octeon_cf , it should be applied to the device
> regardless of controller. Is there a better place to put this to cover all ?

Yeap, libata-core.c:ata_device_blacklist[]

Thanks.

-- 
tejun
