From: Cong Wang <amwang@redhat.com>
Subject: Re: [PATCH 10/62] ata: remove the second argument of k[un]map_atomic()
Date: Tue, 29 Nov 2011 11:25:01 +0800
Message-ID: <4ED4508D.3020502@redhat.com>
References: <1322371662-26166-1-git-send-email-amwang@redhat.com>	 <1322371662-26166-11-git-send-email-amwang@redhat.com>	 <4ED35BFE.6080900@mvista.com> <4ED373C3.4050903@redhat.com>	 <4ED37541.4040701@redhat.com> <1322506812.5071.37.camel@dabdike.int.hansenpartnership.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:17632 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752499Ab1K2DZS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 28 Nov 2011 22:25:18 -0500
In-Reply-To: <1322506812.5071.37.camel@dabdike.int.hansenpartnership.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Sergei Shtylyov <sshtylyov@mvista.com>, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

=E4=BA=8E 2011=E5=B9=B411=E6=9C=8829=E6=97=A5 03:00, James Bottomley =E5=
=86=99=E9=81=93:
>
> I'd vote for as a whole as well, but if there's some legitimate reaso=
n
> why not, then take them through Jiri's trivial tree; it's pretty triv=
ial
> anyway and at least going that way would keep them bisectable.
>

Ok, I just made a branch which keeps these patches as a single one,

git://github.com/congwang/linux.git #kmap_atomic-single

As the single patch is 233K, so I don't send it to mailing list.

Thanks.
