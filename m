From: Julien Didron <jdidron@tripnotik.dyndns.org>
Subject: Re: [PATCH try3] a better Silicon Image SATA mod15 write fix?
Date: Mon, 15 Mar 2004 21:03:26 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40560C0E.7060500@tripnotik.dyndns.org>
References: <4055D032.1090708@pobox.com> <4055EF4F.8060803@pobox.com> <4055F045.40102@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from alesia-4-82-66-59-64.fbx.proxad.net ([82.66.59.64]:9889 "HELO
	rooter.tripnotik.fr") by vger.kernel.org with SMTP id S262701AbUCOTIp
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 15 Mar 2004 14:08:45 -0500
In-Reply-To: <4055F045.40102@pobox.com>
List-Id: linux-ide@vger.kernel.org
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

Hello list,

    This driver works :o)
    running hdparm gives those results :
    Timing buffered disk reads:  170 MB in  3.00 seconds =  56.60 MB/sec 
(with 2.6.4-bk4 and sata_sil.c try 3)
    Timing buffered disk reads:  170 MB in  3.01 seconds =  56.56 MB/sec 
(with 2.6.4-mm2)

    running boonie on the 2.6.4-mm2 version hangs the computer, with no 
possibilities of doing anything (can't even use the magic SysRq keys), 
while on the 2.6.4-bk4 version using the patched version of sata_sil.c 
it doesn't exactly hang : it is still possible to switch from one 
console to another, but it's impossible to log into any of them (after 
typing in the password, you never get the prompt).
    here is the command I used :
    bonnie++ -u jdidron -d /tmp -x 10 -s 2g -n 32:30000:5:500 -m 
kisskool > output

Mobo : A7N8X Deluxe
HD : 6Y120L0

Jeff Garzik wrote:

> Sigh... it would help to disable the old errata fix.
>
> Try 3.
>

