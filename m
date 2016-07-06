From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v3 1/2] libata-scsi: reject WRITE SAME (16) with n_block
 that exceeds limit
Date: Wed, 6 Jul 2016 20:02:43 +0300
Message-ID: <41a56c06-cc57-698c-6b05-779094093714@cogentembedded.com>
References: <577d3580.46c0620a.b8b1b.ffff9a01@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lf0-f51.google.com ([209.85.215.51]:35308 "EHLO
	mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755236AbcGFRCr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 6 Jul 2016 13:02:47 -0400
Received: by mail-lf0-f51.google.com with SMTP id l188so158656322lfe.2
        for <linux-ide@vger.kernel.org>; Wed, 06 Jul 2016 10:02:47 -0700 (PDT)
In-Reply-To: <577d3580.46c0620a.b8b1b.ffff9a01@mx.google.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tom.ty89@gmail.com, tj@kernel.org, martin.petersen@oracle.com
Cc: linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org

On 07/06/2016 07:44 PM, tom.ty89@gmail.com wrote:

> From: Tom Yan <tom.ty89@gmail.com>
>
> Currently if a WRITE SAME (16) command is issued to the SATL with
> "number of blocks" that is larger than the "Maximum write same length"
> (which is the maximum number of blocks per TRIM command allowed in
> libata, currently 65535 * 512 / 8 blocks), the SATL will accept the
> command and translate it to a TRIM command with the upper limit.
>
> However, according to SBC (as of sbc4r11.pdf), the "device server"
> should terminate the command with "Invalid field in CBD" in that case.

    CDB again. :-)

> Signed-off-by: Tom Yan <tom.ty89@gmail.com>
[...]

MBR, Sergei

