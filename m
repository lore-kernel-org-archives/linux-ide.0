From: "Ryan Earl" <heretic@clanhk.org>
Subject: Re: siimage.c -serious- error fixed.  Performance/stability issues
     resolved.
Date: Tue, 2 Dec 2003 18:30:29 -0600 (CST)
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <33439.209.163.161.49.1070411429.squirrel@mail.clanhk.org>
References: <62929.67.101.15.58.1070362667.squirrel@mail.clanhk.org>
    <200312022016.13725.bzolnier@elka.pw.edu.pl>
    <33385.209.163.161.49.1070400815.squirrel@mail.clanhk.org>
    <200312030032.25783.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from palace.clanhk.org ([64.5.48.96]:42932 "EHLO mail.clanhk.org")
	by vger.kernel.org with ESMTP id S264461AbTLCAec (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 2 Dec 2003 19:34:32 -0500
In-Reply-To: <200312030032.25783.bzolnier@elka.pw.edu.pl>
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Ryan Earl <heretic@clanhk.org>, linux-ide@vger.kernel.org

> No, there is a REAL issue with Seagate SATA drives
> (more details in recent discussion on lkml and in lkml archives).
>
> Proper workaround (instead of limiting requests to 15kB) is underway.

Oh, OK.  I thought you were still talking about the siimage cludge, I was
confused about why you mentioned Seagate.  That sucks, doesn't Seagate
have the only native SATA interface (save for the new WD740GD maybe)? 
Aren't they going to be the first to support NCQ on SATA 2.0?  Guess I
should go check that thread.

> Yep, this explanaiton makes sense.
> It made me wonder why gcc doesn't emit warning for this case...

That is a good question.  I would guess that there is a limit to how deep
gcc persues type checking when making calls to function pointers.

-ryan
