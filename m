From: Tom Yan <tom.ty89@gmail.com>
Subject: Re: [PATCH v3 1/2] libata-scsi: reject WRITE SAME (16) with n_block
 that exceeds limit
Date: Thu, 7 Jul 2016 01:18:29 +0800
Message-ID: <CAGnHSE=98o1O8i4iBhoDUPiNRHJ-JLEdNRLfYb=hxZdGPmnSxQ@mail.gmail.com>
References: <577d3580.46c0620a.b8b1b.ffff9a01@mx.google.com> <41a56c06-cc57-698c-6b05-779094093714@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qk0-f194.google.com ([209.85.220.194]:34804 "EHLO
	mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752728AbcGFRSb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 6 Jul 2016 13:18:31 -0400
In-Reply-To: <41a56c06-cc57-698c-6b05-779094093714@cogentembedded.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Tejun Heo <tj@kernel.org>, martin.petersen@oracle.com, linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org

I am so sorry. Now I hate acronym. v5 coming. :-)

On 7 July 2016 at 01:02, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> On 07/06/2016 07:44 PM, tom.ty89@gmail.com wrote:
>
>> From: Tom Yan <tom.ty89@gmail.com>
>>
>> Currently if a WRITE SAME (16) command is issued to the SATL with
>> "number of blocks" that is larger than the "Maximum write same length"
>> (which is the maximum number of blocks per TRIM command allowed in
>> libata, currently 65535 * 512 / 8 blocks), the SATL will accept the
>> command and translate it to a TRIM command with the upper limit.
>>
>> However, according to SBC (as of sbc4r11.pdf), the "device server"
>> should terminate the command with "Invalid field in CBD" in that case.
>
>
>    CDB again. :-)
>
>> Signed-off-by: Tom Yan <tom.ty89@gmail.com>
>
> [...]
>
> MBR, Sergei
>
