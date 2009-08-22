From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: [PATCH #upstream] sata_sil24: always set protocol override for
	non-ATAPI data commands
Date: Sat, 22 Aug 2009 10:30:23 -0600
Message-ID: <51f3faa70908220930r44bf43dciba28f9890917875b@mail.gmail.com>
References: <4A71FE71.7040002@gmail.com> <4A8F88CC.1000406@gmail.com>
	 <4A8FFA9A.2020904@rtr.ca> <4A8FFC8A.1000500@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pz0-f194.google.com ([209.85.222.194]:45133 "EHLO
	mail-pz0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932924AbZHVQaW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 22 Aug 2009 12:30:22 -0400
Received: by pzk32 with SMTP id 32so324410pzk.33
        for <linux-ide@vger.kernel.org>; Sat, 22 Aug 2009 09:30:24 -0700 (PDT)
In-Reply-To: <4A8FFC8A.1000500@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Mark Lord <liml@rtr.ca>, ide <linux-ide@vger.kernel.org>, Tejun Heo <tj@kernel.org>

On Sat, Aug 22, 2009 at 8:11 AM, Jeff Garzik<jeff@garzik.org> wrote:
>> Hasn't this gone upstream yet??
>> Heck, it should even go out for -stable, too.
>
> It's queued for 2.6.32... =A0I'd rather be more conservative and get =
wider
> testing before pushing such a fundamental change to sata_sil24 data x=
fer
> path upon everyone.

I think .32 is fair, it's not impossible it could break something..
just making sure it didn't get dropped on the floor. If it works out
well it likely could be pushed to stable later though.
