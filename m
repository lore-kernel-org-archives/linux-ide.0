From: Baruch Even <baruch@ev-en.org>
Subject: Re: [PATCH 1/1] [libata] SCSI: really use SATL version in VPD
Date: Fri, 5 Apr 2013 17:51:31 +0300
Message-ID: <CAC9+an+9f+qng9JidvKOCQO6=2HEN4CRVfOA+-LQOrFm9b=tfQ@mail.gmail.com>
References: <1365162493-9415-1-git-send-email-baruch@ev-en.org> <515EE347.3040105@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ee0-f48.google.com ([74.125.83.48]:51040 "EHLO
	mail-ee0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161785Ab3DEOvw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 5 Apr 2013 10:51:52 -0400
Received: by mail-ee0-f48.google.com with SMTP id b15so1398459eek.7
        for <linux-ide@vger.kernel.org>; Fri, 05 Apr 2013 07:51:51 -0700 (PDT)
In-Reply-To: <515EE347.3040105@cogentembedded.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide <linux-ide@vger.kernel.org>

OK. Resending.

On Fri, Apr 5, 2013 at 5:44 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Hello.
>
> On 05-04-2013 15:48, Baruch Even wrote:
>
>> Commit message of c78968bb
>
>
>    Please also specify the summary line of that commit in parens (or however
> you like).
>
>
>> by Jeff Garzik says we need to provide the SATL
>> driver version and not the disk firmware version but the code overwrites
>> the
>> driver version with the disk version.
>
>
>> Signed-off-by: Baruch Even <baruch@ev-en.org>
>
>
> WBR, Sergei
>
