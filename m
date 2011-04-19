From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH] libata: Pioneer DVR-216D can't do SETXFER
Date: Wed, 20 Apr 2011 01:05:07 +0400
Message-ID: <4DADF903.5000503@ru.mvista.com>
References: <4DADA69C.4060708@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:38246 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755596Ab1DSVGq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 Apr 2011 17:06:46 -0400
Received: by wya21 with SMTP id 21so91253wya.19
        for <linux-ide@vger.kernel.org>; Tue, 19 Apr 2011 14:06:45 -0700 (PDT)
In-Reply-To: <4DADA69C.4060708@suse.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Mahoney <jeffm@suse.com>
Cc: Jeff Garzik <jgarzik@redhat.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org

Hello.

On 19-04-2011 19:13, Jeff Mahoney wrote:

>   Commit 4a5610a04d415ed94af75bb1159d2621d62c8328 fixed an issue with

    Please also specify that commit's summary in parens -- for the human readers.

>   the Pioneer DVR-212D not handling SETXFER correctly. An openSUSE user
>   reported a similar issue with his DVR-216D that the NOSETXFER horkage
>   worked around for him as well.

>   This patch adds the DVR-216D (1.08) to the horkage list for NOSETXFER.

>   The issue was reported at:
>   https://bugzilla.novell.com/show_bug.cgi?id=679143

> Reported-by: Volodymyr Kyrychenko <vladimir.kirichenko@gmail.com>
> Signed-off-by: Jeff Mahoney <jeffm@suse.com>

WBR, Sergei
