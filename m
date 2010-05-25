From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream] libata: implement dump_id force param
Date: Tue, 25 May 2010 19:42:17 -0400
Message-ID: <4BFC6059.3080505@garzik.org>
References: <4BF90A7F.80309@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:49394 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933832Ab0EYXmT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 25 May 2010 19:42:19 -0400
Received: by mail-gy0-f174.google.com with SMTP id 13so2329944gyg.19
        for <linux-ide@vger.kernel.org>; Tue, 25 May 2010 16:42:19 -0700 (PDT)
In-Reply-To: <4BF90A7F.80309@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Larry Baker <baker@usgs.gov>

On 05/23/2010 06:59 AM, Tejun Heo wrote:
> Add dump_id libata.force parameter.  If specified, libata dumps full
> IDENTIFY data during device configuration.  This is to aid debugging.
>
> Signed-off-by: Tejun Heo<tj@kernel.org>
> Cc: Larry Baker<baker@usgs.gov>
> ---
>   Documentation/kernel-parameters.txt |    2 ++
>   drivers/ata/libata-core.c           |    9 +++++++++
>   include/linux/libata.h              |    1 +

applied


