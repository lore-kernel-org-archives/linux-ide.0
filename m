From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] libata-scsi: set correct VERSION field for ZAC devices
Date: Tue, 12 Jul 2016 16:58:56 +0300
Message-ID: <94804e9b-4e71-bbf6-a1db-03c48122e54f@cogentembedded.com>
References: <5784f482.d607620a.24b2e.ffffae8e@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lf0-f41.google.com ([209.85.215.41]:36652 "EHLO
	mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751366AbcGLN7A (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 12 Jul 2016 09:59:00 -0400
Received: by mail-lf0-f41.google.com with SMTP id q132so14405264lfe.3
        for <linux-ide@vger.kernel.org>; Tue, 12 Jul 2016 06:58:59 -0700 (PDT)
In-Reply-To: <5784f482.d607620a.24b2e.ffffae8e@mx.google.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tom.ty89@gmail.com, tj@kernel.org, hare@suse.de, shaun.tancheff@seagate.com
Cc: linux-ide@vger.kernel.org

On 7/12/2016 4:45 PM, tom.ty89@gmail.com wrote:

> From: Tom Yan <tom.ty89@gmail.com>
>
> Commit 856c4663930988118d9f355aad66811dd6df06de had the line that

    You also need to specify the commit summary in (""). It's enough to 
specify 12 digits of SHA1 ID.

> "bumps" the VERSION field in standard INQUIRY data removed. Add
> it back and claim SPC-5 version compatibility, which matches with
> the current version descriptor "SPC-5 (no version claimed)" used
> for ZAC devices.
>
> Signed-off-by: Tom Yan <tom.ty89@gmail.com>

[...]

MBR, Sergei

