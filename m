From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH #upstream-fixes] libata: DVR-212D can't do SETXFER DVD-RW
 DVR-212D
Date: Mon, 24 Jan 2011 21:24:44 +0300
Message-ID: <4D3DC3EC.2010000@ru.mvista.com>
References: <4D3DA084.9070609@gmail.com> <20110124160125.GC27510@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:49188 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751981Ab1AXS0Z (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 24 Jan 2011 13:26:25 -0500
Received: by ewy5 with SMTP id 5so2053455ewy.19
        for <linux-ide@vger.kernel.org>; Mon, 24 Jan 2011 10:26:24 -0800 (PST)
In-Reply-To: <20110124160125.GC27510@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, Francesco Antonacci <fraanto@gmail.com>

Hello.

Tejun Heo wrote:

> From: Francesco Antonacci <fraanto@gmail.com>

> PIONEER DVR-212D can't to SETXFER like its sibling DVRTD08.  Add

    s/to/do/?

> ATA_HORKAGE_NOSETXFER for it.  Reported in bko#27502.

>   https://bugzilla.kernel.org/show_bug.cgi?id=27502

> Signed-off-by: Francesco Antonacci <fraanto@gmail.com>
> Acked-by: Tejun Heo <tj@kernel.org>

WBR, Sergei

