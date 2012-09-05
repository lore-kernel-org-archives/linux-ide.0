From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: problem on harddisk
Date: Wed, 05 Sep 2012 16:09:29 +0400
Message-ID: <504740F9.7000304@mvista.com>
References: <CABmfJQYyYaZF0KQ4ZJt0Q8i95uZKvjsWR2ogwZfkrMstbpe-8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:55343 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758729Ab2IEMKn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Sep 2012 08:10:43 -0400
Received: by lbbgj3 with SMTP id gj3so304362lbb.19
        for <linux-ide@vger.kernel.org>; Wed, 05 Sep 2012 05:10:36 -0700 (PDT)
In-Reply-To: <CABmfJQYyYaZF0KQ4ZJt0Q8i95uZKvjsWR2ogwZfkrMstbpe-8g@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Paolo Minazzi <paolo.minazzi@gmail.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Hello.

On 05-09-2012 11:48, Paolo Minazzi wrote:

> Hi Jeff,
> I have a desktop PC with a SATA harddisk and a slackware 13.1 x86_64.

> In the last days I have seen a lot of problem on my console.
> Now I don't have the exact messages, but I saw

> ACC=0x11, ASCQ=0x05

    ASC=11h means "unrecovered read error", ASCQ further qualifies it as "L-EC 
uncorrectable error" which shouldn't be returned by hard disks. Are you sure 
you got this right?

> ......
> ....please be patiente
> reset ...

> I think it is not related to a bad hardware.

    Unfortunately, it seems your hard disk has bad sectors.

> I have tried an harddisk check program under DOS and it seems OK.

    Which DOS program you tried?

> On windows I don't have problems, or maybe there are no messages visible.

    Maybe there's no bad sectors on Windows partition...

MBR, Sergei

