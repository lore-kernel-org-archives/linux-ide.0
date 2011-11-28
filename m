From: Cong Wang <amwang@redhat.com>
Subject: Re: [PATCH 10/62] ata: remove the second argument of k[un]map_atomic()
Date: Mon, 28 Nov 2011 19:42:59 +0800
Message-ID: <4ED373C3.4050903@redhat.com>
References: <1322371662-26166-1-git-send-email-amwang@redhat.com> <1322371662-26166-11-git-send-email-amwang@redhat.com> <4ED35BFE.6080900@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:14354 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752255Ab1K1LnW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 28 Nov 2011 06:43:22 -0500
In-Reply-To: <4ED35BFE.6080900@mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

=E4=BA=8E 2011=E5=B9=B411=E6=9C=8828=E6=97=A5 18:01, Sergei Shtylyov =E5=
=86=99=E9=81=93:
> Hello.
>
> On 27-11-2011 9:26, Cong Wang wrote:
>
>> Signed-off-by: Cong Wang<amwang@redhat.com>
>> ---
>> drivers/ata/libata-sff.c | 8 ++++----
>> 1 files changed, 4 insertions(+), 4 deletions(-)
>
> IMO, you should do this in a single patch, not piecemeal to keep the =
kernel bisectable.
>

Hi,

Please see patch 01/62,

https://lkml.org/lkml/2011/11/28/35

So even without it, the kernel can still compile, just with some warnin=
gs.

Thanks.
